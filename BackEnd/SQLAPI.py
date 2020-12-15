# Import dependinces
import mysql.connector
from mysql.connector import errorcode
from datetime import datetime
# -------------------------------------------------------------------------------------------

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
        print(Query)
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
        for c_v in columns_values_dict:
            Query = Query + c_v + " = " + columns_values_dict[c_v] + ", "
        
        Query = Query[:-1]
        Query = Query + " WHERE " + sql_condition + ";"

        try:
            self.cursor.execute(Query)
            now = datetime.now()
            current_time = now.strftime("%H:%M:%S")
            Logs = "Update table [ " + table + " ] at " + current_time + " is done correctly\n"
            self.logs_file.write(Logs)
        except :
            Logs = "ERROR in Update table [ " + table + " ] at " + current_time + "\n"
            self.logs_file.write(Logs)

    def select_query(self, table, columns, sql_condition = ""):
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
        
        self.conn.commit()
        self.cursor.close()
        self.conn.close()
        self.logs_file.write("Connection is Closed")
        self.logs_file.close()

        

    
