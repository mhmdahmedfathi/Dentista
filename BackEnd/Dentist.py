from Verifications import Validator
from flask import request
from SQLAPI import SQL
import json
# ------------------------------------------------------------------------------------------------------------------------------
# Connection Arguments of the database

'''
server_name = "dentista1.mysql.database.azure.com"
server_admin = "dentista@dentista1"
server_password = "@dentist1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]
'''

server_name = "localhost"
server_admin = "root"
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

def UpdateDentistTable():

    columns_dic = request.json['dic']
    DentistID = request.json["DID"]
    condition = "DENTIST_ID = " +str(DentistID) 
     
    connector = SQL(server_name,server_admin)
    connector.update_query(table='Dentist' ,columns_values_dict= columns_dic,sql_condition=condition)
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

def GetDentist():
    email = request.json['email']
    sql = SQL(host=server_name, user=server_admin)
    results = sql.select_query('DENTIST', ['DENTIST_ID', 'DENTIST_Fname', 'DENTIST_LNAME', 'DENTIST_PASSWORD', 'DENTIST_PHONE_NUMBER', 'DENTIST_ADDRESS', 'DENTIST_ZIP_CODE', 'DENTIST_REGION', 'DENTIST_CITY', 'DENTIST_CREDIT_CARD_NUMBER', 'DENTIST_IMAGE_URL'], f"DENTIST_EMAIL = '{email}'")
    Outputs = {}
    Outputs['DentistID'] = results['DENTIST_ID'][0]
    Outputs['DentistFname'] = results['DENTIST_Fname'][0]
    Outputs['DentistLname'] = results['DENTIST_LNAME'][0]
    Outputs['DentistAddress'] = results['DENTIST_ADDRESS'][0]
    Outputs['DentistCity'] = results['DENTIST_CITY'][0]
    Outputs['DentistRegion'] = results['DENTIST_REGION'][0]
    Outputs['DentistImageURL'] = results['DENTIST_IMAGE_URL'][0]
    Outputs['DentistCreditCardNumber'] = results['DENTIST_CREDIT_CARD_NUMBER'][0]
    Outputs['DentistPassword'] = results['DENTIST_PASSWORD'][0]
    Outputs['DentistPhoneNumber'] = results['DENTIST_PHONE_NUMBER'][0]
    Outputs['DentistZipCode'] = results['DENTIST_ZIP_CODE'][0]
    sql.close_connection()

    return json.dumps(Outputs)


def UpdateDentistImage():
    ImageURL = request.json['ImageURL']
    DentistID = request.json['DentistID']
    Query = f"Update DENTIST SET DENTIST_IMAGE_URL = '{ImageURL}' WHERE DENTIST_ID = {DentistID};"
    sql = SQL(host=server_name, user=server_admin)
    sql.exectute_query(Query)
    sql.close_connection()
    return '1'

