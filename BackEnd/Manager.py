from Verifications import Validator
from flask import request
from SQLAPI import SQL
import json
# ------------------------------------------------------------------------------------------------------------------------------
#Setting Connection Up
server_name = "localhost"
server_admin = "root"
server_password = "@dentista1"
database = "dentista"
connection_details = [server_name , server_admin , server_password , database]
# ------------------------------------------------------------------------------------------------------------------------------
#Manager Insertion
def Manager_Insertion():
    cloumns = ['MANAGER_Fname','MANAGER_Lname','MANAGER_EMAIL' ,'MANAGER_PASSWORD','MANAGEMENT_TYPE','AREA_OF_MANAGEMENT']
    values =[]
    for key in cloumns:
        values.append(request.json[key])
    connector = SQL(server_name,server_admin,server_password)
    connector.insert_query(table='Manager' ,attributes=cloumns, values=values)
    connector.close_connection()
    return "1"
# ------------------------------------------------------------------------------------------------------------------------------
#Validation of Manager

def Manager_email_validator():
    validator = Validator(connection_details , 'Manager')
    return validator.email_validation('MANAGER_EMAIL')

def Update_Manager_table():

    columns_dic = request.json['dic']
    ManagerID = request.json["MID"]
    condition = "MANAGER_ID = '" +str(ManagerID) +  "'"
    connector = SQL(server_name,server_admin,server_password)
    connector.update_query(table='Manager' ,columns_values_dict= columns_dic,sql_condition=condition)
    connector.close_connection()
    return "1"


def Get_Pending_Requests_Del():
    ManagerArea = request.json['MArea']
    Condition = "AREA LIKE '" + ManagerArea +"'"
    connector = SQL(server_name,server_admin,server_password)
    result = connector.select_query(table='(delivery D JOIN  delivery_verification DF ON DF.DELIVERY_ID = D.DELIVERY_ID)',columns=['DISTINCT( D.DELIVERY_ID)','DELIVERY_Fname' ,'DELIVERY_Lname'],sql_condition=Condition)
    result = {'DID': result['DISTINCT( D.DELIVERY_ID)'] , 'fname':result['DELIVERY_Fname'], 'lname':result['DELIVERY_Lname']}
    print(result)
    connector.close_connection()
    return json.dumps(result)

def Get_Pending_Requests_Stores():
    ManagerArea = request.json['MArea']
    Condition = "REGION LIKE '" + ManagerArea +"'"
    print(Condition)
    connector = SQL(server_name,server_admin,server_password)
    result = connector.select_query(table='(STORE S JOIN store_branch SB ON S.STORE_ID = SB.STORE_ID JOIN store_verification SV ON SV.Store_branch_id = SB.Store_branch_id)',columns=['STORE_NAME' , 'S.STORE_ID' , 'SV.STORE_BRANCH_ID'],sql_condition=Condition)
    print(result)
    result = {'SID': result['S.STORE_ID'] , 'Sname':result['STORE_NAME'], 'BID' : result['SV.STORE_BRANCH_ID']}
    connector.close_connection()
    return json.dumps(result)

def Get_Request_Info_Delivery():
    Delivery_ID = request.json['DID']
    Condition = "DELIVERY_ID = '" +str(Delivery_ID) +  "'"
    connector = SQL(server_name,server_admin,server_password)
    result= connector.select_query(table='Delivery' , columns=['DELIVERY_Fname','DELIVERY_Lname','DELIVERY_EMAIL','DELIVERY_CREDIT_CARD_NUMBER','AREA','VECHILE_LICENCE','VECHILE_MODEL'],sql_condition=Condition)
    result = {'Fname' : result['DELIVERY_Fname'][0],'Lname' : result['DELIVERY_Lname'][0],'Email' : result['DELIVERY_EMAIL'][0],'CCN' : result['DELIVERY_CREDIT_CARD_NUMBER'][0],'Area' : result['AREA'][0],'License' : result['VECHILE_LICENCE'][0],'Model' : result['VECHILE_MODEL'][0]}
    connector.close_connection()
    return json.dumps(result)


def Get_All_Stores():
    ManagerArea = request.json['MArea']
    ManagerId = request.json['MID']
    Condition = "REGION = '"+ManagerArea+"'"+ "AND MANAGER_ID = '" +str(ManagerId) +"'"
    connector = SQL(server_name,server_admin,server_password)
    result = connector.select_query(table='(STORE S JOIN store_branch SB ON SB.STORE_ID = S.STORE_ID)' , columns=['S.STORE_ID','STORE_NAME'],sql_condition=Condition)
    result = {'SID' : result['S.STORE_ID'] , 'SNAME' : result['STORE_NAME']}
    connector.close_connection()
    return json.dumps(result)


def Get_All_Delivery():
    ManagerArea = request.json['MArea']
    ManagerId = request.json['MID']
    Condition = "AREA = '"+ManagerArea+"'" + "AND MANAGER_ID = '" +str(ManagerId) +"'"
    connector = SQL(server_name,server_admin,server_password)
    result = connector.select_query(table='DELIVERY' , columns=['DELIVERY_ID' , 'DELIVERY_Fname','DELIVERY_Lname'],sql_condition=Condition)
    result = {'DID':result['DELIVERY_ID'],'DFname':result['DELIVERY_Fname'] , 'DLname':result['DELIVERY_Lname']}
    connector.close_connection()
    return json.dumps(result)

