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
    columns = ['NUMBER_OF_UNITS','STORE_ID','PRODUCT_ID','PRICE','SELLING_PRICE','Brand','DESCRIPTION' ,'Category']
    values =[]
    for key in columns:
        values.append(request.json[key])
    connector = SQL(host=server_name, user=server_admin)
    PRODUCT_IDColumn = ['PRODUCT_ID']
    condition = "PRODUCT_NAME = '" + values[2]+"' and STORE_ID = '" +values[1]+ "'"
    ProductID= connector.select_query(table='product',columns=PRODUCT_IDColumn,sql_condition=condition)
    if ProductID['PRODUCT_ID']== []:
        columns[2]='PRODUCT_NAME'
        print(columns)
        print(values)
        connector.insert_query(table='product' ,attributes=columns, values=values)
        connector.close_connection()
        return "1"
    values[2]=(",".join(repr(e) for e in ProductID['PRODUCT_ID']))
    Query="UPDATE product SET NUMBER_OF_UNITS ='"+ values[0] +"', PRICE ='"+ values[3] +"', SELLING_PRICE ='"+ values[4] +"'WHERE STORE_ID ='"+values[1]+"' and PRODUCT_ID = '"+values[2] +"'"
    connector.exectute_query(Query)
    connector.close_connection()
    return "1"
# ------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------

def Avaliable_Products():
    columns = ['NUMBER_OF_UNITS','SELLING_PRICE','RATE','Brand','PRICE' ,'Category','DESCRIPTION','IMAGE_URL', 'PRODUCT_NAME','PRODUCT_ID']
    ID = request.json['ID']
    connector = SQL(host=server_name, user=server_admin)
    condition = " STORE_ID ='" + ID+ "' "
    Count_Product = connector.select_query(table='product ',columns= ['count(distinct PRODUCT_ID)'],sql_condition=condition)
    result = connector.select_query(table='product ',columns=columns,sql_condition=condition)
    result = {'SELLING_PRICE': result['SELLING_PRICE'],'PRICE': result['PRICE'],'Brand': result['Brand'],'RATE': result['RATE'],'PRODUCT_ID': result['PRODUCT_ID'], 'NUMBER_OF_UNITS': result['NUMBER_OF_UNITS'],'Category': result['Category'],'DESCRIPTION': result['DESCRIPTION'], 'IMAGE_URL': result['IMAGE_URL'], 'PRODUCT_NAME': result['PRODUCT_NAME'], 'Count': Count_Product['count(distinct PRODUCT_ID)']}
    connector.close_connection()
    return json.dumps(result)

# ------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------

def Avaliable_total_Products():
    columns = ['NUMBER_OF_UNITS','SELLING_PRICE','PRICE' ,'IMAGE_URL', 'PRODUCT_NAME','PRODUCT_ID']
    connector = SQL(host=server_name, user=server_admin)
    Count_Product = connector.select_query(table='product',columns= ['count(distinct PRODUCT_ID)'])
    result = connector.select_query(table='product',columns=columns)
    result = {'SELLING_PRICE': result['SELLING_PRICE'],'PRICE': result['PRICE'],'PRODUCT_ID': result['PRODUCT_ID'], 'NUMBER_OF_UNITS': result['NUMBER_OF_UNITS'], 'IMAGE_URL': result['IMAGE_URL'], 'PRODUCT_NAME': result['PRODUCT_NAME'], 'Count': Count_Product['count(distinct PRODUCT_ID)']}
    connector.close_connection()
    return json.dumps(result)

# ------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------

def Update_Item_table():
    columns_dic = request.json['dic']
    ID = request.json["ID"]
    PRODUCT_NAME =request.json["PRODUCT_NAME"]
    condition = "STORE_ID = '" +str(ID) +  "' and PRODUCT_NAME = '" +PRODUCT_NAME+"'"
    connector = SQL(host=server_name, user=server_admin)
    connector.update_query(table='product' ,columns_values_dict= columns_dic,sql_condition=condition)
    connector.close_connection()
    return "1"
