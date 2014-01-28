package <%= _.capitalize(baseName) %>::Home;
use Mojo::Base 'Mojolicious::Controller';

sub index {
  my $self = shift;

  return $self->redirect_to('index.html');
}

1;
