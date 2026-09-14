# Export APEX App (DB → repo)

Pulls application 10400 from the database into `apex/apex_lang/`. Run from
the repo root (uses `-dir apex`, relative to cwd).

Already connected:

```sql
@apex/apex_export.sql
```

Fresh terminal:

```bash
cd /Users/angel.flores/GIT/p_aftorres02/OracleAPEX-ErrorShield

sql -nolog <<'EOF'
connect -name "AI LOGGER_USER"
@apex/apex_export.sql
exit
EOF
```

Review the diff before committing — this overwrites `apex/apex_lang/`:

```bash
git diff apex/apex_lang
```
