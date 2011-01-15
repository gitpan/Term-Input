# Load the Module::Install bundled in ./inc/
use inc::Module::Install;
    
# Define metadata
name            'Term-Input';
sign;
all_from        'lib/Term/Input.pm';

requires        'Term::ReadKey'             => 0;
requires        'IO::Handle'                => 0;
auto_install;
WriteAll;

package MY; # so that "SUPER" works right
sub MY::distdir {

   my $inherited = shift->SUPER::distdir(@_);

   $inherited =~ s/^(distdir .*)$/$1 distsignature/m;

   $inherited;

}

