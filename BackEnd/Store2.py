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

def Store_insertion():
    columns = ['Store_ID', 'ADDRESS', 'REGION', 'CITY', 'ZIP_CODE']
    values = []
    for key in columns:
        values.append(request.json[key])
    connector = SQL(host=server_name, user=server_admin)
    connector.insert_query(table = 'STORE_BRANCH', attributes=columns, values=values)
    connector.close_connection()
    return "1"

# --------------------------------------------------------------------------------------------------------------------------------

# Validations of the Store
def Store_ID_validation():
    validator = Validator(connection_details, 'STORE_BRANCH')
    return validator.email_validation('Store_ID')

def ADDRESS_validation():
    validator = Validator(connection_details, 'STORE_BRANCH')
    return validator.email_validation('ADDRESS')

def REGION_validation():
    validator = Validator(connection_details, 'STORE_BRANCH')
    return validator.email_validation('REGION')


def CITY_validation():
    validator = Validator(connection_details, 'STORE_BRANCH')
    return validator.email_validation('CITY')

def ZIP_CODE_validation():
    validator = Validator(connection_details, 'STORE_BRANCH')
    return validator.phone_validation('ZIP_CODE')

# -----------------------------------------------------------------------------------------------------------------------------------------

