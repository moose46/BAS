-- checks to see of nesuite matches terms in MAS

SELECT
	ac.CustomerName
   ,n.ID
   ,ac.TermsCode AS 'MAS TERMS'
	--,tm.NS, tm.MAS
   ,n.Terms AS 'NS Terms'
   ,ac.DateUpdated AS 'MAS Date Update'
   ,n.[Last Modified] AS 'NS Date Updated' INTO BAS3_TERMS_DIFF

FROM AR_CUSTOMER ac
	,TERMS_MAP tm
	,NSCUSTOMERS n
WHERE ac.TermsCode = tm.MAS
AND ac.UDF_BWID = n.ID
AND tm.NS <> n.Terms