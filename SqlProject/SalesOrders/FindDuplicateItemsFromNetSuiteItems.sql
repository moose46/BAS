SELECT
	Name
   ,i1.Vendor
   ,i1.Description
   ,i1.[Base Price]
   ,i1.[Internal ID]
   ,i1.[External ID]
FROM items i1
WHERE Name = (SELECT
		Name
	FROM items i2
	WHERE i1.Name = i2.name
	GROUP BY Name
	HAVING COUNT(*) > 1)
GROUP BY i1.Name
		,i1.Vendor
		,i1.Description
		,i1.[Base Price]
		,i1.[Internal ID]
		,i1.[External ID]

