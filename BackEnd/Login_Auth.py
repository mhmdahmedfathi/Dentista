from SQLAPI import SQL
from flask import request
import json

# ------------------------------------------------------------------------------------------------------------------------------
# Connection Arguments of the database
#server_name = "dentista1.mysql.database.azure.com"
#server_admin = "dentista@dentista1"
#server_password = "@dentist1"
database = "DENTISTA"
# ------------------------------------------------------------------------------------------------------------------------------
#Connection Arguments of the Local database
server_name = "localhost"
server_admin = "root"
server_password = "@dentista1"
database = "DENTISTA"



connection_details = [server_name, server_admin, server_password, database]
# --------------------------------------------------------------------------------------------------------------------------------

def LogIn():
    email = request.json['email']
    password = request.json['password']
    sql= SQL(host=server_name, user=server_admin,password=server_password)
    condition = "email = '" +email + "' and Password = '" + password + "'"
    result = sql.select_query(table = 'LOGIN_DATA', columns=['AccountType'], sql_condition=condition)
    sql.close_connection()
    if result['AccountType'] == {}:
        return 'None'
    return result['AccountType'][0]

def GetName():
    email = request.json['email']
    AccountType = request.json['AccountType']
    sql= SQL(host=server_name, user=server_admin,password=server_password)
    if AccountType == 'Dentist':
        condition = "DENTIST_EMAIL = '" +email +  "'"
        result = sql.select_query(table = 'DENTIST', columns=['DENTIST_Fname', 'DENTIST_LNAME'], sql_condition=condition)
        result = {'fname': result['DENTIST_Fname'][0], 'lname': result['DENTIST_LNAME'][0]}
        return json.dumps(result)
    elif AccountType == 'Delivery':
        condition = "DELIVERY_EMAIL = '" + email + "'"
        result = sql.select_query(table='DELIVERY', columns=['DELIVERY_Fname', 'DELIVERY_Lname', 'AREA', 'DELIVERY_ID', 'Delivery_PHONE_NUMBER', 'NUMBER_OF_DORDERS', 'DELIVERY_EMAIL', 'VECHILE_MODEL', 'VECHILE_LICENCE', 'RATE', 'AVAILABLE', 'DELIVERY_IMAGE_URL'] ,sql_condition= condition)
        result ={'fname': result['DELIVERY_Fname'][0], 'lname': result['DELIVERY_Lname'][0], 'area': result['AREA'][0], 'id': result['DELIVERY_ID'][0], 'phone': result['Delivery_PHONE_NUMBER'][0],'ordersnumber': result['NUMBER_OF_DORDERS'][0], 'email':result['DELIVERY_EMAIL'][0],'Vmodel': result['VECHILE_MODEL'][0], 'Vlicense': result['VECHILE_LICENCE'][0], 'rate': result['RATE'][0],'availablity': result['AVAILABLE'][0], 'ImageURL' : result['DELIVERY_IMAGE_URL'][0]}
        return json.dumps(result)
    elif AccountType == 'Manager':
        condition = "MANAGER_EMAIL = '" + email + "'"
        result = sql.select_query(table='MANAGER' , columns=['MANAGER_ID','MANAGER_Fname','MANAGER_Lname','MANAGEMENT_TYPE','AREA_OF_MANAGEMENT', 'MANAGER_IMAGE_URL'] , sql_condition=condition)
        result = {'M_ID':result['MANAGER_ID'][0],'fname' : result['MANAGER_Fname'][0] , 'lname': result['MANAGER_Lname'][0],'M_Type': result['MANAGEMENT_TYPE'][0],'M_Area': result['AREA_OF_MANAGEMENT'][0], 'M_IMG' : result['MANAGER_IMAGE_URL'][0]}
        return json.dumps(result)
    elif AccountType == 'Store':
        condition = "EMAIL = '" + email + "'"
        result = sql.select_query(table='store' , columns=['STORE_NAME','STORE_ID'] , sql_condition=condition)
        result = {'Store_Name' : result['STORE_NAME'][0],'STORE_ID' : result['STORE_ID'][0]}
        return json.dumps(result)
    sql.close_connection()
    



