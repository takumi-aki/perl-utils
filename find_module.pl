#!/usr/bin/env perl

use strict;
use warnings;

use File::Find 'find';
use lib "$ENV{HOME}/perl5/lib/perl5";

my $list_dir = "$ENV{HOME}/.vim/dict/";
my $list_file = "perl_module_name.dict";

unless (-e $list_dir) {
    mkdir $list_dir
        or die "Couldn`t create directory $list_dir ($!)\n";
}

open my $fh, '>', "$list_dir$list_file"
    or die "Couldn`t create file $list_file ($!)\n";

my %already_seen;

for my $incl_dir (@INC) {
    find {
        wanted => sub {
            my $file = $_;
            
            return unless $file =~ /\.pm\z/;

            $file =~ s{^Q$incl_dir/\E}{ };
            $file =~ s{/}{::}g;
            $file =~ s{\.pm\z}{};
            $file =~ s{^.*\b[a-z_0-9]+::}{ };
            $file =~ s{^\d+\.\d+\.\d+::(?:[a-z_][a-z_0-9]*::)?}{};
            return if $file =~ m{^::};

            print {$fh} $file, "\n" unless $already_seen{$file}++;
        },
        no_chdir => 1,
    }, $incl_dir;
}
