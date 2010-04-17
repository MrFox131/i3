#!perl
# vim:ts=4:sw=4:expandtab

use i3test tests => 3;
use X11::XCB qw(:all);
use Time::HiRes qw(sleep);

BEGIN {
    use_ok('X11::XCB::Connection') or BAIL_OUT('Cannot load X11::XCB::Connection');
}

my $x = X11::XCB::Connection->new;

my $i3 = i3;

#####################################################################
# Ensure IPC works by switching workspaces
#####################################################################

# Switch to the first workspace to get a clean testing environment
$i3->command('1')->recv;

# Create a window so we can get a focus different from NULL
my $window = i3test::open_standard_window($x);
diag("window->id = " . $window->id);

sleep(0.25);

my $focus = $x->input_focus;
diag("old focus = $focus");

# Switch to the nineth workspace
$i3->command('9')->recv;

my $new_focus = $x->input_focus;
isnt($focus, $new_focus, "Focus changed");

diag( "Testing i3, Perl $], $^X" );
