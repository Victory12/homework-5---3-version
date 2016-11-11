package Local::Row::JSONParser;
use strict;
use warnings;
use base qw(Exporter);
our @EXPORT_OK = qw( parse_json );
our @EXPORT = qw( parse_json );
use DDP;
my $reg= qr{
  (?&VALUE) (?{$_ = $^R->[1]; })     
  (?(DEFINE)                         
    (?<VALUE>
      \s*
      (
          (?&STRING)
        |
          (?&NUMBER)
        |
          (?&OBJECT)
        |
          (?&ARRAY)
        |
          true  (?{ [$^R, 1] })
        |
          false (?{ [$^R, 0] })
        |
          null  (?{ [$^R, undef] })
      )
      \s*
    )
    (?<STRING>                      
      \s*                           
      "(                            
        (?:                         
            (?:\\ ["] )* (?:[^"])*                               
        )*                          
      )"                            
      \s*                           
      #(?{ [$^R, eval $^N] })
       (?{  my $ref = $^R;          
            my $str = $^N;
            $str =~ s/(\\["bfnrt])/$1 eq "\\t" ? "\t" : $1 eq "\\n"  ? "\n":$1 eq "\\b"  ? "\b":$1 eq "\\f"  ? "\f":$1 eq "\\r"  ? "\r":$1 eq "\\\""  ? "\"":""/eg;
            $ref = [$ref,$str];
            return $ref;
        }) 
    )
    (?<NUMBER>
      \s*
      ( 
        (?: -?(?=0\.\d+)0 | -? [1-9]\d* ) (?: \. \d+ )? (?: [eE] [-+]? \d+ )?
        )
      (?{  [$^R, eval $^N] })
      \s*
    )
    (?<OBJECT>
      (?{ [$^R, {}] })
      \{
        (?:
          (?:[ ]+)
          |
          (?&ELEM)       (?{ [$^R->[0][0], {$^R->[1] => $^R->[2]}] })
            (?:,(?&ELEM)      (?{ [$^R->[0][0], {%{$^R->[0][1]}, $^R->[1] => $^R->[2]}] }) 
          )*
        )?
        
      \}    
    )
        (?<ELEM>
          (?&STRING) :  (?&VALUE)                                                            
          (?{ [$^R->[0][0], $^R->[0][1], $^R->[1]]})
        )
    (?<ARRAY>
        (?{ [$^R, []] })
        \s*
        \[ 
            (?:
              (?:[ ]+)
              | 
            (?&VALUE)       (?{ [$^R->[0][0], [$^R->[1]]] })
             (?:,(?&VALUE)       (?{ [$^R->[0][0], [@{$^R->[0][1]}, $^R->[1]]] })
             )* 
      )?      
        \]
        \s*
    )
  ) 
}xms;

sub parse_json {
  my $source = shift;
  chomp($source);  
  $source =~ s/\\u([0-9a-fA-f]{4})(?{my $qwe ="0x$1";chr(eval $qwe)})/$^R/g;
  $source =~ s/\{[\s]*\}/\{\}/g;  
  eval { $source =~ m{\A$reg\z}} ;
  #die  if $source =~ /(?:\{(?!\}))/;
  #die  if $source =~ /(?:\[(?!\]))/;
  p $source;
  return $source; 
}
1;
 