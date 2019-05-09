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
default_insertiondata_path = "main/db_util/default_itemstocks.json"

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

def parse_insertion_categories(filename=default_insertiondata_path):
    insertion_sql = []
    with open(filename, 'r') as file:
        data = json.load(file)
        for category in data["category"]:
            insertion_sql.append("INSERT INTO category(category_name) VALUES(\"{}\")".format(category["category_name"]))
    return insertion_sql

def parse_insertion_itemstocks(filename=default_insertiondata_path):
    insertion_sql = []
    with open(filename, 'r') as file:
        data = json.load(file)
        for itemstock in data["item_stock"]:
            insertion_sql.append("INSERT INTO item_stock(name, vendor, price, quantity, description, item_image_file) VALUES ("\
            + "\"{}\", \"{}\", {}, {}, \"{}\", \"{}\");".format(itemstock["name"], itemstock["vendor"], itemstock["price"], \
            itemstock["quantity"], itemstock["description"], itemstock["item_image_file"]))
    return insertion_sql



def insert_item(itemstock_id, was_bought=False):
    with connection.cursor() as cursor:
        cursor.execute("INSERT INTO item(stock_id, was_bought) VALUES(%s, %s)", [itemstock_id, was_bought])


if __name__ == "__main__":
    #print(parse_schema("main_schema.sql"))
    print(parse_insertion_itemstocks("default_itemstocks.json"))
    #print(parse_insertion_categories("default_itemstocks.json"))
