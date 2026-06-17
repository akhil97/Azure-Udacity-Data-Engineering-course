IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'myfilesystem_mydatalakestorage1000_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [myfilesystem_mydatalakestorage1000_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://myfilesystem@mydatalakestorage1000.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE fact_payment_cetas
WITH (
    LOCATION = 'facts/fact_payment/',
    DATA_SOURCE = [myfilesystem_mydatalakestorage1000_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT
    p.payment_id,
    p.account_number,
    p.date AS payment_date,
    p.amount,
    1 AS payment_count
FROM dbo.Payment p;
GO

SELECT TOP 100 * FROM dbo.fact_payment_cetas
GO
