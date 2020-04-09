use babblefish
go
-- run this after importing vendors from NetSuite
select nsv.[External ID], nsv.[Internal ID] from NS_Vendors nsv
--where [External ID] not like ('_%')
group by [External ID], [Internal ID]
--having count(*) > 1
update NS_Vendors set [External Id] = 'NONE-' + CONVERT(varchar, [Internal ID])
where [External ID] not like ('_%')
