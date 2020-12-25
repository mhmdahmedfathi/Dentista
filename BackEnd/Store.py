from Verifications import Validator
from flask import request
from SQLAPI import SQL
# ------------------------------------------------------------------------------------------------------------------------------
# Connection Arguments of the database
server_name = "Dentista"
server_admin = "root"
server_password = "@dentist1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]
# --------------------------------------------------------------------------------------------------------------------------------

# Insertion of the Store

def Store_insertion():
    columns = ['Store_ID', 'Store_Name', 'Email', 'Password', 'Phone_Number', 'Credit_Card_Number', 'Manager_ID']
    values = []
    for key in columns:
        values.append(request.json[key])
    connector = SQL(host=server_name, user=server_admin)
    connector.insert_query(table = 'STORE', attributes=columns, values=values)
    connector.close_connection()
    return "1"

# --------------------------------------------------------------------------------------------------------------------------------

# Validations of the Store
def Store_ID_validation():
    validator = Validator(connection_details, 'STORE')
    return validator.email_validation('Store_ID')

def Manager_ID_validation():
    validator = Validator(connection_details, 'STORE')
    return validator.email_validation('Manager_ID')

def Store_Name_validation():
    validator = Validator(connection_details, 'STORE')
    return validator.email_validation('Store_Name')


def Store_email_validation():
    validator = Validator(connection_details, 'STORE')
    return validator.email_validation('Email')

def Store_phone_validation():
    validator = Validator(connection_details, 'STORE')
    return validator.phone_validation('Phone_Number')

def Store_CreditCard_validation():
    validator = Validator(connection_details, 'STORE')
    return validator.CreditCard_validation('Credit_Card_Number')
# -----------------------------------------------------------------------------------------------------------------------------------------

