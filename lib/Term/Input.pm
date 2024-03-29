package Term::Input;

#    Input.pm
#
#    Copyright (C) 2011
#
#    by Brian M. Kelly. <Brian.Kelly@fullautosoftware.net>
#
#    You may distribute under the terms of the GNU General
#    Public License, as specified in the LICENSE file.
#    (http://www.opensource.org/licenses/gpl-license.php).
#
#    http://www.fullautosoftware.net/

## See user documentation at the end of this file.  Search for =head


$VERSION = '1.04';


use 5.006;

## Module export.
use vars qw(@EXPORT);
@EXPORT = qw(Input);
## Module import.
use Exporter ();
use Config ();
our @ISA = qw(Exporter);

use strict;
use Term::ReadKey;
use IO::Handle;

sub Input {

   my $length_prompt=length $_[0];
   ReadMode('cbreak');
   my $a='';
   my $key='';
   my @char=();
   my $char='';
   my $output=$_[0];
   printf("\r% ${length_prompt}s",$output);
   my $save='';
   while (1) {
      $char=ReadKey(0);
      STDOUT->autoflush(1);
      $a=ord($char);
      push @char, $a;
      if ($a==10 || $a==13) {
         $save=$output;
         while (1) {
            last if (length $output==$length_prompt);
            substr($output,-1)=' ';
            printf("\r% ${length_prompt}s",$output);
            chop $output;
            printf("\r% ${length_prompt}s",$output);
            last if (length $output==$length_prompt);
         }
         $key='ENTER' if $a==10;
         last
      }
      if ($a==127) {
         next if (length $output==$length_prompt);
         substr($output,-1)=' ';
         printf("\r% ${length_prompt}s",$output);
         chop $output;
         printf("\r% ${length_prompt}s",$output);
      } elsif ($a==27) {
         my $flag=0;
         while ($char=ReadKey(-1)) {
            $a=ord($char);
            push @char, $a;
            $flag++;
         }
         unless ($flag) {
            $key='Escape';
            last;
         } elsif ($flag==2) {
            my $e=$#char-2;
            if ($char[$e+1]==79) {
               if ($char[$e+2]==80) {
                  $key='F1';
               } elsif ($char[$e+2]==81) {
                  $key='F2';
               } elsif ($char[$e+2]==82) {
                  $key='F3'; 
               } elsif ($char[$e+2]==83) {
                  $key='F4';
               }
            } elsif ($char[$e+1]==91) {
               if ($char[$e+2]==65) {
                  $key='UPARROW';
               } elsif ($char[$e+2]==66) {
                  $key='DOWNARROW';
               } elsif ($char[$e+2]==67) {
                  $key='RIGHTARROW';
               } elsif ($char[$e+2]==68) {
                  $key='LEFTARROW';
               } elsif ($char[$e+2]==70) {
                  $key='END';
               } elsif ($char[$e+2]==72) {
                  $key='HOME';
               }
               if ($key) {
                  $save=$output;
                  while (1) {
                     last if (length $output==$length_prompt);
                     substr($output,-1)=' ';
                     printf("\r% ${length_prompt}s",$output);
                     last if (length $output==$length_prompt);
                     chop $output;
                     printf("\r% ${length_prompt}s",$output);
                     last if (length $output==$length_prompt);
                  } last
               }
            }
            if ($key) {
               $save=$output;
               while (1) {
                  last if (length $output==$length_prompt);
                  substr($output,-1)=' ';
                  printf("\r% ${length_prompt}s",$output);
                  chop $output;
                  printf("\r% ${length_prompt}s",$output);
                  last if (length $output==$length_prompt);
               } last
            }
         } elsif ($flag==3) {
            my $e=$#char-3;
            if ($char[$e+1]==91) {
               if ($char[$e+2]==49) {
                  if ($char[$e+3]==126) {
                     $key='HOME';
                  }
               } elsif ($char[$e+2]==50) {
                  if ($char[$e+3]==126) {
                     $key='INSERT';
                  }
               } elsif ($char[$e+2]==51) {
                  if ($char[$e+3]==126) {
                     $key='DELETE';
                  }
               } elsif ($char[$e+2]==52) {
                  if ($char[$e+3]==126) {
                     $key='END';
                  }
               } elsif ($char[$e+2]==53) {
                  if ($char[$e+3]==126) {
                     $key='PAGEUP';
                  }
               } elsif ($char[$e+2]==54) {
                  if ($char[$e+3]==126) {
                     $key='PAGEDOWN';
                  }
               }
            }
            if ($key) {
               $save=$output;
               while (1) {
                  last if (length $output==$length_prompt);
                  substr($output,-1)=' ';
                  printf("\r% ${length_prompt}s",$output);
                  last if (length $output==$length_prompt);
                  chop $output;
                  printf("\r% ${length_prompt}s",$output);
                  last if (length $output==$length_prompt);
               } last
            }
         } elsif ($flag==4) {
            my $e=$#char-4;
            if ($char[$e+1]==91) {
               if ($char[$e+2]==49) {
                  if ($char[$e+3]==53) {
                     if ($char[$e+4]==126) {
                        $key='F5';
                     }
                  } elsif ($char[$e+3]==55) {
                     if ($char[$e+4]==126) {
                        $key='F6';
                     }
                  } elsif ($char[$e+3]==56) {
                     if ($char[$e+4]==126) {
                        $key='F7';
                     }
                  } elsif ($char[$e+3]==57) {
                     if ($char[$e+4]==126) {
                        $key='F8';
                     }
                  }
               } elsif ($char[$e+2]==50) {
                  if ($char[$e+3]==48) {
                     if ($char[$e+4]==126) {
                        $key='F9';
                     }
                  } elsif ($char[$e+3]==49) {
                     if ($char[$e+4]==126) {
                        $key='F10';
                     }
                  } elsif ($char[$e+3]==51) {
                     if ($char[$e+4]==126) {
                        $key='F11';
                     }
                  } elsif ($char[$e+3]==52) {
                     if ($char[$e+4]==126) {
                        $key='F12';
                     }
                  } elsif ($char[$e+3]==57) {
                     if ($char[$e+4]==126) {
                        $key='CONTEXT';
                     }
                  } 
               }

            }
            if ($key) {
               $save=$output;
               while (1) {
                  last if (length $output==$length_prompt);
                  substr($output,-1)=' ';
                  printf("\r% ${length_prompt}s",$output);
                  last if (length $output==$length_prompt);
                  chop $output;
                  printf("\r% ${length_prompt}s",$output);
                  last if (length $output==$length_prompt);
               } last
            }
         }
      } else {
         $output.=chr($a);
         printf("\r% ${length_prompt}s",$output);
      }
      last unless defined $char;
   }
   substr($save,0,$length_prompt)='';
   STDOUT->autoflush(0);
   ReadMode('normal');

   return $save,$key;

}
1;

