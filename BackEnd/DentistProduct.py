from SQLAPI import SQL
from flask import request
import json

'''
server_name = "dentista1.mysql.database.azure.com"
server_admin = "dentista@dentista1"
server_password = "@dentist1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]
'''

server_name = "localhost"
server_admin = "root"
server_password = "@dentist1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]

def NoProducts():
    prod = request.json['product']
    sql = SQL(server_name, server_admin)
    result = sql.select_query("PRODUCT", ['PRODUCT_ID'])
    print(result)
    try:
        noprod = result['PRODUCT_ID']
        print(noprod)
        return str(len(noprod))

    except:
        return '0'


def FetchProducts():
    index = request.json['index']
    sql = SQL(server_name, server_admin)
    Prod_Query = sql.select_general('PRODUCT', ['PRODUCT_ID', 'PRODUCT_NAME', 'SELLING_PRICE', 'IMAGE_URL', 'RATE', 'DESCRIPTION', 'Brand', 'NO_OF_REVIEWERS', 'CATEGORY'], f" Limit {index}, 1")
    Output = {}
    Output['ProductID'] = Prod_Query['PRODUCT_ID'][0]
    Output['ProductName'] = Prod_Query['PRODUCT_NAME'][0]
    Output['Price'] = Prod_Query['SELLING_PRICE'][0]
    Output['Category'] = Prod_Query['CATEGORY'][0]
    Output['ImageURL'] = Prod_Query['IMAGE_URL'][0]
    Output['Rate'] = Prod_Query['RATE'][0]
    Output['Description'] = Prod_Query['DESCRIPTION'][0]
    Output['Brand'] = Prod_Query['Brand'][0]
    Output['NoOfReviews'] = Prod_Query['NO_OF_REVIEWERS'][0]

    # Offer is remaining
    offer_query = sql.select_query('OFFERS', ['DISCOUNT'], f"PRODUCT_ID = {Output['ProductID']}")
    try:
        Output["discount"] = offer_query['DISCOUNT'][0]
    except:
        Output["discount"] = 0
    
    print(Output)
    
    return json.dumps(Output)



def SearchProduct():
    search_context = request.json['SearchContext']
    sql = SQL(server_name, server_admin)
    Query = f"SELECT * FROM PRODUCT WHERE MATCH (PRODUCT_NAME) AGAINST ('{search_context}' IN NATURAL LANGUAGE MODE);"
    
    result = sql.exectute_query(Query)
    PRODUCT_ID, PRODUCT_NAME, PRICE, SELLING_PRICE, IMAGE_URL, NUMBER_OF_UNITS, STORE_ID, RATE, NO_OF_REVIEWERS, CATEGORY, Brand, DESCRIPTION = result
    print(PRODUCT_NAME)



