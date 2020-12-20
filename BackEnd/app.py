from flask import Flask, jsonify, request
import numpy as np
#from SQLAPI import SQL
#import pyodbc
app = Flask(__name__)


server = "dentista1.mysql.database.azure.com"

database = 'DENTISTA'

username = 'dentista@dentista1'

password = '@dentist1'

driver= '{ODBC Driver 17 for SQL Server}'
'''
@app.route("/")
def welcome():
    return "Hello, World!"

'''

@app.route("/")
def Dentist():
    x = np.array([1, 2, 3, 4])
    x = x[0]
    x = str(x)
    return x



