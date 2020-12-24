from Verifications import Validator
from flask import request
from SQLAPI import SQL
# ------------------------------------------------------------------------------------------------------------------------------
# Connection Arguments of the database
server_name = "dentista1.mysql.database.azure.com"
server_admin = "dentista@dentista1"
server_password = "Itachionly#1"
database = "DENTISTA"
#server_name = "127.0.0.1"
#server_admin = "root"
#server_password = "Itachionly#1"
#database = "dantista"
connection_details = [server_name, server_admin, server_password, database]
# --------------------------------------------------------------------------------------------------------------------------------

# Insertion of the Dentist

def Delivery_insertion():
    connector = SQL(host=server_name, user=server_admin)
    columns = ['DELIVERY_Fname', 'DELIVERY_Lname', 'DELIVERY_EMAIL', 'DELIVERY_PASSWORD', 'DELIVERY_CREDIT_CARD_NUMBER', 'AREA', 'VECHILE_LICENCE', 'VECHILE_MODEL','Delivery_PHONE_NUMBER']
    values = []
    for key in columns:
        values.append(request.json[key])

    #Searching for manager ID first who is managing Deliverues and the same area
    ManagerIDColumn = ['MANAGER_ID']
    #ManagerIDColumn = ['*']
    condition ="MANAGEMENT_TYPE = 'Delivery' and AREA_OF_MANAGEMENT = '"+values[5]+"'"
    ManagerID= connector.select_query(table='MANAGER',columns=ManagerIDColumn,sql_condition=condition)

    columns.append('MANAGER_ID')
    values.append(",".join(repr(e) for e in ManagerID['MANAGER_ID']))
    columns.append('AVAILABLE')
    values.append(0)
    columns.append('RATE')
    values.append(0)


    connector.insert_query(table = 'DELIVERY', attributes=columns, values=values)
    connector.close_connection()
    return "1"

# --------------------------------------------------------------------------------------------------------------------------------

# Validations of the Dentist
def Delivery_email_validation():
    validator = Validator(connection_details, 'DELIVERY')
    return validator.email_validation('DELIVERY_EMAIL')

def Delivery_CreditCard_validation():
    validator = Validator(connection_details, 'DELIVERY')
    return validator.CreditCard_validation('DELIVERY_CREDIT_CARD_NUMBER')

def Delivery_PhoneNumber_validator():
    validator = Validator(connection_details,'DELIVERY')
    return validator.phone_validation('Delivery_PHONE_NUMBER')

# -----------------------------------------------------------------------------------------------------------------------------------------

