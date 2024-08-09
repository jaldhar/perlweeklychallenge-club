#!/usr/bin/perl
use v5.38;

package Position;
use Moo;
use namespace::clean;

has row => (
    is => 'rw',
);

has col => (
    is => 'rw',
);

around BUILDARGS => sub($orig, $class, @args) {
    return { row => $args[0], col => $args[1] };
};

sub str {
    my ($self) = @_;
    return chr(ord('a') + $self->col) . (8 - $self->row);
}

1;

package main;

sub compare($a, $b) {
    return $a->row == $b->row && $a->col == $b->col;
}

sub estimatedCost {
    return 1;
}

sub tryMove($position, $delta) {

    my $dest = Position->new($position->row + $delta->row, $position->col + $delta->col);
    return ($dest->row >= 0 && $dest->row < 8 && $dest->col >= 0 && $dest->col < 8)
        ? $dest
        : undef;
}

sub possibleMoves($position, $target) {

    state @deltas = (
        Position->new(-2, -1),
        Position->new(-2, 1),
        Position->new(-1, 2),
        Position->new(1, 2),
        Position->new(2, 1),
        Position->new(2, -1),
        Position->new(-1, -2),
        Position->new(1, -2)
    );

    my @moves;
    for my $delta (@deltas) {
        my $move = tryMove($position, $delta);
        if (defined $move) {
            push @moves, $move;
        }
    }

    @moves = sort { estimatedCost($a, $target) < estimatedCost($b, $target); } @moves;

    return @moves;
}

sub search($target, $path, $estimate) {
    my $current = $path->[-1];
    my $cost = (scalar @{$path}) + estimatedCost($current, $target);

    if ($cost > $estimate) {
        return $cost;
    }

    if (compare($current, $target)) {
        return '-inf';
    }

    my $min = 'inf';

    for my $move (possibleMoves($current, $target)) {
        if (!grep { $_ if compare($_, $move); } @{$path}) {
            push @{$path}, $move;
            my $t = search($target, $path, $estimate);

            if ($t == '-inf') {
                return '-inf';
            }

            if ($t < $min) {
                $min = $t;
            }

            pop @{$path};
        }
    }

    return $min;
}

sub makePath($current, $target) {
    my @path = ( $current );

    my @stage = ( $current );
    my $estimate = estimatedCost($current, $target);

    while(1) {
        my $t = search($target, \@stage, $estimate);

        if ($t == '-inf') {
            last;
        }

        # Can't solve; this shouldn't happen.
        if ($t == 'inf') {
            last;
        }

        $estimate = $t;
    }

    push @path, splice(@stage, 1);
    @stage = ();
    $current = $target;

    return @path;
}

my ($sc, $sr) = split //, shift;
my ($ec, $er) = split //, shift;

my $start = Position->new(ord('8') - ord($sr), ord($sc) - ord('a'));
my $end = Position->new(ord('8') - ord($er), ord($ec) - ord('a'));

say (scalar makePath($start, $end)) - 1;