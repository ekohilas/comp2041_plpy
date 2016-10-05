while (<>){
    if ($_ =~ /\/(.*)\//){
        print $1;
        $string  = eval $1;
        print "'$string'";
    }
}
