dbic-migration prepare --schema_class Schema -Ilib
dbic-migration upgrade --schema_class Schema -Ilib --to_version $1
dbic-migration status --schema_class Schema -Ilib

