use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  VERSION   => '0.01',
  PREREQ_PM => {
    'Mojolicious'              => '4.71',
    'Modern::Perl'             => 0,
    'DBIx::Class'              => 0,
    'DBIx::Class::Migration'   => 0,
    'DateTime'                 => 0,
    'DateTime::Format::SQLite' => 0
  },
  test => {TESTS => 't/*.t'}
);
