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

CREATE EXTERNAL TABLE fact_trip_cetas
WITH (
    LOCATION = 'facts/fact_trip/',
    DATA_SOURCE = [myfilesystem_mydatalakestorage1000_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT
    t.trip_id,
    t.rider_id,
    t.account_number,
    t.rideable_type,
    t.start_station_id,
    t.end_station_id,
    t.started_at,
    t.ended_at,
    DATEDIFF(MINUTE, t.started_at, t.ended_at) AS trip_duration_minutes,
    1 AS trip_count
FROM dbo.Trip t;
GO

SELECT TOP 100 * FROM dbo.fact_trip_cetas
GO
