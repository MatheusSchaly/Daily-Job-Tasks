package TestFunctions;

use strict;
use warnings;
use Test2::V0;


# Test for true or false
sub test_ok {
    my ($got, $test_name) = @_;
    ok($got, $test_name);
    ok(!$got, $test_name);
}

# Compare 2 scalar values
sub test_is {
    my ($got, $want, $test_name) = @_;
    is($got, $want, $test_name);
    isnt($got, $want, $test_name);
}

# Match against a regex
sub test_like {
    my ($got, $want, $test_name) = @_;
    like($got, qr/$want/, $test_name);
    unlike($got, qr/$want/, $test_name);
}

# Rare, but used for complex logic: 
# eg, if I get to this place, pass()
sub test_pass_fail {
    pass("this test will always pass");
    fail("this test will always fail"); 
}

# Used to make sure you meant to stop testing here and
# didn't exit/return/die and skip the rest of your tests.
sub test_done {
    done_testing();
}

1;  # End of package
