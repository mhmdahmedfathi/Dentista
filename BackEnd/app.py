from flask import Flask, jsonify, request
import numpy as np
from SQLAPI import SQL
import json
from validate_email import validate_email
#import pyodbc
app = Flask(__name__)


server = "dentista1.mysql.database.azure.com"

database = 'DENTISTA'

username = 'dentista@dentista1'

password = '@dentist1'

driver= '{ODBC Driver 17 for SQL Server}'
'''
@app.route("/")
def welcome():
    return "Hello, World!"

'''

server_name = "dentista1.mysql.database.azure.com"
server_admin = "dentista@dentista1"
server_password = "@dentist1"
database = "DENTISTA"

@app.route("/", methods=['POST'])
def Dentist():
    columns = ['DENTIST_Fname', 'DENTIST_LNAME', 'DENTIST_EMAIL', 'DENTIST_PASSWORD', 'DENTIST_PHONE_NUMBER', 'DENTIST_ADDRESS', 'DENTIST_ZIP_CODE', 'DENTIST_REGION', 'DENTIST_CITY', 'DENTIST_CREDIT_CARD_NUMBER']
    values = []
    for key in columns:
        values.append(request.json[key])
    connector = SQL(host=server_name, user=server_admin)
    connector.insert_query(table = 'DENTIST', attributes=columns, values=values)
    connector.close_connection()
    #print(values)
    return "Hello"


@app.route("/email_validation", methods = ['POST'])
def email_validate():

    email = request.json['email']
    connector = SQL(host=server_name, user=server_admin)
    print(email)
    condition = "DENTIST_EMAIL = '" + email + "'"
    output = connector.select_query(table='DENTIST', columns=['DENTIST_ID'], sql_condition= condition)
    print(output)
    connector.close_connection()
    valid_state = '0'
    if output['DENTIST_ID'] == [] and validate_email(email):
        valid_state = '1'
        
    return valid_state

@app.route("/phone_validation", methods = ['POST'])
def phone_validate():

    phone = request.json['phone']
    connector = SQL(host=server_name, user=server_admin)
    print(phone)
    condition = "DENTIST_PHONE_NUMBER = '" + phone + "'"
    output = connector.select_query(table='DENTIST', columns=['DENTIST_ID'], sql_condition= condition)
    print(output)
    connector.close_connection()
    valid_state = '0'
    if output['DENTIST_ID'] == [] :
        valid_state = '1'
        
    return valid_state



def run_server(debug=False):
    app.run(debug=debug)

if __name__ == "__main__":
    run_server(debug=False)





