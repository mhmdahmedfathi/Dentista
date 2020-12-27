from SQLAPI import SQL
from flask import request
import json

# ------------------------------------------------------------------------------------------------------------------------------
# Connection Arguments of the database
server_name = "dentista1.mysql.database.azure.com"
server_admin = "dentista@dentista1"
server_password = "@dentist1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]
# --------------------------------------------------------------------------------------------------------------------------------

def LogIn():
    email = request.json['email']
    password = request.json['password']
    sql = SQL(server_name,server_admin, server_password)
    condition = "email = '" +email + "' and password = '" + password + "'"
    result = sql.select_query(table = 'LOGIN_DATA', columns=['AccountType'], sql_condition=condition)
    sql.close_connection()
    if result['AccountType'] == {}:
        return 'None'
    return result['AccountType'][0]

def GetName():
    email = request.json['email']
    AccountType = request.json['AccountType']
    sql = SQL(server_name,server_admin, server_password)
    if AccountType == 'Dentist':
        condition = "DENTIST_EMAIL = '" +email +  "'"
        result = sql.select_query(table = 'DENTIST', columns=['DENTIST_Fname', 'DENTIST_LNAME'], sql_condition=condition)
        result = {'fname': result['DENTIST_Fname'][0], 'lname': result['DENTIST_LNAME'][0]}
        return json.dumps(result)
    elif AccountType == 'Delivery':
        condition = "DELIVERY_EMAIL = '" + email + "'"
        result = sql.select_query(table='DELIVERY', columns=['DELIVERY_Fname', 'DELIVERY_Lname', 'AREA', 'DELIVERY_ID' ] ,sql_condition= condition)
        result ={'fname': result['DELIVERY_Fname'][0], 'lname': result['DELIVERY_Lname'][0], 'area': result['AREA'][0], 'id': result['DELIVERY_ID'][0]}
        return json.dumps(result)
        



