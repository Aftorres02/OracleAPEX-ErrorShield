set termout off
-- setting termout off as this view will install with an error as it depends on ersh_logger.date_text_format
create or replace force view ersh_logger_logs_terse as
 select id, logger_level, 
        substr(ersh_logger.date_text_format(time_stamp),1,20) time_ago,
        substr(text,1,200) text
   from ersh_logger_logs
  where time_stamp > systimestamp - (5/1440)
  order by id asc
/

set termout on
