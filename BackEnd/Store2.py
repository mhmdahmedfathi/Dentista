from Verifications import Validator
from flask import request
from SQLAPI import SQL
# ------------------------------------------------------------------------------------------------------------------------------
# Connection Arguments of the database
server_name = "localhost"
server_admin = "root"
server_password = "@dentist1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]
# --------------------------------------------------------------------------------------------------------------------------------

# Insertion of the Store

def Store2_insertion():
    columns = ['STORE_ID', 'ADDRESS', 'REGION', 'CITY', 'ZIP_CODE']
    values = []
    for key in columns:
        values.append(request.json[key])
    connector = SQL(host=server_name, user=server_admin)
    StoreIDColumn = ['STORE_ID']
    condition = "STORE_NAME = '" + values[0]+"'"
    StoreID= connector.select_query(table='STORE',columns=StoreIDColumn,sql_condition=condition)
    values[0]=(",".join(repr(e) for e in StoreID['STORE_ID']))
    print(values)
    print(columns)
    connector.insert_query(table = 'STORE_BRANCH', attributes=columns, values=values)
    connector.close_connection()
    return "1"

# -----------------------------------------------------------------------------------------------------------------------------------------

