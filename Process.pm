package Process;

use strict;
use warnings;

local $| = 1; ## Unbuffered output

use Data::Dumper;

my %cheat;

sub new {
    my $class = shift;
    my $args = shift;
    #print Dumper \$args;
    my $self;

    $self->{ 'kids' } = [];
    $self->{ 'pid'  } = $args->{ 'pid'  } || 0;
    $self->{ 'name' } = $args->{ 'name' } || '';

    bless $self, $class;
    $cheat{ $self->{ 'pid' } } = $self;
    #print Dumper \%cheat;

    return $self;
}

sub add_kid {
    my $self = shift;
    my $child = shift;

    push $self->{ 'kids' }, $child;
}

sub name {
    my $self = shift;

    return $self->{ 'name' };
}

sub pid {
    my $self = shift;

    return $self->{ 'pid' };
}

sub kids {
    my $self = shift;

    return @{ $self->{ 'kids' } };
}

sub has_kids {
    my $self = shift;

    return scalar @{ $self->{ 'kids' } };
}

sub print_proc {
    my $self = shift;
    my $indent = shift || 0;

    print ' ' x $indent;

    my $sigil = ' ';
    if ( $self->has_kids() ){
        $sigil = '`';
    }
    print "$sigil-";
    print $self->pid(), ': ', $self->name(), "\n";
}

sub print_all {
    my $self = shift;
    my $indent = shift || 0;

    $self->print_proc( $indent );

    if ( $self->has_kids() ){
        foreach my $kid ( sort { $a->pid() <=> $b->pid() } $self->kids() ){
            $kid->print_all( $indent + 1 );
        }
    }
}

sub get_pid {
    my $self = shift;
    my $pid = shift;

    return $cheat{ $pid };
}

1;
