from SQLAPI import SQL
from flask import request
import json

# ------------------------------------------------------------------------------------------------------------------------------
# Connection Arguments of the database
#server_name = "dentista1.mysql.database.azure.com"
#server_admin = "dentista@dentista1"
#server_password = "@dentist1"
database = "DENTISTA"
# ------------------------------------------------------------------------------------------------------------------------------
#Connection Arguments of the Local database
server_name = "localhost"
server_admin = "root"
server_password = "@dentista1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]
# --------------------------------------------------------------------------------------------------------------------------------
def InsertChatRoom():
    useroneType = request.json['useronetype']
    usertwoType = request.json['usertwotype']
    useroneID = request.json['useroneid']
    usertwoID = request.json['usertwoid']
    message = request.json['message']
    senderID = request.json['senderid']
    senerType = request.json['sendertype']
    connector= SQL(host=server_name, user=server_admin,password=server_password)
    if(useroneType == 'Manager' and usertwoType == 'Store'):
        columns = ['MESSAGES' , 'MANAGER_ID','STORE_ID','SENDER_ID','SENDER_TYPE']
        values= [message , useroneID , usertwoID,senderID,senerType]
        connector.insert_query(table='MANAGER_STORE_CHAT' ,attributes=columns , values=values)
        connector.close_connection()
        return "1"
    elif(usertwoType == 'Manager' and useroneType == 'Store'):
        columns = ['MESSAGES', 'MANAGER_ID', 'STORE_ID', 'SENDER_ID', 'SENDER_TYPE']
        values = [message, usertwoID, useroneID, senderID, senerType]
        connector.insert_query(table='MANAGER_STORE_CHAT', attributes=columns, values=values)
        connector.close_connection()
        return "1"
    elif (useroneType == 'Manager' and usertwoType == 'Delivery'):
        columns = ['MESSAGES' , 'MANAGER_ID','DELIVERY_ID','SENDER_ID','SENDER_TYPE']
        values= [message , useroneID , usertwoID,senderID,senerType]
        connector.insert_query(table='MANAGER_DELIVERY_CHAT' ,attributes=columns , values=values)
        connector.close_connection()
        return "1"
    elif (usertwoType == 'Manager' and useroneType == 'Delivery'):
        columns = ['MESSAGES' , 'MANAGER_ID','DELIVERY_ID','SENDER_ID','SENDER_TYPE']
        values= [message , usertwoID , useroneID, senderID,senerType]
        connector.insert_query(table='MANAGER_DELIVERY_CHAT' ,attributes=columns , values=values)
        connector.close_connection()
        return "1"
    elif (useroneType == 'Dentist' and usertwoType == 'Delivery'):
        columns = ['MESSAGES' , 'DENTIST_ID', 'DELIVERY_ID', 'SENDER_ID','SENDER_TYPE']
        values= [message , useroneID , usertwoID , senderID,senerType]
        connector.insert_query(table='DENTIST_DELIVERY_CHAT' ,attributes=columns , values=values)
        connector.close_connection()
        return "1"
    elif (usertwoType == 'Dentist' and useroneType == 'Delivery'):
        columns = ['MESSAGES' , 'DENTIST_ID', 'DELIVERY_ID', 'SENDER_ID','SENDER_TYPE']
        values= [message , usertwoID , useroneID , senderID,senerType]
        connector.insert_query(table='DENTIST_DELIVERY_CHAT' ,attributes=columns , values=values)
        connector.close_connection()
        return "1"
    elif (useroneType == 'Dentist' and usertwoType == 'Store'):
        columns = ['MESSAGES' , 'DENTIST_ID','STORE_ID','SENDER_ID','SENDER_TYPE']
        values= [message , useroneID , usertwoID,senderID,senerType]
        connector.insert_query(table='DENTIST_STORE_CHAT' ,attributes=columns , values=values)
        connector.close_connection()
        return "1"
    elif(usertwoType == 'Dentist' and useroneType == 'Store'):
        columns = ['MESSAGES' , 'DENTIST_ID','STORE_ID','SENDER_ID','SENDER_TYPE']
        values= [message , usertwoID , useroneID,senderID,senerType]
        connector.insert_query(table='DENTIST_STORE_CHAT' ,attributes=columns , values=values)
        connector.close_connection()
        return "1"
    elif (useroneType == 'Delivery' and usertwoType == 'Store'):
        columns = ['MESSAGES' , 'Delivery_ID','STORE_ID','SENDER_ID','SENDER_TYPE']
        values= [message , useroneID , usertwoID,senderID,senerType]
        connector.insert_query(table='store_delivery_chat' ,attributes=columns , values=values)
        connector.close_connection()
        return "1"
    elif(usertwoType == 'Delivery' and useroneType == 'Store'):
        columns = ['MESSAGES' , 'Delivery_ID','STORE_ID','SENDER_ID','SENDER_TYPE']
        values= [message , usertwoID , useroneID,senderID,senerType]
        connector.insert_query(table='store_delivery_chat' ,attributes=columns , values=values)
        connector.close_connection()
        return "1"


