declare
  l_scope ersh_logger_logs.scope%type := 'demo.params';
  
  -- Simulates parameters 
  l_num number := 1;
  l_date date := sysdate;
  l_boolean boolean := false;
  
  l_params ersh_logger.tab_param;
begin
  ersh_logger.append_param(l_params, 'l_num', l_num);
  ersh_logger.append_param(l_params, 'l_date', l_date);
  ersh_logger.append_param(l_params, 'l_boolean', l_boolean);
  
  ersh_logger.log('START', l_scope, null, l_params);
  

  ersh_logger.log('END', l_scope);
end;
/



-- Look at the EXTRA column in the Start log
select *
from ersh_logger_logs
where 1=1
  and scope = 'demo.params'
order by 1 desc;


