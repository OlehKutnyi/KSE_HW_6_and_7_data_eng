import duckdb

con = duckdb.connect('grocery_sales.duckdb')
result = con.execute("DESCRIBE SELECT * FROM raw_customers").fetchall()

for row in result:
    print(row)
