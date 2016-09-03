#!/usr/bin/perl -w

sub my_join {
    my ($separator, @list) = @_;
    return "" if !@list;
    my $string = shift @list;
    foreach $thing (@list) {
        $string .= $separator . $thing;
    }
    return $string;
}

@a = ("Fish Fingers", "and", "Custard");
$b = my_join("   ",  @a);
print "$b\n"
