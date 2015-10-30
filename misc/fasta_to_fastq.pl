#!/rsgrps/bhurwitz/hurwitzlab/bin/perl

use common::sense;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Readonly;

main();

# --------------------------------------------------
sub main {
    my %args = get_args();

    if ($args{'help'} || $args{'man'}) {
        pod2usage({
            -exitval => 0,
            -verbose => $args{'man'} ? 2 : 1
        });
    }; 

    pod2usage(1);
}

# --------------------------------------------------
sub get_args {
    my %args;
    my $file;
    my $outfile;
    GetOptions(
        \%args,
        'f|file=s'      =>  \$file,
        'o|outfile=s'   =>  \$outfile,
        'help',
        'man',
    ) or pod2usage(2);

    return %args;
}

__END__

# --------------------------------------------------

=pod

=head1 NAME

fastaToFastq.pl - a script to add fake quality scores to fasta and make it a fastq

=head1 SYNOPSIS

  fastaToFastq.pl 

Options:

  -f|--file     fasta file that will be converted
  -o|--outfile  fastq file that will be written
  --help        Show brief help and exit
  --man         Show full documentation

=head1 DESCRIPTION

Wants a fasta file for input, spits out a fastq

=head1 SEE ALSO

perl.

=head1 AUTHOR

Scott Daniel E<lt>scottdaniel@email.arizona.eduE<gt>.

=head1 COPYRIGHT

Copyright (c) 2015 Hurwitz Lab

This module is free software; you can redistribute it and/or
modify it under the terms of the GPL (either version 1, or at
your option, any later version) or the Artistic License 2.0.
Refer to LICENSE for the full license text and to DISCLAIMER for
additional warranty disclaimers.

=cut
#Copyright (c) 2010 LUQMAN HAKIM BIN ABDUL HADI (csilhah@nus.edu.sg)
#
#Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files 
#(the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, 
#merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is 
#furnished to do so, subject to the following conditions:

#The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
#OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
#LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR 
#IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#!/usr/bin/perl
use strict;

my $file = $ARGV[0];
open FILE, $file;

my ($header, $sequence, $sequence_length, $sequence_quality);
while(<FILE>) {
        chomp $_;
        if ($_ =~ /^>(.+)/) {
                if($header ne "") {
                        print "\@".$header."\n";
                        print $sequence."\n";
                        print "+"."\n";
                        print $sequence_quality."\n";
                }
                $header = $1;
		$sequence = "";
		$sequence_length = "";
		$sequence_quality = "";
        }
	else { 
		$sequence .= $_;
		$sequence_length = length($_); 
        #Adding quality score of 30 (ascii '?' - 33) prob. of .001 error
		for(my $i=0; $i<$sequence_length; $i++) {$sequence_quality .= "?"} 
	}
}
close FILE;
print "\@".$header."\n";
print $sequence."\n";
print "+"."\n";
print $sequence_quality."\n";

