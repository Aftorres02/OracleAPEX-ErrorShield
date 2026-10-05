#!/bin/bash
# --------------------------------------------------------------------------
# run_apex_export_lab.sh
#
# Re-exports the ErrorShield Error Lab app (10402) into this repo: split
# APEXlang source (apex/apex_export_lab.sql) and single-file .sql
# (apex/apex_export_single_file_lab.sql). Mirrors run_apex_export_demo.sh,
# kept separate so touching the lab never regenerates another app's tree.
#
# Unlike 10400/10401, the lab lives in a CONSUMER workspace, so the export
# must connect as the consumer schema that owns it, not as the ErrorShield
# owner. Pass that saved SQLcl connection name as the first argument.
#
# Deletes the previous apex/apex_lang/app_10402/ split export before
# recreating it, so no stale files from removed components are left behind.
#
# Usage (from anywhere):
#   ./scripts/run_apex_export_lab.sh "<consumer-connection-name>"
# --------------------------------------------------------------------------

set -euo pipefail

connection_name="${1:?Usage: run_apex_export_lab.sh <consumer-connection-name>}"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"
cd "$repo_root"

rm -rf apex/apex_lang/app_10402

sql -nolog <<EOF_SQL
connect -name "${connection_name}"
@apex/apex_export_lab.sql
@apex/apex_export_single_file_lab.sql
exit
EOF_SQL
