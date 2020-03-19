USE babblefish
GO

DROP SEQUENCE audit_zipfiles_seq

CREATE SEQUENCE audit_zipfiles_seq
AS BIGINT
START WITH 1
INCREMENT BY 1

SELECT NEXT VALUE FOR audit_zipfiles_seq