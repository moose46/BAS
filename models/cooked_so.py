__author__ = 'Robert W. Curtiss'
__project__ = 'Breathing Air Solutions'

import csv
import sys

from models.excel import MyExcel

"""
====================================================
Author: Robert W. Curtiss
    Project: Breathing Air Solutions
    File: cooked_so
    Created: Mar, 27, 2020
    
    Description:
    
===================================================
"""


class Cooked_SO():
    def __init__(self, cursor, export_path, sheet_name='SalesOrders'):
        self.cursor = cursor
        self.export_path = export_path
        self.header_col = []

        self.itemLine_item = ''
        self.itemLine_description = ''
        self.get_headers()
        self.rows = 0
        self.excel = MyExcel()
        self.sheet_name = '0070853'

        try:
            c = self.cursor.tables(table='[SO_COOKED]')
            self.cursor.execute('select count(*) as cnt from [dbo].[SO_COOKED]')
            count = self.cursor.fetchall()
            for c in count:
                self.rows = c.cnt
        except Exception as e:
            print(e)
            exit()



        self.excel.init(self.sheet_name,self.header_col, self.rows)
    print('Init SO_COOKED....')


    def export_to_csv(self, serial_number):
        kwargs = {'newline': ''}
        mode = 'w'
        if sys.version_info < (3, 0):
            kwargs.pop('newline', None)
            mode = 'wb'
        #fp = open(self.export_path + serial_number + 'SO_COOKED.csv', "w", newline='')
        fp = open(self.export_path + 'SO_COOKED_0070853.csv', "w", newline='')
        writer = csv.writer(fp)
        try:
            writer.writerow(self.header_col)
            self.cursor.execute('select * from SO_COOKED order by externalid, LineSeqNo')
            okCnt = 0
            #self.excel.init( '0070853',self.header_col)
            for r in self.cursor.fetchall():
                #add the comment line to line items
                # email dated april, 9th from Kathy Sales Order Line Items Updated
                if r.itemLine_item in '/BAS-PMFL2':
                    r.itemLine_description = 'Semi Annual Preventive Maintenance'
                    writer.writerow(r)
                    self.excel.add_row(r)
                    i = 0
                    for c in r:
                        if i > 4:
                            r[i] = ''
                        i = i + 1
                    r.itemLine_description = 'Stop 1 of 2'
                    writer.writerow(r)
                    self.excel.add_row(r)
                elif r.itemLine_item in '/SLP-HP-WITH MAINTENANCE':
                    r.itemLine_description = 'Single High Pressure Air Test.'
                    writer.writerow(r)
                    self.excel.add_row(r)
                    i = 0
                    for c in r:
                        if i > 4:
                            r[i] = ''
                        i = i + 1
                    r.itemLine_description = 'Quarterly Air Testing'
                    writer.writerow(r)
                    self.excel.add_row(r)
                else:
                    writer.writerow(r)
                    self.excel.add_row(r)

                okCnt += 1
        except Exception as e:
            print(e)
        self.excel.save_workbook(self.export_path + '0070853')
        print("Export Cooked Sales Orders Completed OK .... ", okCnt)


    def get_headers(self):
        c = self.cursor.execute("SELECT * FROM INFORMATION_SCHEMA.COLUMNS" \
                                " WHERE TABLE_NAME = N'SO_COOKED'")
        for x in c:
            self.header_col.append(x[3])
