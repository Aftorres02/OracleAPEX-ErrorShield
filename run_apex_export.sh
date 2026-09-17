#!/bin/bash
# --------------------------------------------------------------------------
# run_apex_export.sh
#
# Re-exports the ErrorShield APEX app (10400) into this repo: split
# APEXlang source (apex/apex_export.sql) and single-file .sql
# (apex/apex_export_single_file.sql).
# Deletes the previous apex/apex_lang/app_10400/ split export before
# recreating it, so no stale files from removed pages/components are left
# behind. The single-file export doesn't need this: -overwrite-files
# overwrites that one file directly.
#
# Usage:
#   cd "/Users/angel.flores/GIT/p_aftorres02/OracleAPEX-ErrorShield"
#   ./run_apex_export.sh
# --------------------------------------------------------------------------

cd "/Users/angel.flores/GIT/p_aftorres02/OracleAPEX-ErrorShield"

# Clean up the previous split export here (not inside SQLcl's "host" command -
# on this machine SQLcl's host command fails with "Cannot run program bash",
# since the Java process it launches doesn't inherit a usable PATH).
rm -rf apex/apex_lang/app_10400

sql -nolog <<'EOF'
connect -name "AI LOGGER_USER"
@apex/apex_export.sql
@apex/apex_export_single_file.sql
exit
EOF
