from SQLAPI import SQL
import mysql.connector
from mysql.connector import errorcode
server_name = "dentista1.mysql.database.azure.com"
server_admin = "dentista@dentista1"
server_password = "@dentist1"
database = "DENTISTA"

def sql_testcase_1():
    # This is a valid testcase of Insertion
    connector = SQL(host=server_name, user=server_admin)
    attributes = ['DENTIST_ID', 'DENTIST_Fname', 'DENTIST_LNAME', 'DENTIST_EMAIL', 'DENTIST_PASSWORD', 'DENTIST_PHONE_NUMBER', 'DENTIST_ADDRESS', 'DENTIST_ZIP_CODE', 'DENTIST_REGION', 'DENTIST_CITY', 'DENTIST_CREDIT_CARD_NUMBER', 'DENTIST_IMAGE_URL']
    values = [2, 'Mohammed', 'Ahmed', 'Mohammed.Ahmed.it@gmail.com', 'y2o2u5s2e0f00', '01555266212', 'dar el salam', 123456, 'Maadi', 'Cairo', '4152-2222-3333-1111', 'IMAGE']

    #connector.insert_query(table='DENTIST', attributes = attributes, values = values)

    out = connector.select_query(table='DENTIST', columns = ['DENTIST_Fname', 'DENTIST_LNAME'] , sql_condition= " DENTIST_EMAIL = 'yousef.gamal.it@gmail.om'")
    print(out)

    connector.close_connection()

'''
Query = "INSERT INTO DENTIST (DENTIST_ID, DENTIST_Fname, DENTIST_LNAME, DENTIST_EMAIL, DENTIST_PASSWORD, DENTIST_PHONE_NUMBER, DENTIST_ADDRESS, DENTIST_ZIP_CODE, DENTIST_REGION, DENTIST_CITY, DENTIST_CREDIT_CARD_NUMBER, DENTIST_IMAGE_URL ) VALUES ( 0, 'Yousef', 'Gamal', 'yousef.gamal.it@gmail.com', 'y2o9u5s2e0f00', '01558266252', 'dar el salam', 123456, 'Maadi', 'Cairo', '4111-2222-3333-1111', 'IMAGE' );"
config = {
        'host': server_name,
        'user': server_admin,
        'password':server_password,
        'database': database
            }  

try:
    conn = mysql.connector.connect(**config)
    print("Connection established")
except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("Something is wrong with the user name or password")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("Database does not exist")
    else:
        print(err)
else:
    cursor = conn.cursor()

cursor.execute(Query)

# Cleanup
conn.commit()
cursor.close()
conn.close()
print("Done.")
    
'''
if __name__ == "__main__":
    sql_testcase_1()
