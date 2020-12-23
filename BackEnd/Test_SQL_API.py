from SQLAPI import SQL
import mysql.connector
from mysql.connector import errorcode
import pandas as pd
import numpy as np

#------------------------------------------------------------------------------------------------------
server_name = "dentista1.mysql.database.azure.com"
server_admin = "dentista@dentista1"
server_password = "@dentist1"
database = "DENTISTA"

def sql_testcase_1():
    # This is a valid testcase of Insertion
    connector = SQL(host=server_name, user=server_admin)
    attributes = ['DENTIST_ID', 'DENTIST_Fname', 'DENTIST_LNAME', 'DENTIST_EMAIL', 'DENTIST_PASSWORD', 'DENTIST_PHONE_NUMBER', 'DENTIST_ADDRESS', 'DENTIST_ZIP_CODE', 'DENTIST_REGION', 'DENTIST_CITY', 'DENTIST_CREDIT_CARD_NUMBER', 'DENTIST_IMAGE_URL']
    values = [2, 'Mohammed', 'Ahmed', 'Mohammed.Ahmed.it@gmail.com', 'y2o2u5s2e0f00', '01555266212', 'dar el salam', 123456, 'Maadi', 'Cairo', '4152-2222-3333-1111', 'IMAGE']

    connector.insert_query(table='DENTIST', attributes = attributes, values = values)

    out = connector.select_query(table='DENTIST', columns = ['DENTIST_Fname', 'DENTIST_LNAME'] , sql_condition= " DENTIST_EMAIL = 'yousef.gamal.it@gmail.om'")
    print(out)

    connector.close_connection()





def testcase3():
    connector = SQL(host=server_name, user=server_admin)
    out = connector.select_query(table='DENTIST', columns='*', sql_condition= "DENTIST_EMAIL = 'yousef.gamal.it@gmail.com'")
    print(out)
    connector.close_connection()
    return out

def testcase4():
    connector = SQL(host=server_name, user=server_admin)
    connector.delete_query(table='VIRTUAL_BANK', sql_condition="CARD_NUMBER = '1236-7742-5753-3373' ")
    connector.close_connection()
    
def testcase5():
    Query = {'FIRST_NAME' : 'Yousef', 'LAST_NAME' : 'GAMAL', 'EMAIL' : 'yousef.gamal.it@gmail.com'}
    connector = SQL(host=server_name, user=server_admin)
    connector.update_query(table='VIRTUAL_BANK', columns_values_dict=Query, sql_condition="CARD_NUMBER = '2737-4922-5524-4179' ")
    connector.close_connection()

def testcase6():
    connector = SQL(host=server_name, user=server_admin)
    out = connector.exectute_query('SELECT * FROM VIRTUAL_BANK;')
    for row in out:
        print(row)
    connector.close_connection()
    
def bank_testcase():
    connector = SQL(host=server_name, user=server_admin)
    df = pd.read_csv('males_en.csv')
    Names = np.array(df['Name'])
    Year = [2020, 2021, 2022, 2023, 2024]
    Month = ["May", "April", "June", "July"]
    Nums = [1,2,3,4,5,6,7,8,9]
    for j in range(20):
        fname = np.random.choice(Names, 1)[0]
        lname = np.random.choice(Names, 1)[0]
        email = fname + "." + lname + "@gmail.com"
        PassWord = fname+lname+'1'
        year = np.random.choice(Year, 1)[0]
        month = np.random.choice(Month, 1)[0]
        Card_Num = ""
        for i in range(4):
            n = np.random.choice(Nums, 1)
            Card_Num = Card_Num + str(n[0])
        Card_Num = Card_Num + "-"
        for i in range(4):
            n = np.random.choice(Nums, 1)
            Card_Num = Card_Num + str(n[0])
        Card_Num = Card_Num + "-"
        for i in range(4):
            n = np.random.choice(Nums, 1)
            Card_Num = Card_Num + str(n[0])
        Card_Num = Card_Num + "-"
        for i in range(4):
            n = np.random.choice(Nums, 1)
            Card_Num = Card_Num + str(n[0])
        NID = ""
        for i in range(14):
            n = np.random.choice(Nums, 1)
            NID = NID + str(n[0])
        
        SCode = ""
        for i in range(3):
            n = np.random.choice(Nums, 1)
            SCode = SCode + str(n[0])
        CREDIT = 0
        attributes = ['CARD_NUMBER', 'FIRST_NAME', 'LAST_NAME', 'EMAIL', 'PASSWORD', 'NATIONAL_ID', 'SECURITY_CODE', 'EXPIRATION_MONTH', 'EXPIRATION_YEAR', 'CREDIT']
        values = [Card_Num, fname, lname, email, PassWord, NID, SCode, month, year, CREDIT]
        connector.insert_query(table='VIRTUAL_BANK', attributes=attributes, values=values)

    out = connector.select_query(table='VIRTUAL_BANK', columns='*')
    print(out)
    connector.close_connection()



if __name__ == "__main__":
    testcase3()

