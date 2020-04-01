__author__ = 'Robert W. Curtiss'
__project__ = 'BabbleFish'

"""
====================================================
Author: Robert W. Curtiss
    Project: Breathing Air Solutions
    File: constants
    Created: Feb, 03, 2020
    
    Description:
    
===================================================
"""
EXPORT_FOLDER = r"C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\export_to_kathy\\"
ARCHIVE_FOLDER = r"C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\export_to_kathy\archive\\"
IMPORT_FOLDER = r"C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\data_from_crm"

TEST1_DATASOURCE = "C:\\Users\\me\\Source\\Repos\\BabbleFishV4\\BabbleFishV3\\data\\BabbleFish.accdb"


# Document from Kathy Accounts
CUSTOMER_IMPORT_QRY_1 = "SELECT * FROM Slx_account_ext" + \
    " RIGHT JOIN AR_Customer " +\
    " ON Slx_account_ext.BWCUSTOMERID = AR_Customer.UDF_BWID" + \
    " WHERE (((Slx_account_ext.[﻿ACCOUNTID]) Is Null)) ORDER BY AR_Customer.CustomerName;"

Q2DATA = "SELECT * FROM Q2DATA"
Q3DATA_PARENT = "select * from q3data_parent"
Q3DATA_CHILDREN = "select * from q3data_children"
