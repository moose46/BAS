SELECT
	*
FROM AR_Customer arc
	,MISSING_SO_CUSTOMERS msc
WHERE arc.CustomerNo = msc.Customer


