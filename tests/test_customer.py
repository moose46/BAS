__author__ = 'Robert W. Curtiss'
__project__ = 'Breathing Air Solutions'

import csv
from unittest import TestCase

import pyodbc

from models.constants import IMPORT_FOLDER

"""
====================================================
Author: Robert W. Curtiss
    Project: Breathing Air Solutions
    File: test_customer
    Created: Feb, 19, 2020
    
    Description:
    
===================================================
"""
import xlrd as x
import re


class TestCustomer(TestCase):
    def test_open_excel(self):
        p = re.compile('A6UJ9A*')
        xSafe = re.compile('xSAFE*')
        a = re.compile('A4*')
        errFile = open(IMPORT_FOLDER + r"\slx_account_err.csv", 'w', newline='')
        err_writer = csv.writer(errFile)
        header = ["ACCOUNTID"]
        err_writer.writerow(header)
        cleanFile = open(IMPORT_FOLDER + r"\slx_account_clean.csv", 'w', newline='')
        clean_writer = csv.writer(cleanFile)
        headerList = []

        cnt = 0
        with open(IMPORT_FOLDER + r'\slx_account.csv') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                if cnt == 0:
                    dl = []
                    for key, value in row.items():
                        dl.append(key)
                    clean_writer.writerow(dl)

                if not p.match(row['ACCOUNTID'])\
                        and not xSafe.match(row['ACCOUNTID'])\
                        and not a.match(row['ACCOUNTID']):
                    print(row)
                    dictList = []
                    # for key,value in row.items():
                    dictList.append(row['ACCOUNTID'])
                    s = row['ACCOUNTID']
                    # line = ','.join(dictList)
                    err_writer.writerow(dictList)
                    cnt += 1
                else:
                    dl = []
                    for key,value in row.items():
                            dl.append(value)
                    clean_writer.writerow(dl)
                    cnt += 1
                    if cnt == 500:
                        exit(12)
        self.assertTrue(self)
