from flask import request
from SQLAPI import SQL
import json
from validate_email import validate_email


server_name = "localhost"
server_admin = "root"
server_password = "@dentista1"
database = "dentista"
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



def email_validate():

    email = request.json['email']
    connector = SQL(host=server_name, user=server_admin,password=server_password)
    condition = "DENTIST_EMAIL = '" + email + "'"
    output = connector.select_query(table='DENTIST', columns=['DENTIST_ID'], sql_condition= condition)
    connector.close_connection()
    valid_state = '0'
    if output['DENTIST_ID'] == [] and validate_email(email):
        valid_state = '1'
        
    return valid_state

def phone_validate():

    phone = request.json['phone']
    connector = SQL(host=server_name, user=server_admin,password=server_password)

    condition = "DENTIST_PHONE_NUMBER = '" + phone + "'"
    output = connector.select_query(table='DENTIST', columns=['DENTIST_ID'], sql_condition= condition)

    connector.close_connection()
    valid_state = '0'
    if output['DENTIST_ID'] == [] :
        valid_state = '1'
        
    return valid_state


class Validator:

    def __init__(self, connection_details, table): #Constructor

        # connection_details: is a python list with the following connection string for the database [host, user, password, database]
        # table: the name of the table that the validation need to be done to
        # Notice: ANY additional validation needed for a certain user or action and not added in this API should be added here with some level of abstraction or as inherited class

        self.table = table

        self.connector = None           # The instance of the SQL API
        
        if len(connection_details) == 2:    # Check wether the user entered the password and database name or not [By default password = @dentist1, Database = DENTISTA]
            self.connector = SQL(host = connection_details[0], user = connection_details[1])    # Use the default arguments

        elif len(connection_details) == 4:  # add the full arguments to the constructor of the SQL  API
            self.connector = SQL(host = connection_details[0], user = connection_details[1], password=connection_details[2], database=connection_details[3])
    
    def email_validation(self, email_attribute):
        # email_attribute: is the attribute name of the email in the database table

        email = request.json['email']   # Getting the email from flutter app

        condition = email_attribute + " = '" + email + "'"  # the condtion of the SQL Query
        # This is done to check that this email doesn't exsists in the database

        query_result = self.connector.select_query(table=self.table, columns=[email_attribute], sql_condition= condition)    # getting the result of the query


        if query_result[email_attribute] == [] and validate_email(email) :  # Checking for the format of the email, and that it isn't exist in the database
            return '1'
        return '0'
    
    def Product_validation(self, Product_attribute):
        # email_attribute: is the attribute name of the email in the database table

        name = request.json['name']   # Getting the email from flutter app
        ID = request.json['ID']   # Getting the email from flutter app

        condition = Product_attribute + " = '" + name + "' and STORE_ID =  '" + ID+"'"  # the condtion of the SQL Query
        # This is done to check that this email doesn't exsists in the database

        query_result = self.connector.select_query(table=self.table, columns=[Product_attribute], sql_condition= condition)    # getting the result of the query


        if query_result[Product_attribute] != [] :  # Checking for the format of the email, and that it isn't exist in the database
            return '0'
        return '1'
    
    
    def phone_validation(self, phone_attribute):
        # phone_attribute: is the attribute name of the phone_number in the database table

        phone = request.json['phone']   # Getting the phone_number from flutter app
         
        condition = phone_attribute + " = '" + phone + "'"  # the condtion of the SQL Query
        # This is done to check that this phone doesn't exsists in the database

        query_result = self.connector.select_query(table=self.table, columns=[phone_attribute], sql_condition= condition)    # getting the result of the query
        self.connector.close_connection()

        if query_result[phone_attribute] == [] :  # Checking that phone_number isn't exist in the database
            return '1'  # this phone is valid
        return '0'

    def VehicleLicense_validation(self, license_attribute):
        # license_attribute: is the attribute name of the VECHILE_LICENCE in the database table

        license = request.json['license']   # Getting the License from flutter app

        condition = license_attribute + " = '" +license + "'" # the condtion of the SQL Query
        # This is done to check that this license doesn't exsists in the database

        query_result = self.connector.select_query(table=self.table,columns=[license_attribute],sql_condition=condition)

        if query_result[license_attribute] == [] :   # Checking that Vehicle license isn't exist in the database
            return '1'  # this license is valid
        return '0'

    
    def CreditCard_validation(self, CreditCard_attribute):
        # CreditCard_attribute: is the attribute name of the CreditCard in the database table

        CardNumber = request.json['CardNumber']
        CardEMonth = request.json['CardEMonth']
        CardEYear = request.json['CardEYear']
        CardCVV = request.json['CardCVV']

        Query = "SELECT  CARD_NUMBER FROM VIRTUAL_BANK WHERE CARD_NUMBER = '{}' and EXPIRATION_MONTH = {} and EXPIRATION_YEAR = {} and SECURITY_CODE = {} ;".format(CardNumber, CardEMonth, CardEYear, CardCVV)
        query_result = self.connector.exectute_query(Query)
        self.connector.close_connection()
        results = []
        if query_result == None:
            return '0'
        for row in query_result:
            results.append(row[0])

        if results == []:
            return '0'  # this data doesn't exsists
        return '1'


