# Export APEX App (DB → repo)

Two flavors, run from the repo root (paths are relative to cwd):

- `apex/apex_export.sql` — split APEXlang source into `apex/apex_lang/app_10400/`.
- `apex/apex_export_single_file.sql` — single-file `.sql` export into `apex/apex_single_file/`.

Already connected:

```sql
@apex/apex_export.sql
@apex/apex_export_single_file.sql
```

Fresh terminal:

```bash
cd /Users/angel.flores/GIT/p_aftorres02/OracleAPEX-ErrorShield

sql -nolog <<'EOF'
connect -name "AI LOGGER_USER"
@apex/apex_export.sql
@apex/apex_export_single_file.sql
exit
EOF
```

Review the diff before committing — this overwrites both output folders:

```bash
git diff apex/apex_lang/app_10400 apex/apex_single_file
```
