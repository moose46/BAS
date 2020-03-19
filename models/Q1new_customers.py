__author__ = 'Robert W. Curtiss'
__project__ = 'BabbleFishV3'
import datetime

from models.account import Account
from models.constants import EXPORT_FOLDER
from models.customer import Customer

"""
====================================================
Author: Robert W. Curtiss
Class: CSCI-1511
    Project: BabbleFishV3
    File: new_customers
    Created: Feb, 13, 2020
    
    Description:
    
===================================================
"""
import csv
import sys

class NewCustomersQ1():
    def __init__(self, cursor, export_path):
        self.cursor = cursor
        self.export_path = export_path
        self.header_col = []
        self.get_headers()
        print('Init Q1')

    def import_excel(self, file_name):
        c = Customer()
        c.import_excel(file_name=file_name)

    def export_to_csv(self, serial_number):
        account = Account()
        try:
            c = self.cursor.tables(table='[Q1DATA]')
        except Exception as e:
            print(e)
            exit()
        kwargs = {'newline': ''}
        mode = 'w'
        if sys.version_info < (3, 0):
            kwargs.pop('newline', None)
            mode = 'wb'
        fp = open(self.export_path + serial_number+ 'Q1DATA.csv', "w", newline='')
        writer = csv.writer(fp)
        try:
            writer.writerow(self.header_col)
            self.cursor.execute('select * from Q1DATA')
            okCnt = 0
            for r in self.cursor.fetchall():
                writer.writerow(r)
                okCnt += 1
        except Exception as e:
            print(e)
        print("Export Q1(New Accounts) Completed OK .... ", okCnt)

    def get_headers(self):
        c = self.cursor.execute("SELECT * FROM INFORMATION_SCHEMA.COLUMNS"\
                                " WHERE TABLE_NAME = N'Q1DATA'")
        for x in c:
            self.header_col.append(x[3])
