#!/bin/env raku

unit sub MAIN(*@N);

my @left  = 0, |([\+] @N.head(*-1));
my @right = (0, |([\+] @N.reverse.head(*-1))).reverse;

put (@left «-» @right)».abs.join(', ');
