#!/bin/bash
# --------------------------------------------------------------------------
# run_apex_export_demo.sh
#
# Re-exports the ErrorShield Demo app (10401) into this repo: split
# APEXlang source (apex/apex_export_demo.sql) and single-file .sql
# (apex/apex_export_single_file_demo.sql). Mirrors run_apex_export.sh for
# the real admin app (10400), kept as a separate script so touching the
# demo app never regenerates 10400's export tree.
#
# Deletes the previous apex/apex_lang/app_10401/ split export before
# recreating it, so no stale files from removed pages/components are left
# behind. The single-file export doesn't need this: -overwrite-files
# overwrites that one file directly.
#
# Usage (from anywhere):
#   ./scripts/run_apex_export_demo.sh
# --------------------------------------------------------------------------

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"
cd "$repo_root"

rm -rf apex/apex_lang/app_10401

sql -nolog <<'EOF'
connect -name "AI LOGGER_USER"
@apex/apex_export_demo.sql
@apex/apex_export_single_file_demo.sql
exit
EOF
