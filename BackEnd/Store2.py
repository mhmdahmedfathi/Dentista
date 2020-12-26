from Verifications import Validator
from flask import request
from SQLAPI import SQL
# ------------------------------------------------------------------------------------------------------------------------------
# Connection Arguments of the database
server_name = "dentista1.mysql.database.azure.com"
server_admin = "dentista@dentista1"
server_password = "@dentist1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]
# --------------------------------------------------------------------------------------------------------------------------------

# Insertion of the Store

def Store2_insertion():
    columns = ['Store_ID', 'ADDRESS', 'REGION', 'CITY', 'ZIP_CODE']
    values = []
    for key in columns:
        values.append(request.json[key])
    connector = SQL(host=server_name, user=server_admin)
    Query = "SELECT  STORE_ID FROM STORE WHERE STORE_NAME = '" + values[0]+"'"
    values[0] = connector.exectute_query(Query)
    connector.insert_query(table = 'STORE_BRANCH', attributes=columns, values=values)
    connector.close_connection()
    return "1"

# -----------------------------------------------------------------------------------------------------------------------------------------

