from SQLAPI import SQL
from flask import request
import json


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

sql = SQL(server_name, server_admin)
Query = "SELECT VB.CREDIT FROM VIRTUAL_BANK AS VB, DENTIST AS D WHERE VB.CARD_NUMBER = (SELECT DENTIST_CREDIT_CARD_NUMBER FROM DENTIST WHERE DENTIST_ID = 1);"
Query = "SELECT COUNT(*) FROM ORDERS;"
Query = "SELECT * FROM PRODUCT WHERE MATCH (PRODUCT_NAME) AGAINST (LIKE'%cha%' IN NATURAL LANGUAGE MODE);"
result = sql.exectute_query(Query)
PRODUCT_ID, PRODUCT_NAME, PRICE, SELLING_PRICE, IMAGE_URL, NUMBER_OF_UNITS, STORE_ID, RATE, NO_OF_REVIEWERS, CATEGORY, Brand, DESCRIPTION = zip(*result)
print(PRODUCT_ID)