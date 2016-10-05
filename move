#!/usr/bin/perl

#use warnings;

sub parse_args {
	# sets boundaries on the screen, and any user-supplied options
	$xdelta = $ARGV[0];
	$ydelta = $ARGV[1];
	if ( !defined $xdelta){print "fatal: not enough arguments.";exit 1};
	if ( !defined $ARGV[3] ) {
	# sets the default if there are no extra options
		chomp($focus = `pfw`);
		
		chomp($xinit = `wattr x $focus`);
		chomp($yinit = `wattr y $focus`);
		
		chomp($xwidth = `wattr w $focus`);
		chomp($ylength = `wattr h $focus`);

		chomp($border = `wattr b $focus`);

	} else {
	# parses extra options
	# blank because no support for them yet (TODO)
	}
}

$xmax = `wattr w \$(lsw -r)`;
$ymax = `wattr h \$(lsw -r)`;

$xmin = 0;
$ymin = 0;

print "$xdelta $ydelta $xwidth $ylength $focus\n";

$xnew = $xinit + $xdelta;

if ( $xnew + $xwidth > $xmax ) { $xnew = $xmax - $xwidth - 2 * $border};
if ( $xnew < $xmin ) { $xnew = $xmin };

$ynew = $yinit + $ydelta;

if ( $ynew + $ylength > $ymax ) { $ynew = $ymax - $ylength + 2 * $border};
if ( $ynew < $ymin ) { $ynew = $ymin };

print "$xnew $ynew $xwidth $ylength $focus\n";
`wtp $xnew $ynew $xwidth $ylength $focus`;
