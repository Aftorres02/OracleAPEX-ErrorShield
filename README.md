# OracleAPEX-ErrorShield

Enterprise error handling for Oracle APEX: maps constraints and custom errors to
friendly messages, optional masking of internal errors, and instrumentation via
the **OraOpenSource Logger** stack (`logger` package and `logger_*` objects).

## License

This project is released under the [MIT License](LICENSE).

## Third-party / credits

**Logger** (packages, tables, views, jobs, contexts, procedures, and related
scripts) is **vendored from**
[OraOpenSource/logger](https://github.com/OraOpenSource/logger), **Copyright
(c) 2015 OraOpenSource**, under the MIT License. The snapshot used in this tree
is recorded in [`NOTICE`](NOTICE) (git commit). A verbatim upstream copy of the
MIT text is in
[`licenses/OraOpenSource-Logger-LICENSE.txt`](licenses/OraOpenSource-Logger-LICENSE.txt).

**ErrorShield** additions (e.g. `ersh_error_handler_api`, `ersh_error_lookup`,
`ersh_constraint_lookup`) are MIT-licensed in this repo as well; see `LICENSE`.

## Layout

- `packages/logger.pks` / `logger.pkb` — upstream Logger
- `packages/ersh_error_handler_api.*` — ErrorShield error API
- `contexts/`, `procedures/` — Logger install helpers from upstream
- `scripts/logger_create_user.sql` — upstream schema-creation script copy

## Standards

Project coding standards are defined in [`AGENTS.md`](AGENTS.md).
