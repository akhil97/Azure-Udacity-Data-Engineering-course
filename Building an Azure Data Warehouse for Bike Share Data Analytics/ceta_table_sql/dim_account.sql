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

CREATE EXTERNAL TABLE dbo.dim_account
	WITH (
	LOCATION = 'dim_account',
	DATA_SOURCE = [myfilesystem_mydatalakestorage1000_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
	AS
SELECT
    account_number,
    member,
    start_date,
    end_date
FROM dbo.Account;
GO

SELECT TOP 100 * FROM dbo.dim_account
GO
