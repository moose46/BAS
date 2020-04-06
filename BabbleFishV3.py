import ast
import csv

import pyodbc

import os
from os import sys, path

#from pandas.tests.dtypes.test_missing
#import now

from models.Q3accountsManyMatching import AccountsManyMatchingQ3
from models.constants import EXPORT_FOLDER, ARCHIVE_FOLDER
from models.file_man import FileMan
from models.Q1new_customers import NewCustomersQ1
from models.Q2one_matchingAccount import AccountOneMatchingQ2
from datetime import datetime
from models.diff_reports import ReportDiff
sys.path.append(path.dirname(path.dirname(path.abspath(__file__))))

AR_CUSTOMER = r"C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\import_from_bas\02172020\AR_Customer.xlsx"

try:

    conn = pyodbc.connect("Driver={SQL Server Native Client 11.0};"
                        "Server=daffy-duck;DATABASE=BabbleFish;"\
                          "trusted_connection=yes;")
                        #"Database=db_name;"
                        #"uid=User;pwd=password")
    cursor = conn.cursor()
    now = datetime.now()
    serial_number = now.strftime("%m%d%H-")
    """ Clean up export dir """


    fm = FileMan(ARCHIVE_FOLDER, EXPORT_FOLDER)
    fm.clean_export_to()
    q1 = NewCustomersQ1(cursor, EXPORT_FOLDER)
    #q1.import_excel(AR_CUSTOMER)
    q1.export_to_csv(serial_number)
    q2 = AccountOneMatchingQ2(cursor, EXPORT_FOLDER)
    q2.export_to_csv(serial_number)
    q3 = AccountsManyMatchingQ3(cursor, EXPORT_FOLDER)
    q3.export_parent_csv(serial_number)
    q3.export_children_csv(serial_number)
    bas3 = ReportDiff(cursor, EXPORT_FOLDER)
    bas3.export_terms_diff_csv(serial_number)
    bas3.export_address_diff_csv(serial_number)
    bas3.export_bas2_csv(serial_number)
except Exception as e:
    print(e)
