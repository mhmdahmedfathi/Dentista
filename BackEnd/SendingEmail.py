from SQLAPI import SQL
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

from flask import request
from SQLAPI import SQL
import json
# ------------------------------------------------------------------------------------------------------------------------------
# Connection Arguments of the database

'''
server_name = "dentista1.mysql.database.azure.com"
server_admin = "dentista@dentista1"
server_password = "@dentista1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]
'''

server_name = "localhost"
server_admin = "root"
server_password = "@dentista1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]
# --------------------------------------------------------------------------------------------------------------------------------



'''
mail_content = "Hello,Here is your verification code to complete your sign up"

#The mail addresses and password
sender_address = 'storedentista@gmail.com'
sender_pass = '@dentist1'
receiver_address = 'yousef.gamal.it@gmail.com'
#Setup the MIME
message = MIMEMultipart()
message['From'] = sender_address
message['To'] = receiver_address
message['Subject'] = 'Complete your sign up'   #The subject line
#The body and the attachments for the mail
message.attach(MIMEText(mail_content, 'plain'))
#Create SMTP session for sending the mail
session = smtplib.SMTP('smtp.gmail.com', 587) #use gmail with port
session.ehlo()
session.starttls() #enable security
session.login(sender_address, sender_pass) #login with mail_id and password
text = message.as_string()
session.sendmail(sender_address, receiver_address, text)
session.quit()
print('Mail Sent')
'''




class EmailConfirmation:
    def __init__(self, email, code):
        self.__email = email
        self.__code = code
        self.__sql = SQL(server_name, server_admin,server_password)
        self.__AccountType = None
        self.__Name = None
        self.__getAccountType()
        self.__getAccountName()
        self.__SendEmail()
        self.__close_connection()
    
    def __getAccountType(self):
        try:
            print("Before AccountType")
            AccountType = self.__sql.select_query('LOGIN_DATA', ['AccountType'], f"Email = '{self.__email}'")
            self.__AccountType = AccountType['AccountType'][0]

        except:
            pass
    
    def __getAccountName(self):
        fname_dict = {
            'Dentist' : 'DENTIST_Fname',
            'Delivery' : 'DELIVERY_Fname',
            'Manager' : 'MANAGER_Fname',
            'Store' : 'STORE_NAME' 
        }

        lname_dict = {
            'Dentist' : 'DENTIST_LNAME',
            'Delivery' : 'DELIVERY_Lname',
            'Manager' : 'MANAGER_Lname', 
        }

        email_dict = {
            'Dentist' : 'DENTIST_EMAIL',
            'Delivery' : 'DELIVERY_EMAIL',
            'Manager' : 'MANAGER_EMAIL', 
            'Store' : 'EMAIL'
        }
        print(self.__AccountType)
        fname = self.__sql.select_query(self.__AccountType, [fname_dict[self.__AccountType]], f"{email_dict[self.__AccountType]} = '{self.__email}'")[fname_dict[self.__AccountType]][0]
        lname = "" if self.__AccountType == "Store" else self.__sql.select_query(self.__AccountType, [lname_dict[self.__AccountType]], f"{email_dict[self.__AccountType]} = '{self.__email}'")[lname_dict[self.__AccountType]][0]
        self.__Name = f"{fname} {lname}"
    
    def __SendEmail(self):



        mail_content = f'''Hello {self.__Name},
        Welcome to Dentista :) 
        Here is your verification code to complete your sign up,
        Code: {self.__code},
        Thank you for joining Dentista <3
        '''
        
        #The mail addresses and password
        sender_address = 'storedentista@gmail.com'
        sender_pass = '@dentist1'
        receiver_address = self.__email
        #Setup the MIME
        message = MIMEMultipart()
        message['From'] = sender_address
        message['To'] = receiver_address
        message['Subject'] = 'Dentista Complete your sign up'   #The subject line
        #The body and the attachments for the mail
        message.attach(MIMEText(mail_content, 'plain'))
        #Create SMTP session for sending the mail
        session = smtplib.SMTP('smtp.gmail.com', 587) #use gmail with port
        session.ehlo()
        session.starttls() #enable security
        session.login(sender_address, sender_pass) #login with mail_id and password
        text = message.as_string()
        session.sendmail(sender_address, receiver_address, text)
        session.quit()
        print('Mail Sent')


        
    def __close_connection(self): # Destructor
        self.__sql.close_connection()



def ConfirmEmail():
    Code = request.json['Code']
    email = request.json['email']
    EmailConfirmation(email, Code)
    return '1'

