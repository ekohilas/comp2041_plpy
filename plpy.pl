#!/usr/bin/perl -w
use strict;

# written by Evangelos Kohilas z5114986 

while (my $line = <>) {
    if ($line =~ /^#!/ && $. == 1) {
        # translate #! line 
        print "#!/usr/local/bin/python3.5 -u\n";

    } elsif ($line =~ /^\s*#/ || $line =~ /^\s*$/) {
        # Blank & comment lines can be passed unchanged
        print $line;

    } elsif ($line =~ /^\s*print\s*"(.*)\\n"[\s;]*$/) {
        # Python's print adds a new-line character by default
        # so we need to delete it from the Perl print statement
        my $match = $1;

        # check if we're only printing 1 variable
        # print it if so 
        if ($match =~ /\$([A-Za-z_]\w*)\s*/){
            print "print($1)\n";
        }
        else{
            # otherwise print string
            print "print(\"$match\")\n";
        }

    } elsif ($line =~ /^\s*print\s*([^;]*)\s*[\s;]*$/) {
        print "print(";
        my @parts = split(",", $1);
        for (my $i=0; $i < scalar @parts; $i++){
            my $part = $parts[$i];
            #replace all variable names
            if ($part =~ s/\$([A-Za-z_]\w*)/$1/g){
                #not the last or second last
                if ($i < scalar @parts - 2){
                    print "$part, ";
                }
                else{
                    print $part;
                }
            }
            elsif ($part =~ /"\"\\n\""/){
                last;
            }
        }
        print ")\n";
        # Convert prints with multiple arguments

    } elsif ($line =~ /^\s*print\s*"(.*)"[\s;]*$/) {
        # Convert statements without newline
        print "print(\"$1\", end='')\n";

    } elsif ($line =~ /^\s*\$([A-Za-z_]\w*)\s*\=\s*([^;]*)[\s;]*$/) {
        # Search for proper scalar variable names and convert
        my $first_var = $1;
        my $rest_of_line = $2;
        $rest_of_line =~ s/\$([A-Za-z_]\w*)/$1/g;
        print "$first_var = $rest_of_line\n";

    } elsif ($line =~ /^\s*$/){
        #keep new lines the same
        print "\n";

    } else {
        # Lines we can't translate are turned into comments
        print "#$line\n";
    }
}
