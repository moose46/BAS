__author__ = 'Robert W. Curtiss'
__project__ = 'Breathing Air Solutions'
import os
from os import listdir
from os.path import isfile, join
import shutil

from models.constants import EXPORT_FOLDER, ARCHIVE_FOLDER

"""
====================================================
Author: Robert W. Curtiss
    Project: Breathing Air Solutions
    File: file_man
    Created: Feb, 19, 2020
    
    Description:
    
===================================================
"""
class FileMan(object):
    """
    Manages files files in and out of babble fish
    """
    def __init__(self, archive, export_folder):
        #print("FileMan Created....")
        self.archive = archive
        self.export_folder = export_folder

    def clean_export_to(self):
        """ move all files in the export to kathy direct to the
        archive directory"""

        os.chdir(self.export_folder)
        files = [f for f in listdir(self.export_folder) if isfile(join(self.export_folder, f))]
        for f in files:
            shutil.move(f, join(self.archive, f))