from flask import Flask, jsonify, request

from SQLAPI import SQL
import json
import Dentist
import Manager
from validate_email import validate_email

from Verifications import Validator

app = Flask(__name__)




server_name = "dentista1.mysql.database.azure.com"
server_admin = "dentista@dentista1"
server_password = "@dentist1"
database = "DENTISTA"



#app.add_url_rule('/email_validation', view_func=Verifications.email_validate, methods = ['POST'])
#app.add_url_rule('/phone_validation', view_func=Verifications.phone_validate, methods = ['POST'])
#app.add_url_rule('/email_validation', view_func=Validator([server_name, server_admin], 'DENTIST').email_validation('DENTIST_EMAIL'), methods = ['POST'])

app.add_url_rule('/dentist_signup', view_func=Dentist.dentist_insertion, methods = ['POST'])
app.add_url_rule('/dentist_email_validation', view_func=Dentist.dentist_email_validation, methods = ['POST'])
app.add_url_rule('/dentist_phone_validation', view_func=Dentist.dentist_phone_validation, methods = ['POST'])
app.add_url_rule('/dentist_creditcard_validation', view_func=Dentist.dentist_CreditCard_validation, methods = ['POST'])
app.add_url_rule('/manager_signup' , view_func=Manager.Manager_Insertion, methods=['POST'])
app.add_url_rule('/manager_email_validation' , view_func=Manager.Manager_email_validator , methods=['POST'])

def run_server(debug=False):
    app.run(debug=debug)

if __name__ == "__main__":
    run_server(debug=False)





