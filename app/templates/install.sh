dbic-migration prepare --schema_class Schema -Ilib
dbic-migration install --schema_class Schema -Ilib
dbic-migration status --schema_class Schema -Ilib

