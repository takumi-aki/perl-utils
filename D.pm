package D;

use strict;
use warnings;

use base 'Exporter';

use Data::Dumper 'Dumper';

our @EXPORT = ('d', 'web');

sub d {
    my $data = shift;
    my $dump = Dumper $data;
    print STDERR $dump;
}

sub web {
    my $data = shift;
    my $dump = Dumper $data;
    print "Content-type: text/html\n\n" . $dump; exit(1);
}

1;

