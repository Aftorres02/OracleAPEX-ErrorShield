-- Run in the ErrorShield owner schema when upgrading from the two-template setup.
-- Preserve customized base messages; replace only the previous default.
update logger_prefs
   set pref_value = 'Unable to process this action. If the issue persists, please contact {SUPPORT_EMAIL}.'
 where pref_type = 'ERSH'
   and pref_name = 'MASKED_ERROR_MESSAGE'
   and pref_value = 'Unable to process this action. If the issue persists, please contact {SUPPORT_EMAIL} quoting reference {REFERENCE}.';

delete from logger_prefs
 where pref_type = 'ERSH'
   and pref_name = 'MASKED_ERROR_MESSAGE_NO_REF';

commit;
