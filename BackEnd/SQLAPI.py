# Import dependinces
import mysql.connector
from mysql.connector import errorcode
from datetime import datetime
# -------------------------------------------------------------------------------------------

'''
STEPS of Using this API
1. Initialze the constructor with the connection strings
2. At the end of using the API call the close_conncetion method
3. insertion:
    i- pass the table name to the parameter table
    ii- Create a list of the attributes (Columns names) and assign it to the parameter attributes
    iii- Create a list of the values that you want to assign to the attributes and assign it to the parameter values
4. Deletion:
    i- pass the table that you want to delete from to the parameter table
    ii- pass the sql condition of deletion to the parameter sql_condition as you write the exact sql query 
        for example: sql_condition =  " DENTIST_NAME = 'some_name' " (KEEP TRACK on the qouts)
5. UPDATE:
    i- pass the table that you want to delete from to the parameter table
    ii- Create a python dictionary {'key1' : 'value1', 'key2' : 'value2'}, as the key is the column name and the value is the value you want to assign to this column.
    iii- pass the sql condition of update to the parameter sql_condition as you write the exact sql query 
        for example: sql_condition =  " DENTIST_NAME = 'some_name' " (KEEP TRACK on the qouts)
6. SELECT:
    i- pass the table that you want to delete from to the parameter table
    ii- choose the columns that you want to retrive data from, if you want to retrive all the columns write a string '*' and assign it to the parameter columns
    iii- if there is a sql condition pass it to the parameter sql_condition as mentioned before.
    iv- this query will result in a python dictionary or Hash Table, that can be easily converted to a JSON file, so never forget to assign the method call to a variable.
7. Execute_Query: (General Purposed):
    i- Write the Query as a string and assign it to the method
    ii- this function results all rows (if the query results rows)
 8. AT last NEVER FORGET To have a look into database logs file to check that everything goes correctly.


'''





