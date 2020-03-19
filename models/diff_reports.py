__author__ = 'Robert W. Curtiss'
__project__ = 'Breathing Air Solutions'

import csv
import sys

"""
====================================================
Author: Robert W. Curtiss
    Project: Breathing Air Solutions
    File: diff_reports
    Created: Feb, 26, 2020
    
    Description:
    
===================================================
"""
class ReportDiff(object):
    def __init__(self, cursor, export_path):
        self.cursor = cursor
        self.export_path = export_path
        self.header_col = []
    def export_terms_diff_csv(self, serial_number):
        """
        Look in mas and see if there any new accounts
        if so, then create new_account.csv file
        """
        """
        the parent account number is the last 6 digit from AMS
        the child account numbers are the same account number
            plus -1,-2,... etc

        """
        c = self.cursor.tables(table='BAS3_TERMS_DIFF')
        self.get_headers("BAS3_TERMS_DIFF")
        kwargs = {'newline': ''}
        mode = 'w'
        if sys.version_info < (3, 0):
            kwargs.pop('newline', None)
            mode = 'wb'
        with open(self.export_path + serial_number +'BAS3 Terms Diff.csv', mode, **kwargs) as fp:
            writer = csv.writer(fp, delimiter=',', dialect="excel")
            writer.writerow(self.header_col)
            self.cursor.execute("select * from BAS3_TERMS_DIFF")
            okCnt = 0
            for row in self.cursor.fetchall():

                writer.writerow(row)
                okCnt += 1
        print("Export BAS 3 Terms Diff OK ...", okCnt)

    def export_address_diff_csv(self, serial_number):
        """
        Look in mas and see if there any new accounts
        if so, then create new_account.csv file
        """
        """
        the parent account number is the last 6 digit from AMS
        the child account numbers are the same account number
            plus -1,-2,... etc

        """
        c = self.cursor.tables(table='Q6_ADDRESS_DIFF')
        self.get_headers("Q6ADDRESS_DIFF")
        kwargs = {'newline': ''}
        mode = 'w'
        if sys.version_info < (3, 0):
            kwargs.pop('newline', None)
            mode = 'wb'
        with open(self.export_path + serial_number +'Q6 Address Diff.csv', mode, **kwargs) as fp:
            writer = csv.writer(fp, delimiter=',', dialect="excel")
            writer.writerow(self.header_col)
            self.cursor.execute("select * from Q6ADDRESS_DIFF")
            okCnt = 0
            for row in self.cursor.fetchall():

                writer.writerow(row)
                okCnt += 1
        print("Export Q6 Address Diff OK ...", okCnt)
    def export_bas2_csv(self, serial_number):
        c = self.cursor.tables(table='BAS2_BWCUSTOMERID')
        self.get_headers("BAS2_BWCUSTOMERID")
        kwargs = {'newline': ''}
        mode = 'w'
        if sys.version_info < (3, 0):
            kwargs.pop('newline', None)
            mode = 'wb'
        with open(self.export_path + serial_number +'BAS2_BWCUSTOMERID.csv', mode, **kwargs) as fp:
            writer = csv.writer(fp, delimiter=',', dialect="excel")
            writer.writerow(self.header_col)
            self.cursor.execute("select * from BAS2_BWCUSTOMERID")
            okCnt = 0
            for row in self.cursor.fetchall():

                writer.writerow(row)
                okCnt += 1
        print("Export BAS2_BWCUSTOMERID OK ...", okCnt)
    def get_headers(self, table_Name):
        self.table_name = table_Name
        self.header_col = []
        c = self.cursor.execute("SELECT * FROM INFORMATION_SCHEMA.COLUMNS"\
                                " WHERE TABLE_NAME = N'" + self.table_name +"'")
        for x in c:
            self.header_col.append(x[3])
        return self.header_col

