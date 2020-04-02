SELECT  ac.CustomerName,n.[Company Name], sa.Status, n.[External ID], n.[Internal ID]
FROM NSCustomers n, SLX_Account_ext sae, SLX_Account sa, AR_Customer ac
WHERE sae.BWCUSTOMERID = n.[External ID]
AND sa.ACCOUNTID = sae.ACCOUNTID
AND ac.UDF_BWID = sae.BWCUSTOMERID
AND n.[External ID] = '800582'
AND sa.Status = 'Active'
ORDER BY n.[External ID]