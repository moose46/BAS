Attribute VB_Name = "Export"
Option Compare Database
' ran 4/1/2020 for testing rwc

Public Sub RunExports()
Debug.Print "Starting Export AR_Customer"
DoCmd.RunSavedImportExport ("AR_Customer")
Debug.Print "AR_Customer Completed"

Debug.Print "Starting Export PO_PurchaseOrderHeader"
DoCmd.RunSavedImportExport ("PO_PurchaseOrderHeader")
Debug.Print "PO_PurchaseOrderHeader Completed"

Debug.Print "Starting Export PO_PurchaseOrderDetail"
DoCmd.RunSavedImportExport ("PO_PurchaseOrderDetail")
Debug.Print "PO_PurchaseOrderDetail Completed"

Debug.Print "Starting Export SO_SalesOrderHeader"
DoCmd.RunSavedImportExport ("SO_SalesOrderHeader")
Debug.Print "SO_SalesOrderHeader Completed"

Debug.Print "Starting Export SO_SalesOrderHeader"
DoCmd.RunSavedImportExport ("SO_SalesOrderHeader")
Debug.Print "SO_SalesOrderHeader Completed"

Debug.Print "Starting Export PO_VendorPurchaseAddress"
DoCmd.RunSavedImportExport ("PO_VendorPurchaseAddress")
Debug.Print "PO_VendorPurchaseAddress Completed"

Debug.Print "Starting Export AP_Vendor"
DoCmd.RunSavedImportExport ("AP_Vendor")
Debug.Print "AP_Vendor Completed"




Debug.Print
Debug.Print "Export all tables Completed ...."
End Sub
