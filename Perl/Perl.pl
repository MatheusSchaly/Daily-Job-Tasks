#!/usr/bin/env perl


### Setting up Perl
## Installing Perl
# $ brew update   Updates the Homebrew package manager
# $ brew install plenv   Installs Perl environment manager (plenv) via Homebrew
# $ brew install perl-build   Installs plenv plugin to build and install different Perl versions
# Add eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" to .bashrc   Adds environment variables to .bashrc file

## Dealing with dependencies
# $ plenv install --list   Lists all available Perl versions to install
# $ plenv versions   Lists all Perl versions installed using plenv
# $ plenv install A_PERL_VERSION   Installs a specific Perl version
# $ plenv global A_PERL_VERSION   Sets a specific Perl version as the global default
# $ plenv local A_PERL_VERSION   Sets a specific Perl version as the local default for the current directory
# $ plenv install-cpanm:   Installs the cpanm tool for managing Perl modules
# $ cpanm Carton:   Installs Carton module for managing dependencies
# $ plenv rehash:   Rehashes the PATH environment variable to include newly installed Perl executables
# $ touch cpanfile:   Creates an empty cpanfile for specifying module dependencies
# requires 'Text::CSV':   Adds Text::CSV module as a dependency in the cpanfile
# $ carton install:   Installs modules specified in cpanfile and create a snapshot of the dependencies


### Imports
use strict;   # Makes it an error to use certain expressions.
use warnings;   # Enables additional warnings for certain expressions.
# use lib '/home/schaly/git/Daily-Job-Tasks/Perl/my_libs';
use Path::Tiny;   # File handler
use FindBin;
use lib "$FindBin::Bin/my_libs";
use StringUtils;   # Custom library
use StringUtilsWithExport ("zombify");
# use Syntax::Keyword::Try;
use TestFunctions;


### Variables

## Scalars
# Is a number, a string or a reference
my $my_scalar = "My Scalar Value";
print $my_scalar, "\n"; # "My Scalar Value"

## Arrays
# An ordered set of scalar values
my @my_array = (1, 2, "My String");
print $my_array[0], "\n"; # "1"

## Hashes
# An unordered collection of key/value pairs
my %my_hash = (a => 1, "b" => 2, 'c' => 'batman\n', "d" => "batman\n");
print $my_hash{c}, "\n"; # "batman\n"


### References
# It's a scalar value containing the address of another value.

## Array references
my $my_scalar = "My Scalar Value";
my $my_array_ref_1 = \@my_array;
my $my_array_ref_2 = [1, 2, "My String"];

# Dereference and access array elements
print $my_array_ref_1->[0], "\n"; # "1"
print $my_array_ref_2->[0], "\n"; # "1"

# Nested array references
my $my_nested_array = [1, 2, ["a", "b"]];

# Dereference array references
my @my_dereference_array_1 = @{ $my_nested_array }; # (1, 2, ["a", "b"])
my @my_dereference_array_2 = @$my_nested_array; # (1, 2, ["a", "b"])
my @my_dereference_array_3 = @{ $my_nested_array->[2] }; # ("a", "b")

## Hash references
my %my_hash = (a => 1, b => 2);
my $my_hash_ref_1 = \%my_hash;
my $my_hash_ref_2 = {x => 11, y => 12};

# Dereference and access hash elements
print $my_hash_ref_1->{a}, "\n"; # 1
print $my_hash_ref_2->{x}, "\n"; # 11

# Nested hash references
my $my_nested_hash = {
    a => 1,
    b => { x => 1, y => 2 },
};

# Dereference hash references
my %my_dereference_hash_1 = %{ $my_nested_hash }; # (a => 1, b => { x => 1, y => 2})
my %my_dereference_hash_2 = %$my_nested_hash; # (a => 1, b => { x => 1, y => 2})
my %my_dereference_hash_3 = %{ $my_nested_hash->{b} }; # (x => 1, y => 2)

## Code references
# AKA code refs, anonymous subroutines, anonymous functions, closures, or callbacks
my $code_ref = sub { print "Potato\n"};

# Dereference and run the subroutine
$code_ref->(); # "Potato"

## Complex data structure
my %my_hash = (
	a => 1,
	b => [
		{
			c => 3,
			d => 4,
		},
		{
			e => 5,
			f => 6,
		},
	],
);
print $my_hash{b}->[1]->{f}, "\n";


### Functions
## Passing parameters
# Not named parameters
sub rawr {
    my ($dinosaur, $how) = @_;
    print "$dinosaur says RAWR $how\n";
}
rawr("Stegasaurus", "loudly");

# Named parameters
sub rawr {
    my (%params) = @_;
    print "$params{dinosaur} says RAWR $params{how}\n";
}
rawr(
    dinosaur => "Stegasaurus", 
    how      => "loudly"
);

## Returning values
# Returning single value
sub get_cookie_flavor {
    return "chocolate chip";
}
my $flavor = get_cookie_flavor();

