# import regex
from emailaddressvalidator import EmailAddressValidator
import phonenumbers
from phonenumbers import NumberParseException
from urllib.parse import urlparse, ParseResult, urlsplit
import models.constants
import csv
import xlrd as x


class Customer(object):
    """
    Customer Import and Translations
        Source: Account Instructions.docx

        Description:
            Data Migrations Account:

            Translate ARDivision from Number to State Code

            AR_Customer.UDF_BWID = ExternalID
                AR_Customer.UDF_BWID (or CustomerNo without the leading “0”
                This only applies to the Customer with no matching SLX accounts. . .
                for the customers WITH matching SLX accounts the external ID
                will come from the SLX Internal ID.

            INDIVIDUAL:
                In the import file, the field name in Netsuite is “ISPERSON”
                and the default value for import is “False”
                (even though we know some are individuals and not companies,
                we don’t have the time to go through them and identify the individuals)
            PRIMARY_SUBSIDARY:
                In the import file, the field name in NetSuite is “PRIMARY SUBSIDIARY”
                and the default value for import is “Breathing Air Systems”

            Check EMail address for proper format

            Check Customer Phone Number for Proper Format

            Translate TaxSchedule If = NONTAX then “False”, else = “True”

            Translate TermsCode:
                Update Terms to - "50% Dep - 50% Prior to Ship "WHERE AR_Customer.TermsCod)="05"
                    Update Terms to - "COD" WHERE AR_Customer.TermsCode="02”
                    Update Terms to - "Due Upon Receipt" WHERE AR_Customer.TermsCod)="06"
                    Update Terms to - "Net 10" WHERE AR_Customer.TermsCode="09"
                    Update Terms to - "Net 30 W/Approved Credit" WHERE AR_Customer.TermsCode="36"
                    Update Terms to - "PrePaid" WHERE AR_Customer.TermsCode="00" OR AR_Customer.TermsCode="01" OR AR_Customer.TermsCode="11"
                    Update Terms to - "PrePaid Wire Transfer" WHERE AR_Customer.TermsCode="08"
                    Update Terms to - "50% Dep - 50% Net 30 Startup" WHERE AR_Customer.TermsCode="50"
            Update CountryCode:
                Two Digit Country Codes need to be converted to full name of the Country.
                To view the list of Country names in NetSuite, go to Setup/Company/Countries.
                I’m sure you probably have a table to use for cross reference . . .
                some of the names are weird, i.e.
                Russia must be Russian Federation, North Korea must be Korea,
                Democratic People’s Republic and South Korea must be Korea,
                Republic of

            Update Address_defaultBilling:
                In the import file, the field name in Netsuite is Address1_defaultBilling
                and the default value for import for accounts from MAS is “True”.
                (In later translations when mapping child accounts from
                 SLX the default billing will be “false” when importing.

            Update Address_defaultBilling:
                In the import file, the field name in NetSuite is Address1_defaultShipping
                 and the default value for import for accounts from MAS is “False”.
                 (In later translations when mapping child accounts from SLX it will be “True”
    """

    def __init__(self, import_path):
        self.import_path = import_path
        self.error = False
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
        self.fieldNames = ["CompanyName",
                           "InfoCRMAccountName",
                           "CreditLimit",
                           "UDFNameBranchOrgin",
                           "EMail",
                           "CustomerID",
                           "STATUS",
                           "ExternalID",
                           "FAX",
                           "INDIVIDUAL",
                           "Phone",
                           "PRIMARY_SUBSIDIARY",
                           "Taxable",
                           "Terms",
                           "WebAddress",
                           "Address1",
                           "Address2",
                           "Address3",
                           "City",
                           "Country",
                           "Address_defaultBilling",
                           "Address_defaultShipping",
                           "State",
                           "Zip",
                           "NSuiteId"]

    def import_excel(self, file_name):
        wb = x.open_workbook(file_name)
        sheet = wb.sheet_by_index(0)
        print(sheet.cell_value(0,0))

    def hasErrors(self):
        return self.nsuiteIdError\
            or self.arDivisionError\
            or self.phoneError\
            or self.termsError\
            or self.urlAddressError \
            or self.internalIdError

    def clearErrors(self):
        self.nsuiteIdError = False
        self.phoneError = False
        self.termsError = False
        self.arDivisionError = False
        self.urlAddressError = False
        self.internalIdError = False

    @property
    def internalId(self):
        self._internalId = ""
        if self.nsuiteIdError:
            self._internalId = "@@@@"

        return self._internalId

    @internalId.setter
    def internalId(self, value):
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
        else:
            self._urlAddress = ''

    #=== Terms Code ==================================================
    @property
    def termsCode(self):
        if self.termsError:
            self._termsCode = "@@" + self._termsCode + "@@"
        return self._termsCode

    @termsCode.setter
    def termsCode(self, value):
        if value in "05":
            self._termsCode = "50% Dep - 50% Prior to Ship"
        elif value in "30":
            self._termsCode = "Net 30"
        elif value in "02":
            self._termsCode = "COD"
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
        self._telephoneNo = ""
        if value is None:
            return ""
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
        self._ARDivisionNo = ""
        """Look up cus"""
        try:
            x = int(value)
        except:
            self.arDivisionError = True

        self._ARDivisionNo = models.ARDIVISIONS[x]


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
        if value is None:
            return ""
        self._emailAddress = value
        self._emailAddress = self._emailAddress.strip().replace(' ', '').replace('>', '')
        try:
            EmailAddressValidator()(self._emailAddress.lower())
            self._emailAddress = self._emailAddress.lower()

        except Exception as e:
            # email Not Valid
            self.error = True
# @property
# def Account(self):
#	return self.account
# @property
# def CreditLimit(self):
#	return self.creditLimit
