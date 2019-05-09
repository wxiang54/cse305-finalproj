from django.db import connection
import os

'''
def my_custom_sql(self):
    with connection.cursor() as cursor:
        cursor.execute("UPDATE bar SET foo = 1 WHERE baz = %s", [self.baz])
        cursor.execute("SELECT foo FROM bar WHERE baz = %s", [self.baz])
        row = cursor.fetchone()

    return row
'''

schema_path = "main/db_util/main_schema.sql"

def parse_schema():
    #print(os.path.dirname(os.path.abspath(__file__)))
    schema_sql = []

    with open(schema_path, 'r') as file:
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

#def parse_insertion_items()

def insert_item(itemstock_id, was_bought=False):
    with connection.cursor() as cursor:
        cursor.execute("INSERT INTO item VALUES (%s, %s)", [itemstock_id, was_bought])


if __name__ == "__main__":
    print(parse_schema())
