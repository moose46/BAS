select ItemCode from SO_SalesOrderDetail
--where itemCode like 'X%'
group by itemCode
order by itemCode