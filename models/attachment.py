__author__ = 'Robert W. Curtiss'
__project__ = 'Breathing Air Solutions'

import pyodbc
import regex
from os import path

"""
====================================================
Author: Robert W. Curtiss
    Project: Breathing Air Solutions
    File: attachment
    Created: Mar, 04, 2020
    
    Description:
    
===================================================
"""
SQL = r"select  ACCOUNTID, filename,description,createdate from ATTACHMENT where filename like 'Mail Merge\U6UJ9A000037%'"


class Attachment(object):
    def __init__(self, db):
        self.db = db

    def get_one_row(self):
        try:
            self.db.execute(SQL)
            rows = self.db.fetchall()
            return rows[1]
        except Exception as e:
            print(e)

    def get_one_parsed(self):
        inOut = []
        try:
            self.db.execute(SQL)
            rows = self.db.fetchall()
            inOut.append(rows[1][1])
            txtin = ''.join(rows[1][1])
            txt = regex.split(r"\\", txtin)

            filename = path.join(txt[0], rows[1][0], txt[2])
            inOut.append(filename)
            # cmd = "copy '" + inOut[0] + "' '" + filename + "'"

            return inOut
        except Exception as e:
            print(e)

    def insert_many(self):
        self.db.execute(SQL)
        rows = self.db.fetchall()
        inOut = []
        # self.db.execute("truncate table attachment_was_is")
        # self.db.execute.commit()
        for row in rows:
            inOut = []
            txt = ''
            txtin = ''
            inOut.append(row[1])
            txtin = ''.join(row[1])
            txt = regex.split(r"\\", txtin)

            filename = path.join(txt[0], row[0], txt[2])
            inOut.append(filename)
            try:
                x = self.db.execute("insert into attachment_was_is (SourceFileName," \
                                    " TargetFileName, ExternalId) VALUES ('"
                                    + inOut[0] + "','" \
                                    + filename + "','" \
                                    + row[0] + "')")
                self.db.commit()
            except Exception as e:
                print(e)
