__author__ = 'Robert W. Curtiss'
__project__ = 'BabbleFishV2'

# import netsuite
import csv, sys, codecs, io
# import pandas as pd

from models.customer import Customer

"""Data Source: DataMap One Matching SLX Accounts"""
MAS_WITH_NO_MATCHING = "SELECT * FROM Slx_account_ext" + \
                       " RIGHT JOIN AR_Customer " + \
                       " ON Slx_account_ext.BWCUSTOMERID = AR_Customer.UDF_BWID" + \
                       " WHERE (((Slx_account_ext.[﻿ACCOUNTID]) Is Null)) ORDER BY AR_Customer.CustomerName;"

Q2DATA = "SELECT * FROM Q2DATA"
Q3DATA_PARENT = "select * from q3data_parent"
Q3DATA_CHILDREN = "select * from q3data_children"

"""


"""


class Accounts():
    """
    Account Data Import Module

    Description:
        Make sure to have the most recent CRM export from SLX and MAS
        They should be linked, or imported into the
        BabbleFish.accdb access database as
        SLX_ACCOUNT
        SLX_ACCOUNT_EXT
        ARCustomer
        You should also have the latest csv export ALL from Netsuite
        This should be linked into BabbleFish as NsCustomer
        This table will have all the current updates to the customer
        data from Netsuite and will used to generate the csv file
        for production import
    ===================================================
    """
    # def load_ar_customer(self):
    #     try:
    #         df = pd.read_excel(r"C:\Users\me\Source\Repos\BabbleFishV4\BabbleFishV3\ar_customer_lt.xlsx", sheet_name="ar_customer_lt")
    #         df.head()
    #         print(df.columns)
    #         columns = df.shape[1]
    #         rows = df.shape[0]
    #         print(df.loc[12,"City"])
    #         for columns in df.iterrows():
    #             print(columns)
    #     except Exception as e:
    #         print(e)
    # #     with open('ar_customer_lt.xlsx', newline='') as fp:
    # #         reader = csv.reader(fp,  dialect="excel")
    # #         for row in reader:
    # #             print(row)
    def __init__(self, cursor):
        self.cursor = cursor

    def account_address(self):
        cust = Customer()
        c = self.cursor.tables(table='ACCOUNT_ADDRESS_DTATA')
        self.cursor.execute(Q2DATA)


    def q1_mas_with_no_matching_accounts(self):
        pass


    def q2_mas_with_one_slx_account(self):
        """
        1. MAS with No Matching SLX Accounts
        :return:
        """
        cust = Customer()

        c = self.cursor.tables(table='Q2DTATA')
        self.cursor.execute(Q2DATA)

        kwargs = {'newline': ''}
        mode = 'w'
        if sys.version_info < (3, 0):
            kwargs.pop('newline', None)
            mode = 'wb'
        fpError = open('Q2DATA_ERRORS.csv', "w", **kwargs)
        error_writer = csv.writer(fpError, delimiter=',', dialect="excel")
        header = cust.fieldNames
        error_writer.writerow(header)

        with open('Q2DATA.csv', mode, **kwargs) as fp:
            writer = csv.writer(fp, delimiter=',', dialect="excel")
            writer.writerow(header)
            for row in self.cursor.fetchall():

                cust.arDivisionNo = row.ARDivisionNo
                row.ARDivisionNo = cust.arDivisionNo

                cust.emailAddress = row.EmailAddress
                row.EmailAddress = cust.emailAddress

                cust.telephoneNo = row.TelephoneNo
                row.TelephoneNo = cust.telephoneNo

                cust.taxable = row.TaxSchedule
                row.TaxSchedule = cust.taxable

                cust.termsCode = row.TermsCode
                row.TermsCode = cust.termsCode

                # cust.internalId = row.internalId
                # row.internalId = cust.internalId

                cust.urlAddress = row.URLAddress
                row.URLAddress = cust.urlAddress

                # print(row.CustomerName, row.CreditLimit,
                #      xForm.ARDivision(row.ARDivisionNo))
                if cust.hasErrors():
                    error_writer.writerow(row)
                    cust.clearErrors()
                else:
                    writer.writerow(row)


    def q3_mas_with_many_slx_accounts_parent(self):
        """
        the parent account number is the last 6 digit from AMS
        the child account numbers are the same account number
            plus -1,-2,... etc

        """
        cust = Customer()

        c = self.cursor.tables(table='Q3DATA_PARENT')
        self.cursor.execute(Q3DATA_PARENT)

        kwargs = {'newline': ''}
        mode = 'w'
        if sys.version_info < (3, 0):
            kwargs.pop('newline', None)
            mode = 'wb'
        fpError = open('Q3DATA_PARENT_ERRORS.csv', "w", **kwargs)
        error_writer = csv.writer(fpError, delimiter=',', dialect="excel")
        header = cust.fieldNames
        error_writer.writerow(header)
        with open('Q3PARENT.csv', mode, **kwargs) as fp:
            writer = csv.writer(fp, delimiter=',', dialect="excel")
            writer.writerow(header)

            for row in self.cursor.fetchall():

                cust.arDivisionNo = row.ARDivisionNo
                row.ARDivisionNo = cust.arDivisionNo

                cust.emailAddress = row.EmailAddress
                row.EmailAddress = cust.emailAddress

                cust.telephoneNo = row.TelephoneNo
                row.TelephoneNo = cust.telephoneNo

                cust.taxable = row.TaxSchedule
                row.TaxSchedule = cust.taxable

                cust.termsCode = row.TermsCode
                row.TermsCode = cust.termsCode

                # cust.internalId = row.internalId
                # row.internalId = cust.internalId

                cust.urlAddress = row.URLAddress
                row.URLAddress = cust.urlAddress

                # print(row.CustomerName, row.CreditLimit,
                #      xForm.ARDivision(row.ARDivisionNo))
                if cust.hasErrors():
                    error_writer.writerow(row)
                    cust.clearErrors()
                else:
                    writer.writerow(row)


    def q3_mas_with_many_slx_accounts_children(self):
        """
        Look in mas and see if there any new accounts
        if so, then create new_account.csv file
        """
        """
        the parent account number is the last 6 digit from AMS
        the child account numbers are the same account number
            plus -1,-2,... etc
    
        """
        cust = Customer()

        c = self.cursor.tables(table='Q3DATA_PARENT')
        self.cursor.execute(Q3DATA_CHILDREN)

        kwargs = {'newline': ''}
        mode = 'w'
        if sys.version_info < (3, 0):
            kwargs.pop('newline', None)
            mode = 'wb'
        fpError = open('Q3DATA_CHILDREN_ERRORS.csv', "w", **kwargs)
        error_writer = csv.writer(fpError, delimiter=',', dialect="excel")
        header = cust.fieldNames
        error_writer.writerow(header)
        with open('Q3CHILDREN.csv', mode, **kwargs) as fp:
            writer = csv.writer(fp, delimiter=',', dialect="excel")
            writer.writerow(header)

            for row in self.cursor.fetchall():

                cust.arDivisionNo = row.ARDivisionNo
                row.ARDivisionNo = cust.arDivisionNo

                cust.emailAddress = row.EmailAddress
                row.EmailAddress = cust.emailAddress

                cust.telephoneNo = row.TelephoneNo
                row.TelephoneNo = cust.telephoneNo

                cust.taxable = row.TaxSchedule
                row.TaxSchedule = cust.taxable

                cust.termsCode = row.TermsCode
                row.TermsCode = cust.termsCode

                # cust.internalId = row.internalId
                # row.internalId = cust.internalId

                cust.urlAddress = row.URLAddress
                row.URLAddress = cust.urlAddress

                # print(row.CustomerName, row.CreditLimit,
                #      xForm.ARDivision(row.ARDivisionNo))
                if cust.hasErrors():
                    error_writer.writerow(row)
                    cust.clearErrors()
                else:
                    writer.writerow(row)


    def q5_changed_mas_accounts(self):
        """
        Look at netsuite email, phone and web address
        and see if it matches
        If not select the data in mas and update it with the ns data
        then create a changed_account.csv file
        """
        pass
