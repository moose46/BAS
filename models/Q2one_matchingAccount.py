__author__ = 'Robert W. Curtiss'
__project__ = 'Breathing Air Solutions'

from models.account import Account
import sys,csv

from models.constants import EXPORT_FOLDER

"""
====================================================
Author: Robert W. Curtiss
    Project: Breathing Air Solutions
    File: one_matchingAccountQ2
    Created: Feb, 14, 2020
    
    Description:
    
===================================================
"""
class AccountOneMatchingQ2(object):
    def __init__(self, cursor, export_path):
        self.header_col = []
        self.export_path = export_path
        self.cursor = cursor
        print('Init Q2')

    def export_to_csv(self, serial_number):
        """
        1. MAS with No Matching SLX Accounts
        :return:
        """
        account = Account()

        kwargs = {'newline': ''}
        mode = 'w'
        if sys.version_info < (3, 0):
            kwargs.pop('newline', None)
            mode = 'wb'
        fpError = open(self.export_path + serial_number + 'Q2DATA_ERRORS.csv', "w", **kwargs)
        error_writer = csv.writer(fpError, delimiter=',', dialect="excel")
        error_writer.writerow(self.get_headers())

        with open(self.export_path + serial_number + 'Q2DATA.csv', mode, **kwargs) as fp:
            writer = csv.writer(fp, delimiter=',', dialect="excel")
            c = self.cursor.tables(table='Q2DATA')
            try:
                self.cursor.execute("SELECT * FROM Q2DATA")
            except Exception as e:
                print(e)
            writer.writerow(self.header_col)
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

                # account.internalId = row.internalId
                # row.internalId = account.internalId

                account.urlAddress = row.URLAddress
                row.URLAddress = account.urlAddress

                # print(row.CustomerName, row.CreditLimit,
                #      xForm.ARDivision(row.ARDivisionNo))
                if account.hasErrors():
                    error_writer.writerow(row)
                    account.clearErrors()
                else:
                    writer.writerow(row)
            print("Export Q2DATA Completed OK ....")

    def get_headers(self):
        c = self.cursor.execute("SELECT * FROM INFORMATION_SCHEMA.COLUMNS" \
                                " WHERE TABLE_NAME = N'Q2DATA'")
        for x in c:
            self.header_col.append(x[3])
        return self.header_col
