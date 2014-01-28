use utf8;
package Schema;

use strict;
use warnings;

use base 'DBIx::Class::Schema';

our $VERSION = <%= version %>;

__PACKAGE__->load_namespaces;

1;
