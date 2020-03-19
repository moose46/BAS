__author__ = 'Robert W. Curtiss'
__project__ = 'Breathing Air Solutions'

from models.account import Account
import csv, sys

from models.constants import EXPORT_FOLDER

"""
====================================================
Author: Robert W. Curtiss
    Project: Breathing Air Solutions
    File: many)MatchingAccountsQ3
    Created: Feb, 14, 2020
    
    Description:
    
===================================================
"""
Q3DATA_PARENT = "select * from q3data_parent"
Q3DATA_CHILDREN = "select * from q3data_children"

class AccountsManyMatchingQ3(object):
    def __init__(self, cursor, export_path):
        self.cursor = cursor
        self.export_path = export_path
        self.header_col = []

    def export_parent_csv(self, serial_number):
        """
        the parent account number is the last 6 digit from AMS
        the child account numbers are the same account number
            plus -1,-2,... etc

        """
        print('Starting Q3 Export')
        c = self.cursor.tables(table='Q3DATA_PARENT')
        account = Account()

        kwargs = {'newline': ''}
        mode = 'w'
        if sys.version_info < (3, 0):
            kwargs.pop('newline', None)
            mode = 'wb'
        fpError = open(self.export_path + serial_number + 'Q3DATA_PARENT_ERRORS.csv', "w", **kwargs)
        error_writer = csv.writer(fpError, delimiter=',', dialect="excel")
        try:
            self.header_col = self.get_headers()
        except Exception as e:
            print(e)
            print("*@*& Export Parent CSV Failed")
            exit()

        error_writer.writerow(self.header_col)
        with open(self.export_path + serial_number + 'Q3PARENT.csv', mode, **kwargs) as fp:
            writer = csv.writer(fp, delimiter=',', dialect="excel")
            writer.writerow(self.header_col)
            okCnt = 0
            errCnt = 0
            self.cursor.execute("SELECT * FROM Q3DATA_PARENT")
            for row in self.cursor.fetchall():
                account.arDivisionNo = row.ARDivisionNo
                row.ARDivisionNo = account.arDivisionNo

                account.emailAddress = row.EmailAddress
                row.EmailAddress = account.emailAddress

                account.telephoneNo = row.TelephoneNo
                row.TelephoneNo = account.telephoneNo

                account.taxable = row.TaxSchedule
                row.TaxSchedule = account.taxable

                account.termsCode = row.TermsCode
                row.TermsCode = account.termsCode

                account.urlAddress = row.URLAddress
                row.URLAddress = account.urlAddress

                if account.hasErrors():
                    error_writer.writerow(row)
                    account.clearErrors()
                    errCnt += 1
                else:
                    writer.writerow(row)
                    okCnt += 1

        print("Export PARENT Q3 OK... ", okCnt, errCnt)
    def export_children_csv(self, serial_number):
        """
        Look in mas and see if there any new accounts
        if so, then create new_account.csv file
        """
        """
        the parent account number is the last 6 digit from AMS
        the child account numbers are the same account number
            plus -1,-2,... etc

        """
        account = Account()

        c = self.cursor.tables(table='Q3DATA_PARENT')
        self.get_headers()
        kwargs = {'newline': ''}
        mode = 'w'
        if sys.version_info < (3, 0):
            kwargs.pop('newline', None)
            mode = 'wb'
        fpError = open(self.export_path + serial_number + 'Q3DATA_CHILDREN_ERRORS.csv', "w", **kwargs)
        error_writer = csv.writer(fpError, delimiter=',', dialect="excel")
        error_writer.writerow(self.header_col)
        with open(self.export_path + serial_number +'Q3CHILDREN.csv', mode, **kwargs) as fp:
            writer = csv.writer(fp, delimiter=',', dialect="excel")
            writer.writerow(self.header_col)
            self.cursor.execute(Q3DATA_CHILDREN)
            okCnt = 0
            errCnt = 0
            for row in self.cursor.fetchall():
                account.arDivisionNo = row.ARDivisionNo
                row.ARDivisionNo = account.arDivisionNo

                account.emailAddress = row.EmailAddress
                row.EmailAddress = account.emailAddress

                account.telephoneNo = row.TelephoneNo
                row.TelephoneNo = account.telephoneNo

                account.taxable = row.TaxSchedule
                row.TaxSchedule = account.taxable

                account.termsCode = row.TermsCode
                row.TermsCode = account.termsCode

                account.urlAddress = row.URLAddress
                row.URLAddress = account.urlAddress

                if account.hasErrors():
                    error_writer.writerow(row)
                    account.clearErrors()
                    errCnt += 1
                else:
                    writer.writerow(row)
                    okCnt += 1
        print("Export CHILDREN Q3 OK ...", okCnt,errCnt)
    def get_headers(self):
        c = self.cursor.execute("SELECT * FROM INFORMATION_SCHEMA.COLUMNS"\
                                " WHERE TABLE_NAME = N'Q3DATA_PARENT'")
        for x in c:
            self.header_col.append(x[3])
        return self.header_col

