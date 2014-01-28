package <%= _.capitalize(baseName) %>::<%= _.capitalize(pluralize(name)) %>;
use Mojo::Base 'Mojolicious::Controller';

sub findAll {
  my $self = shift;

  my @entities = $self->db->resultset('<%= _.capitalize(name) %>')->all();

  $self->render(json => [@entities]);
}

sub find {
  my $self  = shift;
  my $id = $self->param('id');

  my $entity = $self->db->resultset('<%= _.capitalize(name) %>')->find($id);
  return $self->render_not_found unless $entity;

  $self->render(json => $entity);
}

sub create {
  my $self  = shift;
  my $json = $self->req->json;

  my $entity = $self->db->resultset('<%= _.capitalize(name) %>')->create(
  {
      <% _.each(attrs, function (attr) { %>
      <%= attr.attrName %> => $json->{'<%= attr.attrName %>'},
      <% }); %>
  });

  $self->res->code(201);
  $self->render(json => $entity);
}

sub update {
  my $self  = shift;
  my $id = $self->param('id');
  my $json = $self->req->json;

  my $entity = $self->db->resultset('<%= _.capitalize(name) %>')->find($id);
  return $self->render_not_found unless $entity;

  $entity->update(
  {
      <% _.each(attrs, function (attr) { %>
      <%= attr.attrName %> => $json->{'<%= attr.attrName %>'},
      <% }); %>
  });

  $self->render(json => $entity);
}

sub delete {
  my $self  = shift;
  my $id = $self->param('id');

  my $entity = $self->db->resultset('<%= _.capitalize(name) %>')->find($id);
  return $self->render_not_found unless $entity;

  $entity->delete;
  $self->rendered(200);
}

1;
