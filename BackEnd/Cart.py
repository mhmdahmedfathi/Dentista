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

def AddtoCart():

    sql = SQL(server_name, server_admin)

    product_id = request.json['product_id']

    dentist_email = request.json['dentist_email']
 
    for_id = sql.select_query('DENTIST', ['DENTIST_ID'], f"DENTIST_EMAIL = '{dentist_email}'")
    dentist_id = for_id['DENTIST_ID'][0]

    check_exsist = sql.select_query('DentistCart', ['DENTIST_ID', 'Number_Units'], f"DENTIST_ID = {dentist_id} and PRODUCT_ID = {product_id}")
    try:
        if len(check_exsist['DENTIST_ID']) > 0:
            units = check_exsist['Number_Units'][0] + 1
            #sql.update_query('DentistCart', {'Number_Units' : units}, f" DENTIST_ID = {dentist_id} and PRODUCT_ID = {product_id}")
            sql.exectute_query(f"UPDATE DentistCart SET Number_Units = {units} WHERE DENTIST_ID = {dentist_id} and PRODUCT_ID = {product_id};")

        
        else:
            sql.insert_query('DentistCart', ['DENTIST_ID', 'PRODUCT_ID', 'Number_Units'], [dentist_id, product_id, 1])
    
    except:
        sql.insert_query('DentistCart', ['DENTIST_ID', 'PRODUCT_ID', 'Number_Units'], [dentist_id, product_id, 1])
    
    sql.close_connection()
    return '1'

def ViewCart():
    sql = SQL(server_name, server_admin)
    dentist_id = request.json['DentistID']

    Query = f"SELECT COUNT(*) FROM DentistCart WHERE DENTIST_ID = {dentist_id};"
    result = sql.exectute_query(Query)
    total_cart = result[0][0]


    result = sql.select_query('DentistCart', ['PRODUCT_ID', 'Number_Units'], f"DENTIST_ID = {dentist_id}")
    Output = {}
    Output['Number_Units'] = result['Number_Units']
    Output['ProductID'] = []
    Output['ProductName'] = []
    Output['Price'] = []
    Output['Category'] = []
    Output['ImageURL'] = []
    Output['Rate'] = []
    Output['Description'] = []
    Output['Brand'] = []
    Output['NoOfReviews'] = []
    Output['total_cart'] = int(total_cart)

   
    for prod_id in result['PRODUCT_ID']:
        Prod_Query = sql.select_query('PRODUCT', ['PRODUCT_ID', 'PRODUCT_NAME', 'SELLING_PRICE', 'IMAGE_URL', 'RATE', 'DESCRIPTION', 'Brand', 'NO_OF_REVIEWERS', 'CATEGORY'], f" PRODUCT_ID = {prod_id}")
        Output['ProductID'].append(Prod_Query['PRODUCT_ID'][0])
        Output['ProductName'].append(Prod_Query['PRODUCT_NAME'][0])
        Output['Price'].append(Prod_Query['SELLING_PRICE'][0])
        Output['Category'].append(Prod_Query['CATEGORY'][0])
        Output['ImageURL'].append(Prod_Query['IMAGE_URL'][0])
        Output['Rate'].append(Prod_Query['RATE'][0])
        Output['Description'].append(Prod_Query['DESCRIPTION'][0])
        Output['Brand'].append(Prod_Query['Brand'][0])
        Output['NoOfReviews'].append(Prod_Query['NO_OF_REVIEWERS'][0])
    sql.close_connection()
    return json.dumps(Output)



def RemoveFromCart():
    sql = SQL(server_name, server_admin)
    dentist_id = request.json['DentistID']
    product_id = request.json['ProductID']
    sql.delete_query('DentistCart', f" DENTIST_ID = {dentist_id} and PRODUCT_ID = {product_id}")
    sql.close_connection()
    return "1" 


def ClearCart():
    sql = SQL(server_name, server_admin)
    dentist_id = request.json['DentistID']
    sql.delete_query('DentistCart', f" DENTIST_ID = {dentist_id}")
    sql.close_connection()
    return "1"

def ShipCart():
    dentist_id = request.json['DentistID']
    sql = SQL(server_name, server_admin)

    Query = f"SELECT SUM(P.SELLING_PRICE * DC.Number_Units) as TOTAL_PRICE FROM PRODUCT as P, DENTISTCART as DC WHERE DC.DENTIST_ID = {dentist_id};"
    result = sql.exectute_query(Query)
    total_price = result[0][0]

    # Get No. Orders
    Query = "SELECT COUNT(*) FROM ORDERS;"
    result = sql.exectute_query(Query)
    ORDER_ID = result[0][0] + 1

    # Create Order

    Query = f"INSERT INTO ORDERS(ORDER_ID, DENTIST_ID, TOTAL_COST, SHIPMENT_STATUS) VALUES ({ORDER_ID}, {dentist_id}, {total_price}, 'Checking');"
    sql.exectute_query(Query)



    Query = f"SELECT VB.CREDIT FROM VIRTUAL_BANK AS VB, DENTIST AS D WHERE VB.CARD_NUMBER = (SELECT DENTIST_CREDIT_CARD_NUMBER FROM DENTIST WHERE DENTIST_ID = {dentist_id});"
    result = sql.exectute_query(Query)
    Credit = result[0][0]
    print(Credit)
    print("total price = " + str(total_price))

    remaining_Credit = int(Credit) - int(total_price)

    # Get From Credit
    Query = f"UPDATE VIRTUAL_BANK SET CREDIT = {remaining_Credit} WHERE CARD_NUMBER = (SELECT DENTIST_CREDIT_CARD_NUMBER FROM DENTIST WHERE DENTIST_ID = {dentist_id});"
    sql.exectute_query(Query)


    
    result = sql.select_query('DentistCart', ['PRODUCT_ID', 'Number_Units'], f" DENTIST_ID = {dentist_id}")
    Products = result['PRODUCT_ID']
    Units = result['Number_Units']
    for i in range(len(Products)):
        Query = f"INSERT INTO ORDER_PRODUCT VALUES({Units[i]}, {ORDER_ID}, {Products[i]});"
        sql.exectute_query(Query)
    
    sql.close_connection()
    return "1"
    

def GetTotalPrice():
    sql = SQL(server_name, server_admin)
    dentist_id = request.json['DentistID']
    #Query = f"SELECT SUM(P.SELLING_PRICE * DC.Number_Units) as TOTAL_PRICE FROM PRODUCT as P, DENTISTCART as DC WHERE DC.DENTIST_ID = {dentist_id};"
    Query = f"SELECT SUM(P.SELLING_PRICE * DC.Number_Units) FROM PRODUCT AS P, DENTISTCART AS DC WHERE DC.PRODUCT_ID = P.PRODUCT_ID AND DC.DENTIST_ID = {dentist_id};"
    result = sql.exectute_query(Query)
    total_price = result[0][0]
    print("total price = " + str(total_price))
    Query = f"SELECT VB.CREDIT FROM VIRTUAL_BANK AS VB, DENTIST AS D WHERE VB.CARD_NUMBER = (SELECT DENTIST_CREDIT_CARD_NUMBER FROM DENTIST WHERE DENTIST_ID = {dentist_id});"
    result = sql.exectute_query(Query)
    Credit = result[0][0]
    try:
        enough_credit = 1 if Credit > total_price else 0
        Output = {"total_price" : int(total_price), "enough_credit" : enough_credit}
    except:
        enough_credit = 1
        Output = {"total_price" : 0, "enough_credit" : enough_credit}
    return json.dumps(Output)



    










