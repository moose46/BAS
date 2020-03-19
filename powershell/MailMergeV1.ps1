cd C:\Users\Administrator.SUBA\Documents


#\\crm\SalesLogixLan\SLXLanDocuments
#\\crm\SalesLogixLan\SLXLanDocuments\Mail Merge

cd p:\bcurtiss\export
$MM = dir -directory "\\crm\SLXLanDocuments\Mail Merge\U6UJ9A000037*" 
$MM | foreach-object {gci -Recurse $_| % FullName} >> U6UJ9A000037_FULLNAME

#>> U6UJ9A000037.txt

  #>> MailMergeDIr.txt

#copy "\\CRM\SalesLogixLan\SLXLanDocuments\Mail Merge\U6UJ9A00000A (01-07-2009 11.43.25 AM)\Quote Template (Long Description) (EDDIE TAYLOR) 01-07-2009 11.44.32 AM.doc" .\MailMerge\