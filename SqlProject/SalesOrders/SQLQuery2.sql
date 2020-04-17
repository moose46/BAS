select SalesOrderNo, LineKey, ItemCode, ItemCodeDesc from SO_SalesOrderDetail
where ItemCodeDesc like 'Semi Annual%'
order by SalesOrderNo, LineKey