def Accept_Request():
    reqType = request.json['type']
    ManagerID = request.json['MID']
    connector = SQL(server_name,server_admin,server_password)
    if reqType == 'Delivery':
        Deliver_id = request.json['DID']
        Condition = "DELIVERY_ID = '" + str(Deliver_id) +"'"
        connector.delete_query(table='delivery_verification' ,sql_condition=Condition)
        connector.update_query(table='DELIVERY' ,columns_values_dict= {'MANAGER_ID' : str(ManagerID)} , sql_condition=Condition)
    elif reqType == 'Store':
        Store_id = request.json['SID']
        store_branch_id = request.json['BID']
        Condition = "STORE_branch_ID = '" + str(store_branch_id) +"'"
        connector.delete_query(table='store_verification' ,sql_condition=Condition)
        connector.update_query(table='Store_branch' ,columns_values_dict= {'MANAGER_ID' :str( ManagerID)} , sql_condition=Condition)
    connector.close_connection()
    return "1"

def Reject_Request():
    reqType = request.json['type']
    ManagerID = request.json['MID']
    connector = SQL(server_name,server_admin,server_password)
    if reqType == 'Delivery':
        Deliver_id = request.json['DID']
        Condition = "DELIVERY_ID = '" + str(Deliver_id) +"'"
        connector.delete_query(table='delivery_verification' ,sql_condition=Condition)
    elif reqType == 'Store':
        Store_id = request.json['SID']
        Condition = "STORE_ID = '" + str(Store_id) +"'"
        connector.delete_query(table='store_verification' ,sql_condition=Condition)
    connector.close_connection()
    return "1"


def GetAreaofManager():
    email= request.json['Email']
    Condition = "MANAGER_EMAIL = '" + email + "'"
    connector = SQL(server_name,server_admin,server_password)
    result = connector.select_query(table="MANAGER" , columns=['AREA_OF_MANAGEMENT'] , sql_condition=Condition)
    result = {'Area' :result['AREA_OF_MANAGEMENT'][0] }
    connector.close_connection()
    return json.dumps(result)


def Get_Request_Info_Store():
    Store_ID = request.json['SID']
    Condition = "STORE_ID = '" +str(Store_ID) +  "'"
    connector = SQL(server_name,server_admin,server_password)
    result= connector.select_query(table='STORE' , columns=['STORE_NAME', 'EMAIL' , 'PHONE_NUMBER','CREDIT_CARD_NUMBER'],sql_condition=Condition)
    result = {'Sname' : result['STORE_NAME'][0],'Email' : result['EMAIL'][0],'CCN' : result['CREDIT_CARD_NUMBER'][0],'Phone' : result['PHONE_NUMBER'][0]}
    connector.close_connection()
    return json.dumps(result)

def Get_Products_Count():
    Store_ID = request.json['SID']
    Conditon = "S.STORE_ID = '" + str(Store_ID)  + "'"
    connector = SQL(server_name,server_admin,server_password)
    result = connector.select_query(table='(PRODUCT P JOIN STORE S ON S.STORE_ID= P.STORE_ID)' , columns=['PRODUCT_ID'],sql_condition=Conditon)
    total_products = 0
    try:
        total_products = len(result['PRODUCT_ID'])
    except:
        pass
    result = {'Products_Count' : total_products}
    connector.close_connection()
    return json.dumps(result)

def Get_Store_branches():
    Store_ID = request.json['SID']
    Conditon = "S.STORE_ID = '" + str(Store_ID)  + "'"
    connector = SQL(server_name,server_admin,server_password)
    result = connector.select_query(table='(store_branch SB JOIN STORE S ON SB.STORE_ID = S.STORE_ID)' , columns=['REGION'],sql_condition=Conditon)
    result = {'branches' : result['REGION']}
    connector.close_connection()
    return json.dumps(result)


def Delete_Store():
    Store_ID = request.json['SID']
    Mid = request.json['MID']
    Conditon= "STORE_ID = '"+ str(Store_ID) +"'" +" AND MANAGER_ID = '"+str(Mid)+"'"
    print(Conditon)
    connector = SQL(server_name,server_admin,server_password)
    connector.delete_query(table='STORE_branch' , sql_condition=Conditon)
    connector.close_connection()
    return "1"

def Delete_Delivery():
    Delivery_ID = request.json['DID']
    Conditon= "DELIVERY_ID = '"+ str(Delivery_ID) +"'"
    connector = SQL(server_name,server_admin,server_password)
    connector.delete_query(table='DELIVERY' , sql_condition=Conditon)
    connector.close_connection()
    return "1"

def Total_Delivered_orders():
    Delivery_ID = request.json['DID']
    Conditon = "DELIVERY_ID = '"+ str(Delivery_ID) + "'"
    connector = SQL(server_name,server_admin,server_password)
    result = connector.select_query(table='Delivery' , columns=['NUMBER_OF_DORDERS'] , sql_condition=Conditon)
    result = {"noofOrders" : result['NUMBER_OF_DORDERS'][0]}
    connector.close_connection()
    return json.dumps(result)