class SQL:
    def __init__(self, host, user, password = "@dentist1", database = 'DENTISTA'):
        self.Config = {
            'host': host,
            'user': user,
            'password':password,
            'database': database
            }
        self.conn = None
        self.cursor = None
        self.logs_file = open("database_logs.txt", "a")
        self.__connection_open()

    
    def __connection_open(self):
        try:
            self.conn = mysql.connector.connect(**self.Config)
            self.logs_file.write("Connection established \n")
        except mysql.connector.Error as err:
            if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
                self.logs_file.write("Something is wrong with the user name or password of server \n")
            elif err.errno == errorcode.ER_BAD_DB_ERROR:
                self.logs_file.write("Database does not exist \n")
            else:
                self.logs_file.write(str(err))
                self.logs_file.write("\n")
        else:
            self.cursor = self.conn.cursor()

    def insert_query(self, table, attributes, values):
        # Generate the Query
        x = 1
        y = "OK"
        Query = "INSERT INTO " + table + "( "
        for attribute in attributes:
            Query = Query + attribute + ", "
        Query = Query[:-2]
        Query = Query + " ) VALUES ( "
        for value in values:
            if type(value) == type(x): #integer
                Query = Query + str(value) + ", "
            else :
                Query = Query + "'" + str(value) + "', "
        Query = Query[:-2]
        Query = Query + " );"

        # ---------------------------------------------
        try:
            self.cursor.execute(Query)
            now = datetime.now()
            current_time = now.strftime("%H:%M:%S")
            Logs = "Insertion into table [ " + table + " ] at " + current_time + " is done correctly\n"
            self.logs_file.write(Logs)
        except :
            now = datetime.now()
            current_time = now.strftime("%H:%M:%S")
            Logs = "ERROR in Insertion into table [ " + table + " ] at " + current_time + "\n"
            self.logs_file.write(Logs)
    
    def delete_query(self, table, sql_condition):
        Query = "DELETE FROM " + table + " WHERE " + sql_condition + " ;"
        try:
            self.cursor.execute(Query)
            now = datetime.now()
            current_time = now.strftime("%H:%M:%S")
            Logs = "Deletion from table [ " + table + " ] at " + current_time + " is done correctly\n"
            self.logs_file.write(Logs)
        except :
            Logs = "ERROR in Deletion from table [ " + table + " ] at " + current_time + "\n"
            self.logs_file.write(Logs)


    def update_query(self, table, columns_values_dict, sql_condition):
        Query = "UPDATE " + table + " SET "
        x = 1
        for c_v in columns_values_dict:
            Query = Query + c_v + " = "
            if type(columns_values_dict[c_v]) == type(x):
                Query = Query + str(columns_values_dict[c_v]) + ','
            else: 
                Query = Query + " '" + columns_values_dict[c_v] + "', "
        
        Query = Query[:-2]
        Query = Query + " WHERE " + sql_condition + ";"

        try:
            self.cursor.execute(Query)
            now = datetime.now()
            current_time = now.strftime("%H:%M:%S")
            Logs = "Update table [ " + table + " ] at " + current_time + " is done correctly\n"
            self.logs_file.write(Logs)
            return 1
        except :
            now = datetime.now()
            current_time = now.strftime("%H:%M:%S")
            Logs = "ERROR in Update table [ " + table + " ] at " + current_time + "\n"
            self.logs_file.write(Logs)
            return 0

    def select_query(self, table, columns, sql_condition = "",DISTINCTdetector=False):
        if DISTINCTdetector == True:
            Query = "SELECT DISTINCT "
        else:
            Query = "SELECT "
        if columns == "*":
            Query = Query + " * "
            Q = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '" + table + "' ;"
            self.cursor.execute(Q)
            rows = self.cursor.fetchall()
            columns = []
            for row in rows:
                for r in row:
                    columns.append(str(r))

        else:
            for column in columns:
                Query = Query + column + ", "
            Query = Query[:-2]
        Query = Query + " FROM " + table
        if sql_condition != "":
            Query = Query + " WHERE " + sql_condition
        Query = Query + ";"

        Result = {}

        try:
            self.cursor.execute(Query)
            now = datetime.now()
            current_time = now.strftime("%H:%M:%S")
            Logs = "Retrive from table " + table + " at " + current_time + " is done correctly\n"
            self.logs_file.write(Logs)

            for column in columns:
                Result[column] = []
            # Appending the results to dictionary
            rows = self.cursor.fetchall()
            for row in rows:
                for index, column in enumerate(columns):
                    Result[column].append(row[index])

        except :
            now = datetime.now()
            current_time = now.strftime("%H:%M:%S")
            Logs = "ERROR in Retrive from table " + table + " at " + current_time + "\n"
            self.logs_file.write(Logs)
        return Result


    def select_general(self, table, columns, sql_condition = "",DISTINCTdetector=False):
        if DISTINCTdetector == True:
            Query = "SELECT DISTINCT "
        else:
            Query = "SELECT "
        if columns == "*":
            Query = Query + " * "
            Q = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '" + table + "' ;"
            self.cursor.execute(Q)
            rows = self.cursor.fetchall()
            columns = []
            for row in rows:
                for r in row:
                    columns.append(str(r))

        else:
            for column in columns:
                Query = Query + column + ", "
            Query = Query[:-2]
        Query = Query + " FROM " + table
        if sql_condition != "":
            Query = Query + " " + sql_condition
        Query = Query + ";"

        Result = {}
        try:
            self.cursor.execute(Query)
            now = datetime.now()
            current_time = now.strftime("%H:%M:%S")
            Logs = "Retrive from table " + table + " at " + current_time + " is done correctly\n"
            self.logs_file.write(Logs)

            for column in columns:
                Result[column] = []
            # Appending the results to dictionary
            rows = self.cursor.fetchall()
            for row in rows:
                for index, column in enumerate(columns):
                    Result[column].append(row[index])

        except :
            now = datetime.now()
            current_time = now.strftime("%H:%M:%S")
            Logs = "ERROR in Retrive from table " + table + " at " + current_time + "\n"
            self.logs_file.write(Logs)
        return Result
    
    def exectute_query(self, Query):
        try:
            self.cursor.execute(Query)
            now = datetime.now()
            current_time = now.strftime("%H:%M:%S")
            Logs = "Query: " + Query +  " at " + current_time + " is done correctly\n"
            self.logs_file.write(Logs)
            return self.cursor.fetchall()
        except :
            now = datetime.now()
            current_time = now.strftime("%H:%M:%S")
            Logs = "ERROR in Query: " + Query +  " at " + current_time + " is done correctly\n"
            self.logs_file.write(Logs)
            return None
    
    def close_connection(self):
        try:
            self.conn.commit()
            self.cursor.close()
            self.conn.close()
            self.logs_file.write("Connection is Closed \n \n")
        except:
            pass
        self.logs_file.close()

        

    
