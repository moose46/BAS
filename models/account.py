__author__ = 'Robert W. Curtiss'
__project__ = 'Breathing Air Solutions'
from emailaddressvalidator import EmailAddressValidator
import phonenumbers
from phonenumbers import NumberParseException
from urllib.parse import urlparse, ParseResult, urlsplit
import models.constants
from datetime import datetime

ARDIVISIONS = ["OH", "FL", "MI", "TN", "IL", "PA", "OH", "NC"]

"""
====================================================
Author: Robert W. Curtiss
    Project: Breathing Air Solutions
    File: account
    Created: Feb, 14, 2020
    
    Description:
    
===================================================
"""
class Account(object):

    def __init__(self):
        self.now = datetime.now()

        self.invalidEmailAddressError = False
        self.phoneError = False
        self.termsError = False
        self.arDivisionError = False
        self.urlAddressError = False
        self.internalIdError = False
        self.nsuiteIdError = False
        self._customerName = ""
        self.account = ""
        self.creditLimit = ""
        self._ARDivisionNo = ""
        self._emailAddress = ""
        self._NSEmailAddress = ""  # From Netsuite
        self._udf_bwid = ""
        self._accountID = ""
        self._NSExternalID = ""  # From Netsuite
        self._faxNo = ""
        self._nsFaxNo = ""  # from Netsuite
        self._individual = "False"
        self._telephoneNo = ""
        self._taxSchedule = ""
        self._taxable = "TaxCodeError"
        self._termsCode = ""
        self.URLAddress = ""
        self.AddressLine1 = ""
        self.AddressLine2 = ""
        self.AddressLine3 = ""
        self.City = ""
        self.CountryCode = ""
        self.State = ""
        self.Zip = ""
        self._urlAddress = ""
        self._internalId = ""
        self.errorCount = 0

    # def serialNumber(self):
    #     return self.now.strftime("%m%d%H-")
    def hasErrors(self):
        return self.nsuiteIdError \
               or self.arDivisionError \
               or self.phoneError \
               or self.termsError \
               or self.urlAddressError \
               or self.internalIdError or self.invalidEmailAddressError


    def clearErrors(self):
        self.nsuiteIdError = False
        self.phoneError = False
        self.termsError = False
        self.arDivisionError = False
        self.urlAddressError = False
        self.internalIdError = False
        self.errorCount = 0
        self.invalidEmailAddressError = False


    @property
    def internalId(self):
        self._internalId = ""
        if self.nsuiteIdError:
            self._internalId = "@@@@"

        return self._internalId


    @internalId.setter
    def internalId(self, value):
        self.nsuiteIdError = False
        self._internalId = ""
        if value == None:
            self.nsuiteIdError = True
        self._internalId = value


    @property
    def urlAddress(self):
        if self.urlAddressError:
            self._urlAddress = "@@" + self._urlAddress + "@@"
        return self._urlAddress


    @urlAddress.setter
    def urlAddress(self, value):
        self._urlAddress = ""
        if value is not None:
            o = urlparse(value)
            if o.scheme in '':
                o = urlparse('http://' + value)
            url = o.geturl()
            self._urlAddress = url.lower()
            if  'http://' == self.urlAddress:
                self._urlAddress = ''
        else:
            self._urlAddress = ''


    # === Terms Code ==================================================
    @property
    def termsCode(self):
        if self.termsError:
            self._termsCode = "@@" + self._termsCode + "@@"
        return self._termsCode


    @termsCode.setter
    def termsCode(self, value):
        self.termsError = False
        if value in "05":
            self._termsCode = "50% Dep - 50% Prior to Ship"
        elif value in "02":
            self._termsCode = "COD"
        elif value in "30":
            self._termsCode = "Net 30"
        elif value in "06":
            self._termsCode = "Due Upon Receipt"
        elif value in "09":
            self._termsCode = "Net 10"
        elif value in "36":
            self._termsCode = "Net 30 w/Approved Credit"
        elif value in "00" or value in "01" or value in "11":
            self._termsCode = "PrePaid"
        elif value in "08":
            self._termsCode = "PrePaid Wire Transfer"
        elif value in "50":
            self._termsCode = "50% Dep - 50% Net 30 Startup"
        else:
            self._termsCode = value
            self.termsError = True


    @property
    def taxable(self):
        return self._taxable


    @taxable.setter
    def taxable(self, value):
        self._taxable = ""
        if value is None:
            # self.invalidEmailAddressError = True
            self._taxable = "False"
            return
        if value in 'NONTAX':
            self._taxable = "False"
        else:
            # self.invalidEmailAddressError = True
            self._taxable = value


    @property
    def telephoneNo(self):
        if self.phoneError:
            self._telephoneNo = "@@" + self._telephoneNo + "@@"
        return self._telephoneNo


    @telephoneNo.setter
    def telephoneNo(self, value):
        self.phoneError = False
        self._telephoneNo = ""
        if value is None or value == '':
            self._telephoneNo = ''
            return
        self._telephoneNo = value.replace('(', '') \
            .replace(')', '') \
            .replace(' ', '').replace('-', '')
        try:
            if len(self._telephoneNo) != 10:
                self.phoneError = True
            # x = phonenumbers.is_possible_number(value, 'US')
            self._telephoneNo = phonenumbers.parse(self.telephoneNo, 'US')
            self._telephoneNo = phonenumbers.format_number(self._telephoneNo, phonenumbers.PhoneNumberFormat.NATIONAL)
        except NumberParseException as e:
            self.phoneError = True

        return self._telephoneNo


    @property
    def udf_bwid(self):
        return self._udf_bwid


    @udf_bwid.setter
    def udf_bwid(self, value):
        self._udf_bwid = value


    @property
    def accoundID(self):
        return self._accountID


    @accoundID.setter
    def accoundID(self, value):
        self._accountID = value


    @property
    def arDivisionNo(self):
        if self.arDivisionError:
            self.arDivisionNo = "@@" + self._ARDivisionNo + "@@"
        return self._ARDivisionNo


    @arDivisionNo.setter

    def arDivisionNo(self, value):
        self.arDivisionError = False
        self._ARDivisionNo = ""
        """Look up cus"""
        try:
            x = int(value)
            self._ARDivisionNo = ARDIVISIONS[x]
        except:
            self.arDivisionError = True


    def getRow(self):
        pass


    def checkEMail(self):
        pass


    @property
    def customerName(self):
        return self._customerName


    @customerName.setter
    def customerName(self, value):
        self._customerName = value


    @property
    def emailAddress(self):
        return self._emailAddress


    @emailAddress.setter
    def emailAddress(self, value):
        self._emailAddress = ""
        self.invalidEmailAddressError = False
        if value is None:
            return ""
        self._emailAddress = value
        self._emailAddress = self._emailAddress.strip().replace(' ', '').replace('>', '')
        try:
            EmailAddressValidator()(self._emailAddress.lower())
            self._emailAddress = self._emailAddress.lower()

        except Exception as e:
            # email Not Valid
            #self.invalidEmailAddressError = True
            pass

