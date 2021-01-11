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

def ScheduleOrder():
    DentistID = request.json['DentistID']
    ProductID = request.json['ProductID']
    duration = request.json['duration']
    NoUnits = request.json['NoUnits']
    sql = SQL(server_name, server_admin)
    Query = f"INSERT INTO SCEDULE_PRODUCT(DENTIST_ID, PRODUCT_ID, DURATION, NoUnits) VALUES ({DentistID}, {ProductID}, {duration}, {NoUnits});"

    sql.exectute_query(Query)

    Query = f'''
    CREATE EVENT SCEDULED_{DentistID}_{ProductID}_{duration} 
    ON SCHEDULE EVERY {duration} DAY
    DO
    INSERT INTO ORDERS(DENTIST_ID, TOTAL_COST, SHIPMENT_STATUS) VALUES({DentistID}, (SELECT SELLING_PRICE FROM PRODUCT WHERE PRODUCT_ID = {ProductID}) * {NoUnits} , 'Checking');
    '''
    sql.exectute_query(Query)
    sql.close_connection()
    return '1'

def Remove_Schedule():

    DentistID = request.json['DentistID']
    ProductID = request.json['ProductID']
    duration = request.json['duration']

    sql = SQL(server_name, server_admin)
    Query = f"DROP EVENT SCEDULED_{DentistID}_{ProductID}_{duration};"
    sql.exectute_query(Query)
    sql.close_connection()
    return '1'
    

def RetriveSchedule():

    DentistID = request.json['DentistID']
    condition = f" PRODUCT_ID = (SELECT PRODUCT_ID FROM SCEDULE_PRODUCT WHERE DENTIST_ID = {DentistID})"
    columns =  ['PRODUCT_ID', 'PRODUCT_NAME', 'SELLING_PRICE', 'IMAGE_URL', 'RATE', 'DESCRIPTION', 'Brand', 'NO_OF_REVIEWERS', 'CATEGORY']
    sql = SQL(server_name, server_admin)
    Prod_Query = sql.select_query('PRODUCT', columns, condition)
    Output = {}
    Output['ProductID'] = Prod_Query['PRODUCT_ID']
    Output['ProductName'] = Prod_Query['PRODUCT_NAME']
    Output['Price'] = Prod_Query['SELLING_PRICE']
    Output['Category'] = Prod_Query['CATEGORY']
    Output['ImageURL'] = Prod_Query['IMAGE_URL']
    Output['Rate'] = Prod_Query['RATE']
    Output['Description'] = Prod_Query['DESCRIPTION']
    Output['Brand'] = Prod_Query['Brand']
    Output['NoOfReviews'] = Prod_Query['NO_OF_REVIEWERS']
    Output["discount"] = 0
    return json.dumps(Output)
