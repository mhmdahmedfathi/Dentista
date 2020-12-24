from Verifications import Validator
from flask import request
from SQLAPI import SQL
# ------------------------------------------------------------------------------------------------------------------------------
#Setting Connection Up
server_name = 'localhost'
server_admin= 'root'
server_password = 'test123'
database = 'dentista'
connection_details = [server_name , server_admin , server_password , database]
# ------------------------------------------------------------------------------------------------------------------------------
#Manager Insertion
def Manager_Insertion():
    cloumns = ['MANAGER_Fname','MANAGER_Lname','MANAGER_EMAIL' ,'MANAGER_PASSWORD','MANAGEMENT_TYPE','AREA_OF_MANAGEMENT']
    values =[]
    for key in cloumns:
        values.append(request.json[key])
    connector = SQL(server_name,server_name,server_password)
    connector.insert_query(table='Manager' ,attributes=cloumns, values=values)
    connector.close_connection()
    return "1"
# ------------------------------------------------------------------------------------------------------------------------------
#Validation of Manager

def Manager_email_validator():
    validator = Validator(connection_details , 'Manager')
    return validator.email_validation('MANAGER_EMAIL')
