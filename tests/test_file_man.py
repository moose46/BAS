__author__ = 'Robert W. Curtiss'
__project__ = 'Breathing Air Solutions'

import unittest
from unittest import TestCase

from models.constants import EXPORT_FOLDER, ARCHIVE_FOLDER
from models.file_man import FileMan

"""
====================================================
Author: Robert W. Curtiss
    Project: Breathing Air Solutions
    File: test_file_man
    Created: Feb, 19, 2020
    
    Description:
    
===================================================
"""



class TestFileMan(TestCase):
    def test_clean_export_to(self):
        x = FileMan(archive=ARCHIVE_FOLDER,export_folder= EXPORT_FOLDER)
        x.clean_export_to()
        self.assertTrue(self)
