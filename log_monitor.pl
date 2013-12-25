#!/usr/bin/perl
use strict;
use warnings;

use File::Monitor;
use File::Slurp;
use Term::ANSIScreen qw/:cursor :screen :color :constants/;
use Time::HiRes qw/usleep/;

die('Please specify the file name') unless (scalar(@ARGV) > 0);
die('File not found') unless (-e $ARGV[0]);

my $monitor = File::Monitor->new();
my $line_cnt = 0;
my $last_cnt = 0;
my $last_last_cnt = 0;

# savepos();
$monitor->watch($ARGV[0], sub {
            my ($file_name, $event, $change) = @_;
            usleep(4e5);
            my @lines = read_file( $file_name ) ;
            # loadpos();
            # cldown();
            cls();

            map {
                my ($time, $content) = $_ =~ /(\d+-\d+-\d+T\d+:\d+:\d+)(.*)$/;
                $content =~ s/\\n/\n/g;
                print RED $time;
                print BLUE $content;
                print "\n";
            } @lines[0 .. ($line_cnt-1)];

            map {
                my ($time, $content) = $_ =~ /(\d+-\d+-\d+T\d+:\d+:\d+)(.*)$/;
                $content =~ s/\\n/\n/g;
                print RED $time;
                print GREEN $content . "\n\n";
            } @lines[$line_cnt .. (scalar(@lines) - 1)];
            $line_cnt = scalar(@lines);

            print CLEAR "\n";
        });

while (1) {
    $monitor->scan;
    usleep(1e5);
}
