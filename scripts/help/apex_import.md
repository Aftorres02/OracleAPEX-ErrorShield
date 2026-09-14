# Import APEX App (repo → DB)

Pushes `apex/apex_lang/` into a target schema/workspace, replacing
application 10400 there. Run from `release/` (uses `../apex/apex_lang`,
relative to cwd). Schema/workspace come from `release/load_env_vars.sql`.

Already connected:

```sql
@load_env_vars.sql
@../scripts/apex_install.sql
```

Fresh terminal:

```bash
cd /Users/angel.flores/GIT/p_aftorres02/OracleAPEX-ErrorShield/release

sql -nolog <<'EOF'
connect -name "AI LOGGER_USER"
@load_env_vars.sql
@../scripts/apex_install.sql
exit
EOF
```
