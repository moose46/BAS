use babblefish 
go

drop table MISSING_SO_CUSTOMERS

SELECT
	externalid
   ,Customer
   ,terms
   ,soc.itemLine_description-- into MISSING_SO_CUSTOMERS
FROM SO_COOKED soc
WHERE not EXISTS (SELECT
		NS_TERMS
	FROM AR_CUSTOMER_TERMS_CODE
	WHERE soc.terms = AR_CUSTOMER_TERMS_CODE.NS_TERMS)
group by externalid, Customer, terms,soc.itemLine_description

