from SQLAPI import SQL
# ------------------------------------------------------------------------------------------------------------------------------
# Connection Arguments of the database
server_name = "dentista1.mysql.database.azure.com"
server_admin = "dentista@dentista1"
server_password = "@dentist1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]
# --------------------------------------------------------------------------------------------------------------------------------
sql = SQL(server_name, server_admin)
Query = """CREATE OR REPLACE VIEW LOGIN_DATA(Email, Password, AccountType) AS SELECT DENTIST_EMAIL , DENTIST_PASSWORD, "Dentist"  FROM DENTIST DENT 
union ALL 
SELECT EMAIL, PASSWORD, "Store" FROM STORE ST
UNION ALL
SELECT MANAGER_EMAIL, MANAGER_PASSWORD, "Manager" FROM MANAGER MNG 
UNION ALL
SELECT DELIVERY_EMAIL, DELIVERY_PASSWORD, "Delivery" FROM DELIVERY DLV;
"""

condition = " AccountType = 'Dentist' "
#sql.exectute_query("INSERT INTO MANAGER(MANAGER_Fname, MANAGER_Lname, MANAGER_EMAIL, MANAGER_PASSWORD, MANAGEMENT_TYPE, AREA_OF_MANAGEMENT) values('Ahmed', 'Ihab', 'Ahmmed.Ihab@gmail.com', '123445', 'store', 'maadi');")
result = sql.select_query(table="LOGIN_DATA", columns=['Email', 'Password'], sql_condition=condition)
print(result)
sql.close_connection()