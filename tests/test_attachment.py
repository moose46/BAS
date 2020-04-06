__author__ = 'Robert W. Curtiss'
__project__ = 'Breathing Air Solutions'

from unittest import TestCase

import pyodbc

from models.attachment import Attachment

"""
====================================================
Author: Robert W. Curtiss
    Project: Breathing Air Solutions
    File: test_attachment
    Created: Mar, 04, 2020
    
    Description:
    
===================================================
"""


class TestAttachment(TestCase):
    def test_get_one_row(self):
        conn = pyodbc.connect("Driver={SQL Server Native Client 11.0};"
                              "Server=daffy-duck;DATABASE=BabbleFish;" \
                              "trusted_connection=yes;")
        # "Database=db_name;"
        # "uid=User;pwd=password")
        cursor = conn.cursor()
        a = Attachment(cursor)
        r = a.get_one_row()
        self.assertTrue(r is not None)

    def test_get_one_parsed(self):
        conn = pyodbc.connect("Driver={SQL Server Native Client 11.0};"
                              "Server=daffy-duck;DATABASE=BabbleFish;" \
                              "trusted_connection=yes;")
        # "Database=db_name;"
        # "uid=User;pwd=password")
        cursor = conn.cursor()
        a = Attachment(cursor)
        r = a.get_one_parsed()
        try:
            x = cursor.execute("insert into attachment_was_is (SourceFileName,"\
                               " TargetFileName, SourcePath, TargetPath) VALUES ('"
                       + r[0] + "','" + r[1] + "', 'YYY','ZZZ' )")
            #conn.commit()
        except Exception as e:
            print(e)

        print(r)
        self.assertTrue(True)

    def test_insert_many(self):
        conn = pyodbc.connect("Driver={SQL Server Native Client 11.0};"
                              "Server=daffy-duck;DATABASE=BabbleFish;" \
                              "trusted_connection=yes;")
        # "Database=db_name;"
        # "uid=User;pwd=password")
        cursor = conn.cursor()
        a = Attachment(cursor)
        r = a.insert_many()

