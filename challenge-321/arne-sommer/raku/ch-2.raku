#! /usr/bin/env raku

unit sub MAIN ($str1 is copy,
               $str2 is copy,
               :v(:$verbose));

$str1 ~~ s/.\#// while $str1 ~~ /.\#/;
$str2 ~~ s/.\#// while $str2 ~~ /.\#/;

$str1 = "" if $str1 eq "#";
$str2 = "" if $str2 eq "#";

say ": Str1:$str1\n: Str2:$str2" if $verbose;

say ($str1 eq $str2);

