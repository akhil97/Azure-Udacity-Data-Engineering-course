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

CREATE EXTERNAL TABLE dim_datetime_cetas
WITH (
    LOCATION = 'dimensions/dim_datetime/',
    DATA_SOURCE = [myfilesystem_mydatalakestorage1000_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT DISTINCT
    CAST(started_at AS date) AS calendar_date,
    YEAR(started_at) AS year,
    DATEPART(quarter, started_at) AS quarter,
    MONTH(started_at) AS month,
    DAY(started_at) AS day_of_month,
    DATEPART(weekday, started_at) AS day_of_week,
    DATENAME(weekday, started_at) AS day_name,
    DATEPART(hour, started_at) AS hour_of_day
FROM dbo.Trip
UNION
SELECT DISTINCT
    CAST(ended_at AS date),
    YEAR(ended_at),
    DATEPART(quarter, ended_at),
    MONTH(ended_at),
    DAY(ended_at),
    DATEPART(weekday, ended_at),
    DATENAME(weekday, ended_at),
    DATEPART(hour, ended_at)
FROM dbo.Trip;
GO

SELECT TOP 100 * FROM dbo.dim_datetime_cetas
GO

