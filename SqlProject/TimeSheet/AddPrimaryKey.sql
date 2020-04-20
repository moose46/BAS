--alter table timesheets
--add constraint pk_timesheets primary key (TimeSheetNumber)
use babblefish
GO

alter table ITEMCODE_MAS_NS
add CONSTRAINT pk_mas_ns primary key (id)
--add constraint pk_timesheets primary key (TimeSheetNumber)

Alter Table Items
Add Id Int Identity(1, 1)
Go
alter table Items
add CONSTRAINT pk_items PRIMARY KEY (id)



alter table ITEMCODE_MAS_NS
add CONSTRAINT pk_icmn primary key (id)
--select * from Items where [internal id] = 2463--

select * from items where [base price] is null
and vendor <> 'DISCONTINUED'