__END__;


######################## User Documentation ##########################


## To format the following documentation into a more readable format,
## use one of these programs: perldoc; pod2man; pod2html; pod2text.
## For example, to nicely format this documentation for printing, you
## may use pod2man and groff to convert to postscript:
##   pod2man Term/Menus.pm | groff -man -Tps > Term::Menus.ps

=head1 NAME

Term::Input - A simple drop-in replacement for <STDIN> in scripts
              with the additional ability to capture and return
              the non-standard keys like 'End', 'F3', 'Insert', etc.

=head1 SYNOPSIS

   use Term::Input;

   my $prompt='PROMPT : ';
   my ($input,$key)=('','');
   ($input,$key)=Input($prompt);

   print "\nInput=$input" if $input;
   print "\nKey=$key\n" if $key;

   print "Captured F1\n" if $key eq 'F1';
   print "Captured ESCAPE\n" if $key eq 'ESCAPE';
   print "Captured DELETE\n" if $key eq 'DELETE';
   print "Captured PAGEDOWN\n" if $key eq 'PAGEDOWN';   

=head1 DESCRIPTION

I needed a ridiculously simple function that behaved exactly like $input=<STDIN> in scripts, that captured user input and and populated a variable with a resulting string. BUT - I also wanted to use other KEYS like F1 and DELETE and the RIGHT ARROW and have them captured and returned. So I really wanted this:

my $prompt='PROMPT : ';
($input,$key)=input($prompt);

... where I could test the variable '$key' for the key that was used to terminate the input. That way I could use the arrow keys to scroll a menu for instance.

I looked through the CPAN, and could not find something this simple and straight-forward. So I wrote it. Enjoy.

NOTE: Backspace is not captured - but used to backspace. DELETE is captured. Also, no Control combinations are captured - just
 the non-standard keys F1-F12, INSERT, DELETE, ENTER, ESCAPE, HOME, PGDOWN, PGUP, END and the ARROW KEYS. All captured keys li
sted will terminate user input and return the results - just like you would expect using ENTER with <STDIN>.

=head1 AUTHOR

Brian M. Kelly <Brian.Kelly@fullautosoftware.net>

=head1 COPYRIGHT

Copyright (C) 2011
by Brian M. Kelly.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License.
(http://www.opensource.org/licenses/gpl-license.php).

