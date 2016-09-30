#!/usr/bin/perl -w
use strict;

# written by Evangelos Kohilas z5114986 

#loop until end of program
while (my $line = <>) {

    # translate the #! line 
    if ($line =~ /^#!/ && $. == 1) {
        print "#!/usr/local/bin/python3.5 -u\n";

    # leave blank lines and comments the same
    } elsif ($line =~ /^\s*#/ || $line =~ /^\s*$/) {
        print $line;

    # convert print single item print statements 
    } elsif ($line =~ /^\s*print\s*"(.*)\\n"[\s;]*$/) {
        my $match = $1;

        # Check if we are only printing one variable
        # and convert it if so
        if ($match =~ /\$([A-Za-z_]\w*)\s*/){
            print "print($1)\n";
        }
        # otherwise print the entire string itself
        else{
            print "print(\"$match\")\n";
        }

    # convert print statements with multiple arguments
    } elsif ($line =~ /^\s*print\s*([^;]*)\s*[\s;]*$/) {
        #print the first part of the print statement
        print "print(";
        my @parts = split(",", $1);

        #iterate through all the agruments
        for (my $i=0; $i < scalar @parts; $i++){
            my $part = $parts[$i];

            #replace all variable names
            if ($part =~ s/\$([A-Za-z_]\w*)/$1/g){
                # if its not the last or second last
                # then print with a comma
                if ($i < scalar @parts - 2){
                    print "$part, ";
                }
                else{
                    print $part;
                }
            }
            # if we find a new line and its the last argument
            # ignore it
            elsif ($part =~ /"\"\\n\""/ && $i = scalar @parts - 1){
                next;
            }
            #else print the string or other
            else { 
                # add a comma if not the last or second last
                if ($i < scalar @parts - 2){
                    print "$part, ";
                }
                else{
                    print $part;
                }
            }
        }
        print ")\n";

    # convert any statments that are strings and don't have a new line
    } elsif ($line =~ /^\s*print\s*"(.*)"[\s;]*$/) {
        print "print(\"$1\", end='')\n";

    # convert variable declarations
    } elsif ($line =~ /^\s*\$([A-Za-z_]\w*)\s*\=\s*([^;]*)[\s;]*$/) {
        my $first_var = $1;
        my $rest_of_line = $2;
        $rest_of_line =~ s/\$([A-Za-z_]\w*)/$1/g;
        print "$first_var = $rest_of_line\n";

    # anything we can't translate becomes a comment
    } else {
        print "#$line\n";
    }
}
