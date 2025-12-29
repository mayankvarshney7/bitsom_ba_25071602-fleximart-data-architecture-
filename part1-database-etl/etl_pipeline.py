"""
ETL Pipeline for FlexiMart
-------------------------
Extracts raw CSV data, cleans and transforms it, and loads it into the
FlexiMart relational database using the provided schema.

Input files (expected in ./data):
- customers_raw.csv
- products_raw.csv
- sales_raw.csv

Output:
- data_quality_report.txt
- etl.log
"""

import os
import logging
import pandas as pd
import mysql.connector
from datetime import datetime

# =========================
# CONFIGURATION
# =========================
DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "your_password",
    "database": "fleximart"
}

DATA_DIR = "data"
CUSTOMERS_CSV = os.path.join(DATA_DIR, "customers_raw.csv")
PRODUCTS_CSV = os.path.join(DATA_DIR, "products_raw.csv")
SALES_CSV = os.path.join(DATA_DIR, "sales_raw.csv")

# =========================
# LOGGING
# =========================
logging.basicConfig(
    filename="etl.log",
    level=logging.INFO,
    format="%(asctime)s | %(levelname)s | %(message)s"
)

# =========================
# DATA QUALITY METRICS
# =========================
dq = {
    "customers": {"processed": 0, "duplicates_removed": 0, "missing_handled": 0, "loaded": 0},
    "products": {"processed": 0, "duplicates_removed": 0, "missing_handled": 0, "loaded": 0},
    "sales": {"processed": 0, "duplicates_removed": 0, "missing_handled": 0, "loaded": 0}
}

# =========================
# HELPER FUNCTIONS
# =========================
def standardize_phone(phone):
    if pd.isna(phone):
        return None
    digits = "".join(filter(str.isdigit, str(phone)))
    return f"+91-{digits[-10:]}" if len(digits) >= 10 else None

def standardize_category(cat):
    if pd.isna(cat):
        return "Unknown"
    return str(cat).strip().title()

def parse_date_safe(value):
    try:
        return pd.to_datetime(value).date()
    except Exception:
        return None

# =========================
# DATABASE CONNECTION
# =========================
def get_connection():
    return mysql.connector.connect(**DB_CONFIG)

# =========================
# EXTRACT
# =========================
customers_df = pd.read_csv(CUSTOMERS_CSV)
products_df = pd.read_csv(PRODUCTS_CSV)
sales_df = pd.read_csv(SALES_CSV)

dq["customers"]["processed"] = len(customers_df)
dq["products"]["processed"] = len(products_df)
dq["sales"]["processed"] = len(sales_df)

# =========================
# TRANSFORM – CUSTOMERS
# =========================
before = len(customers_df)
customers_df.drop_duplicates(inplace=True)
dq["customers"]["duplicates_removed"] = before - len(customers_df)

missing_emails = customers_df["email"].isna().sum()
customers_df["email"] = customers_df.apply(
    lambda r: r["email"]
    if pd.notna(r["email"])
    else f"unknown_{r.name}@fleximart.com",
    axis=1
)

customers_df["phone"] = customers_df["phone"].apply(standardize_phone)
customers_df["city"] = customers_df["city"].astype(str).str.title()
customers_df["registration_date"] = customers_df["registration_date"].apply(parse_date_safe)

dq["customers"]["missing_handled"] = int(missing_emails)

# =========================
# TRANSFORM – PRODUCTS
# =========================
before = len(products_df)
products_df.drop_duplicates(inplace=True)
dq["products"]["duplicates_removed"] = before - len(products_df)

# Fill missing prices with overall mean (acceptable default)
price_mean = products_df["price"].mean()
products_df["price"].fillna(price_mean, inplace=True)

products_df["stock_quantity"].fillna(0, inplace=True)
products_df["category"] = products_df["category"].apply(standardize_category)

dq["products"]["missing_handled"] = int(products_df.isna().sum().sum())

# =========================
# TRANSFORM – SALES
# =========================
before = len(sales_df)
sales_df.drop_duplicates(inplace=True)
dq["sales"]["duplicates_removed"] = before - len(sales_df)

sales_df["order_date"] = sales_df["order_date"].apply(parse_date_safe)

# Drop rows with missing foreign keys (cannot be loaded safely)
before_fk = len(sales_df)
sales_df.dropna(subset=["customer_id", "product_id"], inplace=True)
dq["sales"]["missing_handled"] = before_fk - len(sales_df)

# =========================
# LOAD
# =========================
conn = get_connection()
cursor = conn.cursor()

try:
    # ---- Load CUSTOMERS ----
    for _, r in customers_df.iterrows():
        try:
            cursor.execute(
                """
                INSERT INTO customers
                (first_name, last_name, email, phone, city, registration_date)
                VALUES (%s, %s, %s, %s, %s, %s)
                """,
                (
                    r["first_name"],
                    r["last_name"],
                    r["email"],
                    r["phone"],
                    r["city"],
                    r["registration_date"]
                )
            )
            dq["customers"]["loaded"] += 1
        except Exception as e:
            logging.error(f"Customer insert failed: {e}")

    conn.commit()

    # ---- Load PRODUCTS ----
    for _, r in products_df.iterrows():
        try:
            cursor.execute(
                """
                INSERT INTO products
                (product_name, category, price, stock_quantity)
                VALUES (%s, %s, %s, %s)
                """,
                (
                    r["product_name"],
                    r["category"],
                    float(r["price"]),
                    int(r["stock_quantity"])
                )
            )
            dq["products"]["loaded"] += 1
        except Exception as e:
            logging.error(f"Product insert failed: {e}")

    conn.commit()

    # ---- Load ORDERS & ORDER_ITEMS ----
    for _, r in sales_df.iterrows():
        try:
            cursor.execute(
                """
                INSERT INTO orders
                (customer_id, order_date, total_amount, status)
                VALUES (%s, %s, %s, %s)
                """,
                (
                    int(r["customer_id"]),
                    r["order_date"],
                    float(r["total_amount"]),
                    "Completed"
                )
            )
            order_id = cursor.lastrowid

            cursor.execute(
                """
                INSERT INTO order_items
                (order_id, product_id, quantity, unit_price, subtotal)
                VALUES (%s, %s, %s, %s, %s)
                """,
                (
                    order_id,
                    int(r["product_id"]),
                    int(r["quantity"]),
                    float(r["unit_price"]),
                    float(r["quantity"] * r["unit_price"])
                )
            )

            dq["sales"]["loaded"] += 1
        except Exception as e:
            logging.error(f"Sales insert failed: {e}")

    conn.commit()

finally:
    cursor.close()
    conn.close()

# =========================
# DATA QUALITY REPORT
# =========================
with open("data_quality_report.txt", "w") as f:
    for table, metrics in dq.items():
        f.write(f"{table.upper()} DATA REPORT\n")
        for k, v in metrics.items():
            f.write(f"{k}: {v}\n")
        f.write("\n")

print("ETL pipeline executed successfully.")

