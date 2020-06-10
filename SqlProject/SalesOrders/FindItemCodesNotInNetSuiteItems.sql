select Name, 'N' as Match into itemsTemp from items where name  in (
select replace(sod.ItemCode,'/','')
FROM [babblefish].[dbo].[SO_SalesOrderHeader] soh
LEFT JOIN SO_SalesOrderDetail sod ON sod.SalesOrderNo = soh.SalesOrderNo
LEFT JOIN AR_Customer arc ON arc.CustomerNo = soh.CustomerNo
WHERE
  OrderType = 'R'
  AND soh.DateCreated >= DATEADD(YEAR, -1, GETDATE()))  --AND soh.SalesOrderNo LIKE '%74886%')
ORDER BY name
--  sod.SalesOrderNo,
--  sod.LineSeqNo

select replace(sod.ItemCode,'/','') as itemCode
FROM [babblefish].[dbo].[SO_SalesOrderHeader] soh
LEFT JOIN SO_SalesOrderDetail sod ON sod.SalesOrderNo = soh.SalesOrderNo
LEFT JOIN AR_Customer arc ON arc.CustomerNo = soh.CustomerNo
WHERE
  OrderType = 'R'
  AND soh.DateCreated >= DATEADD(YEAR, -1, GETDATE())  --AND soh.SalesOrderNo LIKE '%74886%')
group by itemCode
ORDER BY itemCode

