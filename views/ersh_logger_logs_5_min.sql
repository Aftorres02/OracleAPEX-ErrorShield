create or replace force view ersh_logger_logs_5_min as
	select * 
      from ersh_logger_logs 
	 where time_stamp > systimestamp - (5/1440)
/