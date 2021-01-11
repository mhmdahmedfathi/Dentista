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
    Query = f'''
    CREATE EVENT SCEDULED_{DentistID}_{ProductID} 
    ON SCHEDULE EVERY {duration} DAY
    DO
    INSERT INTO ORDERS(DENTIST_ID, TOTAL_COST, SHIPMENT_STATUS) VALUES({DentistID}, (SELECT SELLING_PRICE FROM PRODUCT WHERE PRODUCT_ID = {ProductID}) * {NoUnits} , 'Checking');
    '''
    return '1'