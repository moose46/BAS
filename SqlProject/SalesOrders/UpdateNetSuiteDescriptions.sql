use babblefish
GO
UPDATE SO_COOKED
SET NetSuiteDescription = Description
FROM
SO_COOKED
INNER join Items on name = SO_COOKED.final_part
