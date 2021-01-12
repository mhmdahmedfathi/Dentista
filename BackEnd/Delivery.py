from Verifications import Validator
from flask import request
from SQLAPI import SQL
import json
import datetime

# ------------------------------------------------------------------------------------------------------------------------------
# Connection Arguments of the database
server_name = "dentista1.mysql.database.azure.com"
server_admin = "dentista@dentista1"
server_password = "@dentist1"
database = "DENTISTA"

connection_details = [server_name, server_admin, server_password, database]
# --------------------------------------------------------------------------------------------------------------------------------

# Insertion of the Dentist

def Delivery_insertion():
    connector = SQL(host=server_name, user=server_admin)
    columns = ['DELIVERY_Fname', 'DELIVERY_Lname', 'DELIVERY_EMAIL', 'DELIVERY_PASSWORD', 'DELIVERY_CREDIT_CARD_NUMBER', 'AREA', 'VECHILE_LICENCE', 'VECHILE_MODEL','Delivery_PHONE_NUMBER']
    values = []
    for key in columns:
        values.append(request.json[key])

    columns.append('AVAILABLE')
    values.append(1)
    columns.append('RATE')
    values.append(0)
    columns.append('NUMBER_OF_DORDERS')
    values.append(0)

    connector.insert_query(table = 'DELIVERY', attributes=columns, values=values)
    condition ="DELIVERY_EMAIL = '"+ values[2] +"'"
    DeliveryID = connector.select_query(table='DELIVERY',columns=['delivery_ID'],sql_condition=condition)
    connector.insert_query(table='DELIVERY_VERIFICATION',attributes=['DELIVERY_ID'],values=DeliveryID['delivery_ID'])
    connector.close_connection()
    return "1"

def DeliveryStatus():
    deliveryemail = request.json['email']
    condition = "DELIVERY_EMAIL = '"+deliveryemail+"'"
    connector = SQL(host=server_name, user=server_admin,password=server_password)
    #if manager ID has value -> Delivery is accepted
    IDS = connector.select_query(table='DELIVERY', columns=['MANAGER_ID', 'DELIVERY_ID'], sql_condition=condition)
    if IDS['MANAGER_ID'] != [None]:
        connector.close_connection()
        return "Accepted"
    #else there are 2 state waiting or rejected
    else:
        condition = "DELIVERY_ID = " + str(IDS['DELIVERY_ID'][0])
        #if delivery verification id has value(existed) means delivery in pending
        verificationid = connector.select_query(table='delivery_verification', columns=['DELIVERY_VERIFICATION_ID'],sql_condition=condition)
        if verificationid['DELIVERY_VERIFICATION_ID'] != []:
            connector.close_connection()
            return "Pending"

        #else delivery is rejected
        else:
            connector.close_connection()
            return "Rejected"


# --------------------------------------------------------------------------------------------------------------------------------

# Validations of the Delivery
def Delivery_email_validation():
    validator = Validator(connection_details, 'DELIVERY')
    return validator.email_validation('DELIVERY_EMAIL')

def Delivery_CreditCard_validation():
    validator = Validator(connection_details, 'DELIVERY')
    return validator.CreditCard_validation('DELIVERY_CREDIT_CARD_NUMBER')

def Delivery_PhoneNumber_validator():
    validator = Validator(connection_details, 'DELIVERY')
    return validator.phone_validation('Delivery_PHONE_NUMBER')

def Delivery_VehicleLicense_validator():
    validator = Validator(connection_details, 'DELIVERY')
    return validator.VehicleLicense_validation('VECHILE_LICENCE')
# -----------------------------------------------------------------------------------------------------------------------------------------

# Showing data in app functions
def OrdersToBeDelivered():
    columns = ['o.ORDER_ID', 'o.TOTAL_COST', 'd.DENTIST_Fname', 'd.DENTIST_LNAME', 'd.DENTIST_ADDRESS', 'd.DENTIST_PHONE_NUMBER', 'd.DENTIST_EMAIL', 'd.DENTIST_ID', 'O.SHIPMENT_STATUS']
    area = request.json['area']
    connector = SQL(host=server_name, user=server_admin)
    condition = " (SHIPMENT_STATUS = 'Not Delivered' or SHIPMENT_STATUS = 'ASSIGNED')and d.DENTIST_ID=o.DENTIST_ID and d.DENTIST_CITY='" + area+ "' order by O.SHIPMENT_STATUS"
    availableordersnumber = connector.select_query(table='orders as O, dentist as d ',columns= ['count(distinct O.ORDER_ID)'],sql_condition=condition)
    result = connector.select_query(table='orders as O, dentist as d ',columns=columns,sql_condition=condition,DISTINCTdetector=True)
    result = {'status': result['O.SHIPMENT_STATUS'],'orderid': result['o.ORDER_ID'], 'ordertotal': result['o.TOTAL_COST'], 'dentistfname': result['d.DENTIST_Fname'], 'dentistlname': result['d.DENTIST_LNAME'], 'no.orders': availableordersnumber['count(distinct O.ORDER_ID)'], 'address': result['d.DENTIST_ADDRESS'], 'phone': result['d.DENTIST_PHONE_NUMBER'], 'email': result['d.DENTIST_EMAIL'], 'DID':result['d.DENTIST_ID']}
    connector.close_connection()
    return json.dumps(result)

