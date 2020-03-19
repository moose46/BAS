__author__ = 'Robert W. Curtiss'
__project__ = 'BabbleFishV2'

"""
====================================================
Author: Robert W. Curtiss
Author: Robert W. Curtiss
    Project: Breathing Air Solutions
    File: validation
    Created: Feb, 05, 2020
    
    Description:
    
===================================================
"""


class Validation():
    def __init__(self):
        self.ARDIVISIONS = ["OH", "FL", "MI", "TN", "IL", "PA", "OH", "NC"]


    def ARDivision(self,ARDivisionNo=""):
        """
        Passed ARDivision string 00 .. 02 ... 07
        If not in the list or not a number return the string back
        :param ARDivisionNo:
        :return:
        """
        try:
            x = int(ARDivisionNo)
            return self.ARDIVISIONS[x]
        except Exception as e:
            return ARDivisionNo