# Returning multiple values
sub get_available_flavors {
    return ("chocolate chip", "oatmeal raisin", "peanut butter");
}
my @flavors = get_available_flavors();


### Conditionals
## If statements
# Comparing numbers
my $eyeballs = 2;
if ($eyeballs >= 2) {
    print "its an alien\n";
}
elsif ($eyeballs == 2) {
    print "its human\n";
}
else {
    print "its a rock\n";
}

# Comparing strings
my $location = "rodeo";
if ($location eq 'rodeo') {
    print "yipikiyiyay\n";
}
elsif ($location ne 'bedroom') {
    print "yawn\n";
}
else {
    print "I am in the bedroom\n";
}

# Postfix conditionals
my $your_name = "Barry";
print "hello\n" if $your_name eq 'Barry';
print "hello\n" unless $your_name eq 'Barry';

# Ternary operator
my $chicken_count = 1;
my $my_phrase = $chicken_count == 1 ? "1 chicken" : $chicken_count . " chickens";
print $my_phrase, "\n";


### Loops
## foreach
# Iterating over an array
my @my_array = (1, 2, "Potato");
foreach my $i (@my_array) {
    print $i;
}
# "12Potato"

# Iterating over a hash
my %my_hash = (a => 1, b => 2);
foreach my $i (keys %my_hash) {
    print $my_hash{$i};
}
# "12" or "21"

## while
my $i = 0;
while ($i < 4) {
    print $i;
    $i++;
}
# "0123"

## Postfix loops
# Postfix notation exists for foreach, for, while, and until loops
print $_ foreach ('a', 'b'); # "ab"
print $_ for ('a', 'b'); # "ab"

## Last
# Exit the loop immediately. This works with any kind of loop.
my @my_array = (1, 2, "Potato");
foreach my $i (@my_array) {
    print $i;
    last if $i > 1; # break out of the loop early
}
# "12"

## Next
# Start the next iteration of the loop immediately. This also works with any kind of loop.
my @my_array = (1, 2, 3);
foreach my $i (@my_array) {
    next if $i > 2; # don't print anything for $i > 2
    print $i;
}
# "12"

