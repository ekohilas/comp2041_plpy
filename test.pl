my $string = "In \$course there are %d %s with the first name \$first_name\n, \$cfn{\$course}{\$first_name}, \$hi";

my @list;
my ($string, @args) = split(', ', $string);

my @matches = $string =~ /(?<!\\)(?:\\\\)*\K\$\w+|%[csduoxefgXEGi]/g;
foreach my $match (@matches){
    print "$match\n";
    if ($match =~ /\$\w+/){
        $string =~ s/(?<!\\)(?:\\\\)*\K\$\w+/%s/;
        push(@list, $&);
    }
    elsif ($match =~ /%[csduoxefgXEGi]/){
        push(@list, shift(@args));
    }
}
print "$string % (", join(', ', @list), ")\n";
    

#print " ""In \%s there are \%d people with the first name \%s"" % (course, n, first_name))\n";
