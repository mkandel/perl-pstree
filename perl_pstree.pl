#!/usr/local/bin/perl -w
# $Id:$
# $HeadURL:$
use strict;
use warnings;

use Carp;
use Getopt::Long;
Getopt::Long::Configure qw/bundling no_ignore_case/;
use Data::Dumper;
# Some Data::Dumper settings:
local $Data::Dumper::Useqq  = 1;
local $Data::Dumper::Indent = 3;

use lib '.';
use Process;

local $| = 1;

my $debug = 0;

GetOptions(
    "debug|d"        => \$debug,
);

my $prog = $0;
$prog =~ s/^.*\///;

my $command = '/bin/ps -ef';

open my $IN, "$command |" || die "Error opening pipe for '$command': $!\n";
my @lines = <$IN>;
close $IN || die "Error closing pipe: $!\n";

## Start the data structure:
my $procs = Process->new( { pid => 0, name => '' } );

## Fill in the structure from the lines we read:
my $count = 0;
while ( @lines ){
    $count++;
    @lines = process_lines( \@lines, $procs );
}
print "Went through process_lines '$count' times\n" if $debug;

## Make the magic happen:
$procs->print_all();

sub process_lines {
    my $lines  = shift;
    my $struct = shift;

    my @orphans;

    LINE:
    foreach my $line ( @{ $lines } ){
        ## Ignore header line:
        next LINE if $line =~ /^UID/;
        my $command = $line;
        $command =~ s/^(.*\s+\d+:\d+:\d+\s)(.*)/$2/;
        my ( undef, $pid, $ppid, undef ) = split /\s+/, $line;
        chomp $command;

        ## pstree ignores lines like below, I will too:
        ## root         2     0  0 Jun30 ?        00:00:00 [kthreadd]
        next LINE if ( $command =~ /^\[/ );
        ## Ignore PPID 0:
        #next LINE if ( $ppid == 0 );

        my $proc = Process->new( { pid => $pid, name => $command } );

        my $sub_struct;
        if( $sub_struct = $struct->get_pid( $ppid ) ){
            $sub_struct->add_kid( $proc );
        } else { ## No Process for parent, store this for later
            push @orphans, $line;
        }
    }

    return @orphans;
}


__END__