def ProductsofOrder():
    orderid = request.json['orderid']
    connector = SQL(host=server_name, user=server_admin)
    condition = " op.PRODUCT_ID = p.PRODUCT_ID and op.ORDER_ID = '"+orderid+ "'"
    columns = ['count(*)']
    numberofproducts = connector.select_query(table='order_product as op, product as p ',columns=columns,sql_condition=condition)
    columns = ['op.PRODUCT_ID', 'p.PRODUCT_NAME', 'p.SELLING_PRICE', 'op.NUMBER_OF_UNITS']
    result = connector.select_query(table='order_product as op, product as p ',columns=columns, sql_condition=condition)
    result = {'productid': result['op.PRODUCT_ID'], 'productname': result['p.PRODUCT_NAME'], 'productprice': result['p.SELLING_PRICE'], 'no.units': result['op.NUMBER_OF_UNITS'], 'no.products': numberofproducts['count(*)']}
    connector.close_connection()
    return json.dumps(result)

def DeliveredOrders():
    deliverid = request.json['DELIVERYID']
    today = datetime.date.today().strftime("%Y-%m-%d")
    columns = ['O.ORDER_ID', 'D.DENTIST_FNAME', 'D.DENTIST_LNAME', 'O.SHIPMENT_STATUS','O.TOTAL_COST',]
    condition = "O.DELIVERY_ID = " + deliverid + " and O.ORDER_DATE= '"+today+"' and O.DENTIST_ID=D.DENTIST_ID and O.SHIPMENT_STATUS ='DELIVERED' order by O.SHIPMENT_STATUS"
    connector = SQL(host=server_name, user=server_admin)
    result = connector.select_query(table='ORDERS as O , DENTIST as D',columns=columns,sql_condition=condition,DISTINCTdetector=True)
    connector.close_connection()
    result = {'cost': result['O.TOTAL_COST'] ,'orderids': result['O.ORDER_ID'], 'number': len(result['O.ORDER_ID']), 'dentistfname': result['D.DENTIST_FNAME'], 'dentistlname': result['D.DENTIST_LNAME'], 'status': result['O.SHIPMENT_STATUS']}
    return json.dumps(result)


def TotalDeliveredOrders():
    deliverid = request.json['DELIVERYID']
    condition = "DELIVERY_ID = "+ deliverid +" and SHIPMENT_STATUS = 'DELIVERED'"
    connector = SQL(server_name, server_admin, server_password)
    result = connector.select_query(table='ORDERS',columns=['count(*)'],sql_condition=condition)
    connector.close_connection()
    return json.dumps(result)

def GetManager():
    DeliveryArea = request.json['area']
    Condition = "AREA_OF_MANAGEMENT = '" + DeliveryArea + "'"
    connector = SQL(server_name, server_admin, server_password)
    result = connector.select_query(table='Manager', columns=['Manager_ID', 'Manager_Fname', 'Manager_Lname'],sql_condition=Condition)
    result = {'MID': result['Manager_ID'], 'MFname': result['Manager_Fname'], 'MLname': result['Manager_Lname']}
    connector.close_connection()
    return json.dumps(result)

def Reviews():
    DELIVERY_ID = request.json['id']
    columns = ['R.REVIEW', 'D.DENTIST_Fname', 'D.DENTIST_LNAME', 'D.DENTIST_IMAGE_URL']
    condition = "R.DELIVERY_ID = " + DELIVERY_ID + " and R.DENTIST_ID = D.DENTIST_ID"
    connector = SQL(server_name, server_admin, server_password)
    result = connector.select_query(table='REVIEW_DELIVERY as R , DENTIST as D',columns=columns,sql_condition=condition)
    result= {'length': len(result['R.REVIEW']), 'review': result['R.REVIEW'], 'Dfname': result['D.DENTIST_Fname'], 'Dlname': result['D.DENTIST_LNAME'], 'ImgUrl': result['D.DENTIST_IMAGE_URL']}
    connector.close_connection()
    return json.dumps(result)