### Regular expressions
## m// (the match operator)
my $my_string = "Hi Cowboys";
print "hello\n" if $my_string =~ m/cowboys/;  
print "hello\n" if $my_string =~  /cowboys/;  # same but shorter
print "hello\n" if $my_string =~  /cowboys/i; # "hello", same but case insensitive
my $my_string = "https://google.com";
print "hello\n" if $my_string =~ m|https://|; # "hello"
print "hello\n" if $my_string =~ m{https://}; # "hello"
print "hello\n" if $my_string =~ m'https://'; # "hello"
print "hello\n" if $my_string =~ qq{https://}; # "hello"

## s/// (the substitution operator)
my $my_string = "cowboys cowboys and aliens\n";
$my_string =~ s/cowboys/martians/;
print $my_string; 
# "martians cowboys and aliens"

my $my_string = "cowboys cowboys and aliens\n";
$my_string =~ s/cowboys/martians/g;
print $my_string; 
# "martians martians and aliens"

## qr// (re-using regexps)
my $xls_regexp = qr/\.xls$/i;
my @files_names = ("doc1.xls", "doc2.txt", "doc3.xlsx", "doc4.XLS");

for my $file_name ( @files_names ) {
    print $file_name, "\n" if $file_name =~ $xls_regexp;
} # doc1.xls doc4.XLS

## Commenting regular expressions
my $code =~ s|/\*.*?\*/||gs;
# Delete C comments
my $code =~ s|
    /\*     # Match the opening delimiter
    .*?     # Match a minimal number of characters
    \*/     # Match the closing delimiter
||gsx;


### Files
## Creating Path::Tiny objects
my $dir = path("folder_0");
my $file = path("folder_0/file_0.txt");

## Navigating the filesystem
my $subdir = $dir->child("folder_1");
my $file = $subdir->child("file_2.txt");

for my $file ($dir->children) {
    print $file, "\n";
} # folder_0/file_0.txt folder_0/file_1.txt folder_0/folder_1

my $iter = $dir->iterator;
while (my $file = $iter->()) {
    print $file, "\n";
} # folder_0/file_0.txt folder_0/file_1.txt folder_0/folder_1

## Reading files using Path::Tiny
my $file_read = path("folder_0/file_0.txt");

# Read the entire file into a scalar
my $contents = $file_read->slurp; 
print $contents, "\n"; # File 0 Line 1 File 0 Line 2 File 0 Line 3

# Each line of the file is an item in the array
my @lines = $file_read->lines; 
foreach my $line (@lines) {
    print $line;
} # File 0 Line 1 File 0 Line 2 File 0 Line 3

my ($head) = $file_read->lines( {count => 1} );
print "\n", $head; # Line 1 of file_0
my ($tail) = $file_read->lines( {count => -1} );
print $tail, "\n"; # Line 3 of file_0

## Writing files using Path::Tiny
my $data = "File 1 Line 1\nFile 1 Line 2\nFile 1 Line 3";
my $file_write = path("folder_0/file_1.txt");
# $file_write->spew($data);
undef $file_write;

## Reading files
# < for reading; > for writing; >> for appending
my $f_name_read = "folder_0/file_2.txt";
# Opens the config file for reading
open my $f, '<', $f_name_read or die "Could not open $f_name_read: $!";

# Read the entire file into a scalar
my $contents = do { local $/; <$f> };
print $contents, "\n"; # File 2 Line 1 File 2 Line 2 File 2 Line 3

# Each line of the file is an item in the array
open my $f, '<', $f_name_read or die "Could not open $f_name_read: $!";
my @lines = ();
while (my $line = <$f>) {
    push @lines, $line;
    print $line;
} # File 2 Line 1 File 2 Line 2 File 2 Line 3
print "\n";

open my $f, '<', $f_name_read or die "Could not open $f_name_read: $!";
while(!eof $f) {
	my $line = readline $f;
	last unless defined $line;
	print $line;
} # File 2 Line 1 File 2 Line 2 File 2 Line 3
print "\n";

# Closes the file
close($f);

## Writing files
my $f_name_write = "folder_0/file_3.txt";
# Opens the output file for writing
open my $f, '>', $f_name_write or die "Couldn't open $f_name_write for writing because: ".$!;
my $data = "File 3 Line 1\nFile 3 Line 2\nFile 3 Line 3";
print $f $data;

# Closes the file
close($f);


### Loading libraries and $PERL5LIB
# When you run a Perl program it looks for libraries (aka modules/packages/classes/dependencies) in the
# paths specified in environment or system variable $PERL5LIB before looking in the standard library.

# To print the standard libraries path
# In PowerShell: perl -e "print join qq(\n), @INC"

# To check the PERL5LIB system variable do it manually in Windows

# To add a path to the PERL5LIB system variable
# In PowerShell with adm privilages: SETX /M PERL5LIB "my_path"

# To import a library
# If your library path is set as a system variable, just do
# use my_file;

# Otherwise do either
# use FindBin;
# use lib $FindBin::Bin;
# use my_file;
# Or
# use lib 'aboslute_path_to_lib'
# use my_file;

# To create a file use
# Set your package name to the same name as your .pm file
# package name_of_your_package;
# return 1

# Then you can call the function as in
print StringUtils::zombify("i want brains"), "\n"; # "r wrnt brrrns"

# To shorten the call you have to, in your .pm file
# use Exporter ("import");
# our @EXPORT_OK = ("func_to_import");
# Then in your .pl file
# use my_file ("func_to_import");
print zombify("i want brains"), "\n"; # "r wrnt brrrns"


### Installing libraries with cpanm
## How to install cpanm
# curl -L https://cpanmin.us | perl - --sudo App::cpanminus

## Basic usage
# cpanm --help # Get help
# cpanm URI # install the URI module from CPAN

## Installing to a locallib
# cpanm --local-lib <path> <module>[@version]
# cpanm --local-lib local URI # install to ./local
# cpanm -l local URI  # same but less typing

## To use a dependency installed to a locallib
# $ export PERL5LIB=./lib:./local/lib/perl5:$PERL5LIB
# $ echo $PERL5LIB
# ./lib:./local/lib/perl5:/opt/perlbrew/libs/perl-5.26.1@mylib/lib/perl5


### Managing project dependencies with Carton
# https://metacpan.org/pod/Carton#TUTORIAL
# https://metacpan.org/dist/Module-CPANfile/view/lib/cpanfile.pod


### What version? Where?
## First, install pmtools
# cpanm pmtools

## What version of that module is installed?
# pmvers module_name

## Where is that module installed?
# pmpath module_name


### Handling exceptions with die/eval
## Throwing exceptions
# die "Something bad happened";
# That prints "Something bad happened at my_file_name line 123." 
# and then the process exits;

## Catching exceptions
# The exception is placed in the global variable $@.
# eval { die "Something bad happened" }; # try (and catch)
# warn $@ if $@; # handle exception

## Pitfalls
# As $@ is a global variable, store it in another variable
# eval { die "something bad" };
# if ($@) {
#    my $error = $@;
#    disconnect_from_the_database(); # calls eval()
#    warn $error;
# }

# Exception objects that evaluate as false
# unless ( eval { try_something_risky(); return 1 } ) {
#     handle_exception();
# }


### Handling exceptions with try/catch
## Catching exceptions with Syntax::Keyword::Try
# try {
#     die "its only a flesh wound";
# }
# catch {
#     warn "something bad happened: $@";
# }

## Pitfalls
# A try block must be followed by catch or finally or both.
# A try block does not catch exceptions. The catch block catches exceptions.
# A return statement will exit the containing function -- not the try block.
# Loop control statements like redo, next, and last act on any containing loops.


### Testing
TestFunctions::test_ok(1, 'test ok');
TestFunctions::test_is('foo', 'foo', 'test is');
TestFunctions::test_like('bar', qr/ba/, 'test like');
TestFunctions::test_pass_fail();
TestFunctions::test_done();
