import pyodbc # Loading the database library



class Database:


    def __init__(self, server_name, database = "Dentista"):     # Constructor

        # Connection Arguments
        self.server = server_name
        self.database = database
        # -----------------------------------

        # Formalizatoin of output using two different methods into list / dictionary [to convert to json]
        self.Outputs = []
        self.json_output = {}
        # -----------------------------------

        # Open the Connection 
        conn = pyodbc.connect('Trusted_Connection=yes', driver = '{SQL Server}',
                      server = self.server, database = self.database) 
        self.cursor = conn.cursor() # Cursor [to excute]
        


    def query(self, Query):
        # Query is a string of the query
        try :
            self.cursor.execute(Query)      # Execute the query

            row = self.cursor.fetchone()    # row deals with the outcomes of the query 
            self.Outputs.append(row)
            while row:                      # Loop to all columns to append them to a list          
                row = self.cursor.fetchone()
                self.Outputs.append(row)
            
            if self.Outputs[-1] == None:
                self.Outputs = self.Outputs[:-1]    #This line to prevent the None 

            return self.Outputs
        
        except:
            return None

    def convert_to_json(self, columns):

        try :

            n = len(columns)  # Defines the number of Columns

            for i in range(n):
                self.json_output[columns[i]] = [] # Initialize the dictionary

            for output in self.Outputs: #Appending to dictionary
                for i in range(n):
                    self.json_output[columns[i]].append(output[i])
            
            return self.json_output
        except:
            return None


        




        


