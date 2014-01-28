use utf8;
package Schema::Result::<%= _.capitalize(name) %>;

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("<%= pluralize(name) %>");
__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  <% _.each(attrs, function (attr) { %>
  "<%= attr.attrName %>",
  <% if (attr.attrName == 'Enum' || attr.attrName == 'String') { %>{ data_type => "varchar", is_nullable => <% if (attr.required) { %>1<% } else { %>0<% }; %>, size => 255 },<% } else { %>{ data_type => "<%= attr.attrType.toLowerCase() %>", is_nullable => <% if (attr.required) { %>1<% } else { %>0<% }; %> },<% }; %>
  <% }); %>
);
__PACKAGE__->set_primary_key("id");

sub TO_JSON {
  my $self  = shift;
  return {
    id => $self->id,
    <% _.each(attrs, function (attr) { %>
    <%= attr.attrName %> => $self-><%= attr.attrName %><% if (attr.attrName == 'Date') { %> ? substr($self-><%= attr.attrName %>, 0, 10) : ""<% } else if (attr.attrName == 'Boolean') { %> ? \1 : \0<% }; %>,
    <% }); %>
  }
}

1;
