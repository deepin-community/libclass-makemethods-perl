#!/usr/local/bin/perl

package X;

BEGIN { unshift @INC, ( $0 =~ /\A(.*?)[\w\.]+\z/ )[0] }
use Test;

use Class::MakeMethods::Emulator::MethodMaker
  static_hash => [ qw / a b / ],
  static_hash => 'c';

sub new { bless {}, shift; }
my $o = new X;
my $o2 = new X;

TEST { 1 };
TEST { ! scalar keys %{$o->a} };
TEST { ! defined $o->a('foo') };
TEST { $o->a('foo', 'baz') };
TEST { $o->a('foo') eq 'baz' };
TEST { $o->a('bar', 'baz2') };
TEST {
  my @l = $o->a([qw / foo bar / ]);
  $l[0] eq 'baz' and $l[1] eq 'baz2'
};

TEST { $o->a(qw / a b c d / ) };
TEST {
  my %h = $o->a;
  my @l = sort keys %h;
  $l[0] eq 'a' and
  $l[1] eq 'bar' and
  $l[2] eq 'c' and
  $l[3] eq 'foo'
};

TEST {
  my @l = sort $o->a_keys;
  $l[0] eq 'a' and
  $l[1] eq 'bar' and
  $l[2] eq 'c' and
  $l[3] eq 'foo'
};

TEST {
  my @l = sort $o->a_values;
  $l[0] eq 'b' and
  $l[1] eq 'baz' and
  $l[2] eq 'baz2' and
  $l[3] eq 'd'
};

TEST { $o->as eq $o->a };

TEST { $o->b_tally(qw / a b c a b a d / ); };
TEST {
  my %h = $o->b;
  $h{'a'} == 3 and
  $h{'b'} == 2 and
  $h{'c'} == 1 and
  $h{'d'} == 1
};

TEST { $o->add_c('foo', 'bar') };
TEST { $o->c('foo') eq 'bar' };
TEST { $o->clear_c('foo') eq 'bar' };
TEST { ! defined $o->c('foo') };
TEST { defined $o->c };

TEST {
  $o->add_cs(qw / a b c d e f /);
  my %h = $o->c;
  $h{'a'} eq 'b' and
  $h{'c'} eq 'd' and
  $h{'e'} eq 'f'
};

TEST {
  $o->clear_cs(qw / a c /);
  my %h = $o->c;
  $h{'e'} eq 'f'
};

TEST { $o->a eq $o2->a };

exit 0;

