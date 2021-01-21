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





server_name = "dentistastore.mysql.database.azure.com"
server_admin = "dentista@dentistastore"
server_password = "@dentist1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]
'''

server_name = "localhost"
server_admin = "root"
server_password = "@dentist1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]
'''



sql = SQL(server_name, server_admin)
Query = "SELECT VB.CREDIT FROM VIRTUAL_BANK AS VB, DENTIST AS D WHERE VB.CARD_NUMBER = (SELECT DENTIST_CREDIT_CARD_NUMBER FROM DENTIST WHERE DENTIST_ID = 1);"
Query = "SELECT COUNT(*) FROM ORDERS;"
Query = "SELECT * FROM PRODUCT WHERE MATCH (PRODUCT_NAME) AGAINST (LIKE'%cha%' IN NATURAL LANGUAGE MODE);"

Query = '''

SET @NOREVIEWS = (SELECT NO_OF_REVIEWERS FROM PRODUCT WHERE PRODUCT_ID = 1);
SET @RATING = (SELECT RATE FROM PRODUCT WHERE PRODUCT_ID = 1);
SET @NEW_RATE = (@RATING * @NOREVIEWS + 0) / (@NOREVIEWS + 1); 
UPDATE PRODUCT SET RATE = @NEW_RATE, NO_OF_REVIEWERS = @NOREVIEWS + 1 WHERE PRODUCT_ID = 1;

SELECT * FROM PRODUCT;

'''
Query = "SELECT * FROM LOGIN_DATA;"
result = sql.exectute_query(Query)


condition = "email = '" +'yousef.gamal.it@gmail.com' + "' and Password = '" + 'y2o9u5s2e0f00' + "'"
print("condition " + condition)
result = sql.select_query(table = 'LOGIN_DATA', columns=['AccountType'], sql_condition=condition)
print(result)


sql.close_connection()
