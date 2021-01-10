from Verifications import Validator
from flask import request
from SQLAPI import SQL
# ------------------------------------------------------------------------------------------------------------------------------
# Connection Arguments of the database
server_name = "localhost"
server_admin = "root"
server_password = "@dentist1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]
# --------------------------------------------------------------------------------------------------------------------------------

# Insertion of the Store

def Store2_insertion():
    columns = ['STORE_ID', 'ADDRESS', 'REGION', 'CITY', 'ZIP_CODE']
    values = []
    for key in columns:
        values.append(request.json[key])
    connector = SQL(host=server_name, user=server_admin)
    StoreIDColumn = ['STORE_ID']
    condition = "STORE_NAME = '" + values[0]+"'"
    StoreID= connector.select_query(table='STORE',columns=StoreIDColumn,sql_condition=condition)
    values[0]=(",".join(repr(e) for e in StoreID['STORE_ID']))
    condition = "STORE_ID = '" + values[0]+"' + REGION = '"+values[0]+"'"
    connector.insert_query(table = 'STORE_BRANCH', attributes=columns, values=values)
    store_bransh_id =connector.select_query(table='STORE_BRANCH', columns=['Store_branch_id'], sql_condition=condition)
    connector.insert_query(table='store_verification',attributes=['Store_branch_id'],values=store_bransh_id)
    connector.close_connection()
    return "1"

# -----------------------------------------------------------------------------------------------------------------------------------------

def StoreStatus():
    email = request.json['email']
    condition = "email = '"+email+"'"
    connector = SQL(host=server_name, user=server_admin)
    Store_ID = connector.select_query(table='STORE', columns=['STORE_ID'], sql_condition=condition)
    if Store_ID['STORE_ID'] == [None]:
        return 'invalid email'
    ID=Store_ID['STORE_ID'][0]
    condition = "STORE_ID = '"+str(ID)+"'"
    #if manager ID has value -> Delivery is accepted
    IDS = connector.select_query(table='STORE_BRANCH', columns=['MANAGER_ID','Store_branch_id'], sql_condition=condition)
    for item in IDS['MANAGER_ID']:
        if item != None:
            connector.close_connection()
            return "Accepted"
    #else there are 2 state waiting or rejected
    else:
        for item in IDS['Store_branch_id']:
            condition = "Store_branch_id = '"+str(item)+"'" 
        #if delivery verification id has value(existed) means delivery in pending
            verificationid = connector.select_query(table='store_verification', columns=['Verifing_ID'],sql_condition=condition)
            if verificationid['Verifing_ID'] != []:
                connector.close_connection()
                return "Pending"

        #else delivery is rejected
        else:
            connector.close_connection()
            return "Rejected"


# --------------------------------------------------------------------------------------------------------------------------------
