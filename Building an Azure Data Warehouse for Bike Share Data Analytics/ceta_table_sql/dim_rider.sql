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

CREATE EXTERNAL TABLE dim_rider_cetas
WITH (
    LOCATION = 'dimensions/dim_rider/',
    DATA_SOURCE = [myfilesystem_mydatalakestorage1000_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT
    r.rider_id,
    r.account_number,
    r.address,
    r.first,
    r.last,
    r.birthday,
    a.member AS is_member,
    a.start_date AS account_start_date,
    a.end_date AS account_end_date
FROM dbo.Rider r
LEFT JOIN dbo.Account a
    ON r.account_number = a.account_number;
GO

SELECT TOP 100 * FROM dbo.dim_rider_cetas
GO
