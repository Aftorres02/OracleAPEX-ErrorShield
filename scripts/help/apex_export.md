# Export APEX App (DB → repo)

Two flavors, run from the repo root (paths are relative to cwd):

- `apex/apex_export.sql` — split APEXlang source into `apex/apex_lang/app_10400/`.
- `apex/apex_export_single_file.sql` — single-file `.sql` export into `apex/apex_single_file/`.

Recommended: run the wrapper, from anywhere in the repo.

```bash
./scripts/run_apex_export.sh
```

It resolves the repo root from its own location (so it works regardless of
where the repo is cloned), `rm -rf`s `apex/apex_lang/app_10400/` before the
split export (so files left over from deleted pages/components don't stick
around — the split export only overwrites files it still generates, it
doesn't delete stale ones), then runs both export scripts against
`"AI LOGGER_USER"`.

Already connected in SQLcl:

```sql
@apex/apex_export.sql
@apex/apex_export_single_file.sql
```

Manual alternative (fresh terminal, no wrapper):

```bash
cd "$(git rev-parse --show-toplevel)"

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
