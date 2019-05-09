from django.db import connection
import os
import json

'''
def my_custom_sql(self):
    with connection.cursor() as cursor:
        cursor.execute("UPDATE bar SET foo = 1 WHERE baz = %s", [self.baz])
        cursor.execute("SELECT foo FROM bar WHERE baz = %s", [self.baz])
        row = cursor.fetchone()

    return row
'''

schema_path = "main/db_util/main_schema.sql"
default_insertiondata_path = "main/db_util/default_data.json"

def execute_sql_many(sql_list):
    with connection.cursor() as cursor:
        for statement in sql_list:
            cursor.execute(statement)

def dictfetchall(cursor):
    "Return all rows from a cursor as a dict"
    columns = [col[0] for col in cursor.description]
    return [
        dict(zip(columns, row))
        for row in cursor.fetchall()
    ]

def parse_schema(filename=schema_path):
    schema_sql = []
    with open(filename, 'r') as file:
        data = file.read().split("\n")
        reading_sql = False
        cur_statement = ""
        for line in data:
            line = line.strip()
            if line == '':
                continue
            if line == "/* START */":
                reading_sql = True
                continue
            if line == "/* END */":
                reading_sql = False
                schema_sql.append(cur_statement)
                cur_statement = ""
                continue
            if reading_sql:
                cur_statement += line + " "
    return schema_sql

def parse_schema_drop(filename=schema_path):
    schema_sql = []
    table_names = []
    with open(filename, 'r') as file:
        data = file.read().split("\n")
        for line in data:
            line = line.strip()
            if line == '':
                continue
            if line.split(" ")[:2] == ["CREATE", "TABLE"]:
                table_names.append(line.split(" ")[2])
    schema_sql.append("ALTER TABLE ordr DROP FOREIGN KEY ordr_shipment;")
    for table_name in table_names[::-1]:
        schema_sql.append("DROP TABLE {};".format(table_name))
    return schema_sql

def parse_insertion_itemstocks(filename=default_insertiondata_path):
    insertion_sql = []
    with open(filename, 'r') as file:
        data = json.load(file)
        for itemstock in data["item_stock"]:
            insertion_sql.append("INSERT INTO item_stock(stock_id, name, vendor, price, quantity, description, item_image_file) VALUES ("\
            + "\"{}\", \"{}\", \"{}\", {}, {}, \"{}\", \"{}\");".format(itemstock["stock_id"], itemstock["name"], itemstock["vendor"], \
            itemstock["price"], itemstock["quantity"], itemstock["description"], itemstock["item_image_file"]))
    return insertion_sql

def parse_insertion_categories(filename=default_insertiondata_path):
    insertion_sql = []
    with open(filename, 'r') as file:
        data = json.load(file)
        for category in data["category"]:
            insertion_sql.append("INSERT INTO category(category_name, display_name) VALUES(\"{}\", \"{}\");"\
            .format(category["category_name"], category["display_name"]))
    return insertion_sql

def parse_insertion_stockcategories(filename=default_insertiondata_path):
    insertion_sql = []
    with open(filename, 'r') as file:
        data = json.load(file)
        for stockcategory in data["stock_category"]:
            insertion_sql.append("INSERT INTO stock_category(stock_id, category_name) VALUES({}, \"{}\");"\
            .format(stockcategory["stock_id"], stockcategory["category_name"]))
    return insertion_sql

def parse_insertion_items(filename=default_insertiondata_path, bought=False):
    insertion_sql = []
    if bought:
        was_bought = "true"
    else:
        was_bought = "false"
    with open(filename, 'r') as file:
        data = json.load(file)
        for itemstock in data["item_stock"]:
            quantity = itemstock["quantity"]
            for i in range(quantity):
                insertion_sql.append("INSERT INTO item(stock_id, was_bought) VALUES ({}, {});"\
                .format(itemstock["stock_id"], was_bought))
    return insertion_sql

def parse_insertion_truncate(filename=default_insertiondata_path):
    truncate_sql = []
    truncate_sql.append("DELETE FROM item;")
    with open(filename, 'r') as file:
        data = json.load(file)
        for table_name in data.keys():
            truncate_sql.append("DELETE FROM {};".format(table_name))
    return truncate_sql

def insert_item(itemstock_id, was_bought=False):
    with connection.cursor() as cursor:
        cursor.execute("INSERT INTO item(stock_id, was_bought) VALUES(%s, %s);", [itemstock_id, was_bought])
    return dictfetchall(cursor)

def search_itemstock(keyword=None):
    if keyword is None:
        keyword = "%"
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM item_stock WHERE name LIKE %s;", [keyword])
        data = dictfetchall(cursor)
    return data

def add_customer():
    pass

def authenticate_customer():
    pass

def add_shopping_cart():
    pass



if __name__ == "__main__":
    #print(parse_schema("main_schema.sql"))
    #print(parse_schema_drop("main_schema.sql"))
    #print(parse_insertion_itemstocks("default_data.json"))
    #print(parse_insertion_categories("default_data.json"))
    #print(parse_insertion_stockcategories("default_data.json"))
    #print(parse_insertion_truncate("default_data.json"))
    #print(parse_insertion_items("default_data.json"))
    pass
