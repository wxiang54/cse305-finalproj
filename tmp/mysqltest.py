import mysql.connector

cnx = mysql.connector.connect(user='root', password='root',
                              host='localhost', database='storedb')

cursor = cnx.cursor()
query = ("SELECT * FROM item_stock")
cursor.execute(query)
for item_stock in cursor:
    print(item_stock)
cursor.execute("SHOW TABLES")
for table in cursor.fetchall():
    print(table)
cursor.close()
cnx.close()