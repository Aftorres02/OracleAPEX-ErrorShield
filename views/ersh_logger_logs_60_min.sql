create or replace force view ersh_logger_logs_60_min as
	select * 
      from ersh_logger_logs 
	 where time_stamp > systimestamp - (1/24)
/