#def DeliveryProfile():
    #columns = ['DELIVERY_ID', 'VECHILE_LICENCE', 'VECHILE_MODEL', 'RATE', 'Delivery_PHONE_NUMBER']
    #email = request.json['email']
    #condition = "DELIVERY_EMAIL = '"+ email + "'"
    #connector = SQL(host=server_name, user=server_admin)
    #result = connector.select_query(table='DELIVERY', columns=columns, sql_condition=condition)
    #connector.close_connection()
    #result = {'ID': result['DELIVERY_ID'][0], 'VLicense': result['VECHILE_LICENCE'][0], 'VModel': result['VECHILE_MODEL'][0], 'rate': result['RATE'][0], 'phone': result['Delivery_PHONE_NUMBER'][0]}
    #return json.dumps(result)

# -----------------------------------------------------------------------------------------------------------------------------------------

# Delivery functionalities
def DeliverOrder():
    deliveryid = request.json['DELIVERYID']
    orderid = request.json['ORDERID']
    numberofDorders = request.json['no.Dorders']
    connector = SQL(host=server_name, user=server_admin)
    result = connector.select_query(table='ORDERS',columns=['SHIPMENT_STATUS'],sql_condition="ORDER_ID= "+orderid )
    today = datetime.date.today().strftime("%Y-%m-%d")
    if result['SHIPMENT_STATUS'][0] == 'ASSIGNED':
        return "0"
    else:
        Query = {'O.DELIVERY_ID' : deliveryid, 'O.SHIPMENT_STATUS' : 'ASSIGNED', 'D.AVAILABLE': "0", 'D.NUMBER_OF_DORDERS': numberofDorders, 'O.ORDER_DATE': today}
        condition = "O.ORDER_ID = " + orderid +" and D.delivery_id = " + deliveryid
        connector.update_query(table='ORDERS as O, DELIVERY as D',columns_values_dict=Query,sql_condition=condition)
        connector.close_connection()
        return "1"

def FinishDelivering():
    deliveryid = request.json['DELIVERYID']
    orderid = request.json['ORDERID']
    orderprice = request.json['price']
    Query = {'O.SHIPMENT_STATUS': 'DELIVERED', 'D.AVAILABLE': 1}
    condition = "O.ORDER_ID = " + orderid + " and D.delivery_id = " + deliveryid
    connector = SQL(host=server_name, user=server_admin)
    connector.exectute_query("UPDATE ORDERS as O, DELIVERY as D SET O.SHIPMENT_STATUS =  'DELIVERED', D.AVAILABLE =  '1' WHERE O.ORDER_ID = "+orderid+" and D.delivery_id = "+deliveryid+";")
    #connector.update_query(table='ORDERS as O, DELIVERY as D',columns_values_dict=Query,sql_condition=condition)
    AddedMoney = int(2/100*float(orderprice))
    AddedMoney =  int (AddedMoney)
    Query = "SET @Prev_Credit = ("+str(AddedMoney)+" + (SELECT CREDIT FROM VIRTUAL_BANK WHERE CARD_NUMBER = (SELECT DELIVERY_CREDIT_CARD_NUMBER FROM DELIVERY WHERE DELIVERY_ID = "+deliveryid+") ) );\n"+"UPDATE VIRTUAL_BANK SET CREDIT = @Prev_Credit  WHERE CARD_NUMBER = (SELECT DELIVERY_CREDIT_CARD_NUMBER FROM DELIVERY WHERE DELIVERY_ID = "+deliveryid+");"
    connector.exectute_query(Query)
    connector.close_connection()
    return "1"

def UpdateData():
    columns_dic = request.json['dic']
    DeliveryID = request.json["MID"]
    condition = "DELIVERY_ID = '" + str(DeliveryID) + "'"
    connector = SQL(server_name, server_admin, server_password)
    connector.update_query(table='DELIVERY', columns_values_dict=columns_dic, sql_condition=condition)
    connector.close_connection()
    return "1"

def UpdatePassword():
    newpassword=request.json["newpassword"]
    oldpassword=request.json['oldpassword']
    DeliveryID = request.json["DELIVERYID"]
    condition = "DELIVERY_ID = '" + str(DeliveryID) + "'"
    Query = {'DELIVERY_PASSWORD': newpassword}
    connector = SQL(server_name, server_admin, server_password)
    result = connector.select_query(table='DELIVERY',columns=['DELIVERY_PASSWORD'],sql_condition=condition)
    if result['DELIVERY_PASSWORD'][0]==oldpassword:
        connector.update_query(table='DELIVERY', columns_values_dict=Query, sql_condition=condition)
        connector.close_connection()
        return "1"
    else:
        return "0"