def retrive_Messages():
    useroneType = request.json['useronetype']
    usertwoType = request.json['usertwotype']
    useroneID = request.json['useroneid']
    usertwoID = request.json['usertwoid']
    connector= SQL(host=server_name, user=server_admin,password=server_password)
    if((useroneType == 'Manager' and usertwoType == 'Store')):
        Condition = "(( MANAGER_ID = '"+ str(useroneID) +"') AND " + "( STORE_ID = '" +str(usertwoID) +"'))"
        results = connector.select_query(table='MANAGER_STORE_CHAT' , columns=['MESSAGES' , 'SENDER_ID','SENDER_TYPE'] ,sql_condition=Condition)
    elif((usertwoType == 'Manager' and useroneType == 'Store')):
        Condition = "(( MANAGER_ID = '"+ str(usertwoID) +"') AND " + "( STORE_ID = '" +str(useroneID) +"'))"
        results = connector.select_query(table='MANAGER_STORE_CHAT' , columns=['MESSAGES' , 'SENDER_ID','SENDER_TYPE'] ,sql_condition=Condition)

    elif ((useroneType == 'Manager' and usertwoType == 'Delivery')):
        Condition = "(( MANAGER_ID = '"+ str(useroneID) +"') AND " + "( DELIVERY_ID = '" +str(usertwoID) +"'))"
        results = connector.select_query(table='MANAGER_DELIVERY_CHAT' , columns=['MESSAGES' , 'SENDER_ID','SENDER_TYPE'] ,sql_condition=Condition)
    elif ((usertwoType == 'Manager' and useroneType == 'Delivery')):
        Condition = "(( MANAGER_ID = '"+ str(usertwoID) +"') AND " + "( DELIVERY_ID = '" +str(useroneID) +"'))"
        results = connector.select_query(table='MANAGER_DELIVERY_CHAT' , columns=['MESSAGES' , 'SENDER_ID','SENDER_TYPE'] ,sql_condition=Condition)

    elif ((useroneType == 'Dentist' and usertwoType == 'Delivery')):
        Condition = "((DENTIST_ID = '"+ str(useroneID) +"') AND " + "( DELIVERY_ID = '" +str(usertwoID) +"'))"
        results = connector.select_query(table='DENTIST_DELIVERY_CHAT' , columns=['MESSAGES' , 'SENDER_ID','SENDER_TYPE'] ,sql_condition=Condition)
    elif ((usertwoType == 'Dentist' and useroneType == 'Delivery')):
        Condition = "((DENTIST_ID = '"+ str(usertwoID) +"') AND " + "( DELIVERY_ID = '" +str(useroneID) +"'))"
        results = connector.select_query(table='DENTIST_DELIVERY_CHAT' , columns=['MESSAGES' , 'SENDER_ID','SENDER_TYPE'] ,sql_condition=Condition)

    elif ((useroneType == 'Dentist' and usertwoType == 'Store')):
        Condition = "((DENTIST_ID = '"+ str(useroneID) +"') AND " + "( STORE_ID = '" +str(usertwoID) +"'))"
        results = connector.select_query(table='DENTIST_DELIVERY_CHAT' , columns=['MESSAGES' , 'SENDER_ID','SENDER_TYPE'] ,sql_condition=Condition)
    elif ((usertwoType == 'Dentist' and useroneType == 'Store')):
        Condition = "((DENTIST_ID = '"+ str(usertwoID) +"') AND " + "( STORE_ID = '" +str(useroneID) +"'))"
        results = connector.select_query(table='DENTIST_DELIVERY_CHAT' , columns=['MESSAGES' , 'SENDER_ID','SENDER_TYPE'] ,sql_condition=Condition)

    elif ((useroneType == 'Delivery' and usertwoType == 'Store')):
        Condition = "((Delivery_ID = '" + str(useroneID) + "') AND " + "( STORE_ID = '" + str(usertwoID) + "'))"
        results = connector.select_query(table='store_delivery_chat',columns=['MESSAGES', 'SENDER_ID', 'SENDER_TYPE'], sql_condition=Condition)
    elif ((usertwoType == 'Delivery' and useroneType == 'Store')):
        Condition = "((Delivery_ID = '" + str(usertwoID) + "') AND " + "( STORE_ID = '" + str(useroneID) + "'))"
        results = connector.select_query(table='store_delivery_chat',columns=['MESSAGES', 'SENDER_ID', 'SENDER_TYPE'], sql_condition=Condition)

    results = {'Messages' : results['MESSAGES'] , 'Sender_id' : results['SENDER_ID'],'Sender_type' : results['SENDER_TYPE']}

    connector.close_connection()
    return json.dumps(results)