from flask import Flask, jsonify, request
from SQLAPI import SQL
import json
from datetime import datetime

'''
server_name = "dentista1.mysql.database.azure.com"
server_admin = "dentista@dentista1"
server_password = "@dentist1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]
'''

server_name = "localhost"
server_admin = "root"
server_password = "@dentist1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]


def ExtractDate(Date):
    Year = Date[0:4]
    Month = Date[5:7]
    Day = Date[8:10]
    Date = Date.replace(" ", "")
    Hours = Date[10:12]
    Mins = Date[13:15]
    Seconds = Date[16:18]
    return Year, Month,Day, Hours, Mins, Seconds

def CheckDate(Date):
    now = datetime.now()
    # dd/mm/YY H:M:S
    now_string = now.strftime("%Y-%m-%d %H:%M:%S")
    comment_string = Date.strftime("%Y-%m-%d %H:%M:%S")
    Comment_Year, Comment_Month, Comment_Day, Comment_Hour, Comment_Mins, Comment_Seconds = ExtractDate(comment_string)

    Current_Year, Current_Month, Current_Day, Current_Hour, Current_Mins, Current_Seconds = ExtractDate(now_string)

    # Checking for Year 
    if int(Current_Year) != int(Comment_Year): # Previous Years
        differnce = int(Current_Year) - int(Comment_Year)
        return f"{differnce}y ago"

    else: #Same Year
        if int(Current_Month) != int(Comment_Month): #Previous Monthes
            differnce = int(Current_Month) - int(Comment_Month)
            if differnce == 1:
                return "1 month ago"
            else:
                return f"{differnce} months ago"
        
        else: #Same Month
            if int(Current_Day) != int(Comment_Day): # Previous days
                differnce = int(Current_Month) - int(Comment_Month)
                if differnce >= 7:
                    weeks = differnce // 7
                    return f"{weeks}w ago"
                else: #Less than week
                    return f"{differnce}d ago"
            
            else: #Same day
                if int(Current_Hour) != int(Comment_Hour): #Different Hours
                    differnce = int(Current_Hour) - int(Comment_Hour)
                    return f"{differnce}hrs ago"
                else: #Same Hour
                    if int(Current_Mins) != int(Comment_Mins): #Different Mins
                        difference = int(Current_Mins) - int(Comment_Mins)
                        return f"{difference}mins ago"
                    else:
                        return "now"
                    







def AddComment():

    # Adding a comment
    sql = SQL(server_name, server_admin)
    dentist_email = request.json['dentist_email']
    for_id = sql.select_query('DENTIST', ['DENTIST_ID'], f"DENTIST_EMAIL = '{dentist_email}'")
    dentist_id = for_id['DENTIST_ID'][0]

    product_id = request.json['product_id']
    comment = request.json['comment']

    # datetime object containing current date and time
    now = datetime.now()
    
    # dd/mm/YY H:M:S
    dt_string = now.strftime("%Y-%m-%d %H:%M:%S")


    sql.insert_query('DENTIST_COMMENT', ['DENTIST_ID', 'PRODUCT_ID', 'COMMENT_CONTEXT', 'LIKES', 'COMMENT_TIME'], [dentist_id, product_id, comment, 0, dt_string])
    sql.close_connection()
    return '1'


def LikeComment():

    # Add the like on a certian comment
    sql = SQL(server_name, server_admin)
    dentist_email = request.json['dentist_email']
    for_id = sql.select_query('DENTIST', ['DENTIST_ID'], f"DENTIST_EMAIL = '{dentist_email}'")
    dentist_id = for_id['DENTIST_ID'][0]

    comment_id = request.json['comment_id']

    # First increment likes of the comment by 1
    comments_result = sql.select_query('DENTIST_COMMENT', ['LIKES'], f" COMMENT_ID = {comment_id}")
    num_comments = comments_result['LIKES'][0] + 1
    sql.exectute_query(f"UPDATE DENTIST_COMMENT SET LIKES = {num_comments};")

    # Second add the like to the relationship
    sql.exectute_query(f"INSERT INTO DENTIST_LIKES(DENTIST_ID, COMMENT_ID) VALUES ({dentist_id, comment_id});")

    sql.close_connection()
    return '1'



def ViewComments():
    # Retrive Comments of a certian product
    sql = SQL(server_name, server_admin)
    product_id = request.json['product_id']
    comment_result = sql.select_query('DENTIST_COMMENT', ['DENTIST_ID', 'COMMENT_ID', 'COMMENT_CONTEXT', 'COMMENT_TIME', 'LIKES'], f" PRODUCT_ID = {product_id}")
    Output = {}
    Output['comment_id'] = comment_result['COMMENT_ID']
    Output['comment'] = comment_result['COMMENT_CONTEXT']
    Output['likes'] = comment_result['LIKES']
    Output['DentistID'] = comment_result['DENTIST_ID']
    Dentist_Names = []
    Dentist_Images = []

    dentist_ids = comment_result['DENTIST_ID']
    for dentist_id in dentist_ids:
        dentist_query = sql.select_query('DENTIST', ['DENTIST_Fname', 'DENTIST_LNAME', 'DENTIST_IMAGE_URL'], f" DENTIST_ID = {dentist_id}")
        name = dentist_query['DENTIST_Fname'][0] + " " + dentist_query["DENTIST_LNAME"][0]
        Dentist_Names.append(name)
        Dentist_Images.append(dentist_query['DENTIST_IMAGE_URL'][0])
    
    Output['DentistName'] = Dentist_Names
    Output['Dentist_Images'] = Dentist_Images

    #Date
    Dates = []
    for date in comment_result['COMMENT_TIME']:
        Dates.append(CheckDate(date))
    
    Output['CommentDate'] = Dates
    sql.close_connection()

    return json.dumps(Output)

def NoComments():
    # Retrive number of comments
    product_id = request.json['product_id']
    sql = SQL(server_name, server_admin)
    result = sql.select_query('DENTIST_COMMENT', ['PRODUCT_ID'], f"PRODUCT_ID = {product_id}")
    sql.close_connection()
    try:
        return str(len(result['PRODUCT_ID']))
    except:
        return '0'



def ViewLikes():
    comment_id = request.json['comment_id']
    sql = SQL(server_name, server_admin)
    dentist_result = sql.select_query('DENTIST_LIKES', ['DENTIST_ID'], f"COMMENT_ID = {comment_id}")
    dentist_ids = dentist_result['DENTIST_ID']
    Dentist_Names = []
    Dentist_Images = []

    for dentist_id in dentist_ids:
        dentist_query = sql.select_query('DENTIST', ['DENTIST_Fname', 'DENTIST_LNAME', 'DENTIST_IMAGE_URL'], f" DENTIST_ID = {dentist_id}")
        name = dentist_query['DENTIST_Fname'][0] + " " + dentist_query["DENTIST_LNAME"][0]
        Dentist_Names.append(name)
        Dentist_Images.append(dentist_query['DENTIST_IMAGE_URL'][0])
    Outputs = {}

    Outputs['Names'] = Dentist_Names
    Outputs['Images'] = Dentist_Images
    return json.dumps(Outputs)

