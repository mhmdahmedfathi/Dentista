from Verifications import Validator
from flask import request
from SQLAPI import SQL
import json
# ------------------------------------------------------------------------------------------------------------------------------
#Setting Connection Up
server_name = 'localhost'
server_admin= 'root'
server_password = '@dentista1'
database = 'dentista'
connection_details = [server_name , server_admin , server_password , database]
# ------------------------------------------------------------------------------------------------------------------------------
#Product Insertion
def Product_Insertion():
    columns = ['NUMBER_OF_UNITS','STORE_ID','PRODUCT_ID','PRICE','SELLING_PRICE']
    values =[]
    for key in columns:
        values.append(request.json[key])
    connector = SQL(host=server_name, user=server_admin)
    PRODUCT_IDColumn = ['PRODUCT_ID']
    condition = "PRODUCT_NAME = '" + values[2]+"' and STORE_ID = '" +values[1]+ "'"
    ProductID= connector.select_query(table='products',columns=PRODUCT_IDColumn,sql_condition=condition)
    if ProductID['PRODUCT_ID']== []:
        columns[2]='PRODUCT_NAME'
        connector.insert_query(table='products' ,attributes=columns, values=values)
        connector.close_connection()
        return "1"
    values[2]=(",".join(repr(e) for e in ProductID['PRODUCT_ID']))
    Query="UPDATE products SET NUMBER_OF_UNITS ='"+ values[0] +"', PRICE ='"+ values[3] +"', SELLING_PRICE ='"+ values[4] +"'WHERE STORE_ID ='"+values[1]+"' and PRODUCT_ID = '"+values[2] +"'"
    connector.exectute_query(Query)
    connector.close_connection()
    return "1"
# ------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------

def Avaliable_Products():
    columns = ['NUMBER_OF_UNITS','SELLING_PRICE' ,'IMAGE_URL', 'PRODUCT_NAME']
    ID = request.json['ID']
    connector = SQL(host=server_name, user=server_admin)
    condition = " STORE_ID ='" + ID+ "' "
    Count_Product = connector.select_query(table='products ',columns= ['count(distinct PRODUCT_ID)'],sql_condition=condition)
    result = connector.select_query(table='products ',columns=columns,sql_condition=condition)
    result = {'SELLING_PRICE': result['SELLING_PRICE'], 'NUMBER_OF_UNITS': result['NUMBER_OF_UNITS'], 'IMAGE_URL': result['IMAGE_URL'], 'PRODUCT_NAME': result['PRODUCT_NAME'], 'Count': Count_Product['count(distinct PRODUCT_ID)']}
    connector.close_connection()
    return json.dumps(result)

# ------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------

def update_num_item():
    columns = ['NUMBER_OF_UNITS' 'PRODUCT_NAME']
    values =[]
    for key in columns:
        values.append(request.json[key])
    ID = request.json['ID']
    connector = SQL(host=server_name, user=server_admin)
    Query="UPDATE products SET NUMBER_OF_UNITS ='"+ values[0] +"' WHERE STORE_ID ='"+ID+"' and PRODUCT_NAME = '"+values[1] +"'"
    connector.exectute_query(Query)
    connector.close_connection()
    return'1'
