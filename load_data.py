import sqlite3
from pathlib import Path
import pandas as pd

RAW = Path("data/raw")
DB = "olist.db"

TABLAS = {
    "orders": "olist_orders_dataset.csv",
    "customers": "olist_customers_dataset.csv",
    "order_items": "olist_order_items_dataset.csv",
    "reviews": "olist_order_reviews_dataset.csv",
    "payments": "olist_order_payments_dataset.csv",
    "products": "olist_products_dataset.csv",
    "category_translation": "product_category_name_translation.csv",
}

with sqlite3.connect(DB) as conn:
    for nombre, archivo in TABLAS.items():
        df = pd.read_csv(RAW / archivo, encoding="utf-8-sig")
        df.to_sql(nombre, conn, if_exists="replace", index=False)
        print(f"{nombre}: {len(df):,} filas cargadas")