import pyodbc

server = 'dentista.database.windows.net'

database = 'Dentista'

username = 'yousefgamal'

password = 'Y2o9u5s2e0f00@'

driver= '{ODBC Driver 17 for SQL Server}'


with pyodbc.connect('DRIVER='+driver+';SERVER='+server+';PORT=1433;DATABASE='+database+';UID='+username+';PWD='+ password) as conn:
    with conn.cursor() as cursor:
        cursor.execute("SELECT DENTIST_FNAME FROM [dbo].[DENTIST] WHERE DENTIST_LNAME = 'Gamal'")
        row = cursor.fetchone()
        while row:
            print (str(row[0]))
            row = cursor.fetchone()