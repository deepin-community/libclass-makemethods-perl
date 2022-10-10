#!/usr/bin/perl

use Test;
BEGIN { plan tests => 14 }

########################################################################

package MyObject;

use Class::MakeMethods::Autoload 'Standard::Hash:scalar';

sub new { my $package = shift; bless { @_ }, $package }

########################################################################

package MyObject::CornedBeef;
use base 'MyObject';

########################################################################

package main;

ok( 1 );

# Constructor: new()
ok( ref MyObject->can('new') eq 'CODE' );
ok( $obj_1 = MyObject->new() );
ok( ref $obj_1 eq 'MyObject' );

# Method doesn't exist yet
ok( ! $obj_1->can('a') );

# Autogenerated on first use
ok( ! defined $obj_1->a() );
ok( $obj_1->a('Apple') );
ok( $obj_1->a() eq 'Apple' );

# Method now generally visible
ok( ref $obj_1->can('a') eq 'CODE' );

# Another method
ok( ! defined $obj_1->b() );
ok( $obj_1->b('Be') );
ok( $obj_1->b() eq 'Be' );

# Basic subclasses work as expected
ok( $obj_4 = MyObject::CornedBeef->new( a => 'Foo', b => 'Bar', c => 'Baz' ) );
ok( $obj_4->a() eq 'Foo' and $obj_4->b() eq 'Bar' and $obj_4->c() eq 'Baz' );

1;
