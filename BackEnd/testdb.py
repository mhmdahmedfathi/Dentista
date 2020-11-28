'''
This Code is a template how to use the database class
'''
from database_tempelate import Database as db
db_conn = db('DESKTOP-FBAD4BP',"CompanyDBLab4")

Output = db_conn.query("SELECT fname FROM Employee WHERE fname = 'Franklin';")
db_conn.convert_to_json(['fname'])
print(db_conn.json_output)