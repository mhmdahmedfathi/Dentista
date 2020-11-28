from flask import Flask, jsonify, request
import pyodbc
import string
app = Flask(__name__)


server = 'dentista.database.windows.net'

database = 'Dentista'

username = 'yousefgamal'

password = 'Y2o9u5s2e0f00@'

driver= '{ODBC Driver 17 for SQL Server}'

@app.route("/")
def welcome():
    return "Hello, World!"




dentist_exsist = False

@app.route('/dentistlogin', methods = ['POST', 'GET'])
def dentistlogin():
    request_data = request.get_json()

    email = str(request_data['email']).translate({ord(c): None for c in string.whitespace})
    _password = str(request_data['password']).translate({ord(c): None for c in string.whitespace})


    global server
    global database
    global username
    global password
    global driver
    is_exist = False

    with pyodbc.connect('DRIVER='+driver+';SERVER='+server+';PORT=1433;DATABASE='+database+';UID='+username+';PWD='+ password) as conn:
        with conn.cursor() as cursor:
            cursor.execute(f"SELECT * FROM [dbo].[DENTISTS] WHERE DENTIST_EMAIL = '{email}' AND DENTIST_PASSWORD = '{_password}'")
            row = cursor.fetchone()
            while row:
                is_exist = True
                row = cursor.fetchone()

    global dentist_exsist
    dentist_exsist = is_exist



@app.route('/dentistlogin_get')
def dentistresponse():
    global dentist_exsist
    print(dentist_exsist)
    json_file = {}
    json_file['correctdata'] = dentist_exsist
    print(json_file['correctdata'])
    return jsonify(json_file)



@app.route('/dentist_signup', methods = ['POST'])
def DentistSignUP():
    request_data = request.get_json()
    print("request_data")
    fname = request_data['fname']
    lname = request_data['lname']
    email = request_data['email']
    _password = request_data['password']
    cliniclocation = request_data['cliniclocation']
    faculty = request_data['faculty']
    gender = request_data['Gender']
    day = request_data['day']
    month = request_data['month']

    global server
    global database
    global username
    global password
    global driver
    print(fname)

    with pyodbc.connect('DRIVER='+driver+';SERVER='+server+';PORT=1433;DATABASE='+database+';UID='+username+';PWD='+ password) as conn:
        with conn.cursor() as cursor:
            cursor.execute("INSERT INTO [dbo].[DENTISTS]  (DENTIST_FNAME, DENTIST_LNAME, DENTIST_EMAIL, DENTIST_PASSWORD, DENTIST_CLINIC_LOCATION, DENTIST_FACULTY, DENTIST_GENDER, DENTIST_DAYOFBIRTH, DENTIST_MONTHOFBIRTH) VALUES (?,?,?,?,?,?,?,?,?)", fname,lname,email,_password,cliniclocation,faculty, gender, day, month)
            #row = cursor.fetchone()



    


@app.route('/calculator', methods = ['GET', 'POST'])
def calculator():
    request_data = request.get_json()
    global choice
    choice =    str(request_data['command'])
    #print(choice) 
    var = ' '
    if choice == 'a':
        var = 'You choosed a'
    elif choice == 'b':
        var = 'You choosed b'
    else:
        var = 'you neither choosed a, or b'

    json_file = {}

    json_file['query'] = var

    return jsonify(json_file)

