from Verifications import Validator
from flask import request
from SQLAPI import SQL
import json
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

    #Searching for manager ID first who is managing Deliverues and the same area
    ManagerIDColumn = ['MANAGER_ID']
    #ManagerIDColumn = ['*']
    condition ="MANAGEMENT_TYPE = 'Delivery' and AREA_OF_MANAGEMENT = '"+values[5]+"'"
    ManagerID= connector.select_query(table='MANAGER',columns=ManagerIDColumn,sql_condition=condition)

    columns.append('MANAGER_ID')
    values.append(",".join(repr(e) for e in ManagerID['MANAGER_ID']))
    columns.append('AVAILABLE')
    values.append(0)
    columns.append('RATE')
    values.append(0)


    connector.insert_query(table = 'DELIVERY', attributes=columns, values=values)
    connector.close_connection()
    return "1"

# --------------------------------------------------------------------------------------------------------------------------------

# Validations of the Dentist
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
def OrdersToBeDelivered():
    columns = ['o.ORDER_ID', 'o.TOTAL_COST', 'd.DENTIST_Fname', 'd.DENTIST_LNAME']
    area = request.json['area']
    connector = SQL(host=server_name, user=server_admin)
    condition = " SHIPMENT_STATUS = 'Not Delivered' and d.DENTIST_ID=o.DENTIST_ID and d.DENTIST_CITY='" + area+ "'"
    availableordersnumber = connector.select_query(table='orders as O, dentist as d ',columns= ['count(distinct O.ORDER_ID)'],sql_condition=condition)
    condition = " d.DENTIST_ID = o.DENTIST_ID and d.DENTIST_CITY= '" + area + "'"
    result = connector.select_query(table='orders as O, dentist as d ',columns=columns,sql_condition=condition,DISTINCTdetector=True)
    result = {'orderid': result['o.ORDER_ID'], 'ordertotal': result['o.TOTAL_COST'], 'dentistfname': result['d.DENTIST_Fname'], 'dentistlname': result['d.DENTIST_LNAME'], 'no.orders': availableordersnumber['count(distinct O.ORDER_ID)']}
    return json.dumps(result)