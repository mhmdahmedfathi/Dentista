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

# Insertion of the Dentist

def dentist_insertion():
    columns = ['DENTIST_Fname', 'DENTIST_LNAME', 'DENTIST_EMAIL', 'DENTIST_PASSWORD', 'DENTIST_PHONE_NUMBER', 'DENTIST_ADDRESS', 'DENTIST_ZIP_CODE', 'DENTIST_REGION', 'DENTIST_CITY', 'DENTIST_CREDIT_CARD_NUMBER']
    values = []
    for key in columns:
        values.append(request.json[key])
    connector = SQL(host=server_name, user=server_admin)
    connector.insert_query(table = 'DENTIST', attributes=columns, values=values)
    connector.close_connection()
    return "1"

# --------------------------------------------------------------------------------------------------------------------------------

# Validations of the Dentist
def dentist_email_validation():
    validator = Validator(connection_details, 'DENTIST')
    return validator.email_validation('DENTIST_EMAIL')

def dentist_phone_validation():
    validator = Validator(connection_details, 'DENTIST')
    return validator.phone_validation('DENTIST_PHONE_NUMBER')

def dentist_CreditCard_validation():
    validator = Validator(connection_details, 'DENTIST')
    return validator.CreditCard_validation('DENTIST_CREDIT_CARD_NUMBER')
# -----------------------------------------------------------------------------------------------------------------------------------------

