import pandas as pd

# Заміни шлях, якщо файл в іншому місці
df = pd.read_csv("/Users/okutnyi/Desktop/archive/raw_customers.csv")

print("🧾 Columns:", df.columns.tolist())
print("\n🔍 Data Types:")
print(df.dtypes)

print("\n📦 Sample rows:")
print(df.head(5))
