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
    cloumns = ['NUMBER_OF_UNITS','STORE_ID','PRODUCT_ID']
    values =[]
    for key in cloumns:
        values.append(request.json[key])
    connector = SQL(host=server_name, user=server_admin)
    PRODUCT_IDColumn = ['PRODUCT_ID']
    condition = "PRODUCT_NAME = '" + values[2]+"' and STORE_ID = '" +values[1]+ "'"
    ProductID= connector.select_query(table='product',columns=PRODUCT_IDColumn,sql_condition=condition)
    values[2]=(",".join(repr(e) for e in ProductID['PRODUCT_ID']))
    if values[2]== "":
        connector.insert_query(table='store_product' ,attributes=['NUMBER_OF_UNITS','STORE_ID'], values=values)
        connector.close_connection()
        return "1"
    connector.update_query(table='store_product',attributes='NUMBER_OF_UNITS',values=values[0])
    #connector.insert_query(table='store_product' ,attributes=cloumns, values=values)
    connector.close_connection()
    return "1"
# ------------------------------------------------------------------------------------------------------------------------------
#Validation of Manager

def Product_ID_validator():
    validator = Validator(connection_details , 'store_product')
    return validator.Product_validation('PRODUCT_ID')

# ------------------------------------------------------------------------------------------------------------------------------
#Validation of Manager

def Avaliable_Products():
    columns = ['NUMBER_OF_UNITS', 'SELLING_PRICE', 'IMAGE_URL', 'PRODUCT_NAME','NUMBER_OF_UNITS']
    ID = request.json['ID']
    connector = SQL(host=server_name, user=server_admin)
    condition = " STORE_ID ='" + ID+ "'"
    Count_Product = connector.select_query(table='store_product ',columns= ['count(distinct PRODUCT_ID)'],sql_condition=condition)
    condition3 = " AVAILABLE = 1" 
    Count_Delivery = connector.select_query(table='delivery',columns= ['count(distinct DELIVERY_ID)'],sql_condition=condition3)
    Condition2 = connector.select_query(table='store_product ',columns= ['PRODUCT_ID'],sql_condition=condition)
    ID1=Condition2['PRODUCT_ID'][0]
    condition4="S.PRODUCT_ID =" + str(ID1)
    result = connector.select_query(table='store_product as S, product as P ',columns=columns,sql_condition=condition4 )
    result = {'SELLING_PRICE': result['SELLING_PRICE'], 'NUMBER_OF_UNITS': result['NUMBER_OF_UNITS'], 'IMAGE_URL': result['IMAGE_URL'], 'PRODUCT_NAME': result['PRODUCT_NAME'], 'Count': Count_Product['count(distinct PRODUCT_ID)'], 'count_Delivery': Count_Delivery['count(distinct DELIVERY_ID)']}
    connector.close_connection()
    return json.dumps(result)

