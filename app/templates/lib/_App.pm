package <%= _.capitalize(baseName) %>;
use Mojo::Base 'Mojolicious';
use Schema;

has schema => sub {
  return Schema->connect('dbi:SQLite:' . ($ENV{MOJO_DB} || 'share/schema.db'));
};

# This method will run once at server start
sub startup {
  my $self = shift;

  $self->helper(db => sub { $self->app->schema });

  # Routes
  my $r = $self->routes;

  $r->get('/')->to('home#index');

  <% _.each(entities, function (entity) { %>
  $r->get('/<%= baseName %>/<%= pluralize(entity.name) %>')->to('<%= pluralize(entity.name) %>#findAll');
  $r->get('/<%= baseName %>/<%= pluralize(entity.name) %>/:id')->to('<%= pluralize(entity.name) %>#find');
  $r->post('/<%= baseName %>/<%= pluralize(entity.name) %>')->to('<%= pluralize(entity.name) %>#create');
  $r->put('/<%= baseName %>/<%= pluralize(entity.name) %>/:id')->to('<%= pluralize(entity.name) %>#update');
  $r->delete('/<%= baseName %>/<%= pluralize(entity.name) %>/:id')->to('<%= pluralize(entity.name) %>#delete');
  <% }); %>
}

1;
