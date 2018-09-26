%{
#define YYDEBUG 1
%}

%token PICTURE IDENTIFIER START END
%token VAR
%token TYPE
%token FOR TO VAL_INT STEP DO DONE
%token VAL_NUM VAL_POINT VAL_LINESHAPE VAL_STRING
%token FCALLPREFIXOPEN

%token ASGN ":=" 
%token ASGN_LATE "<-"
%token LBLB "<<"
%token RBRB ">>"

%expect 0

%%



program : PICTURE VAL_STRING declarations START commands END
        ;

declarations  : %empty
              | declarations declaration 
              ;

declaration   : VAR IDENTIFIER ':' TYPE ';'
              ;

commands      : %empty
              | commands command
              ;

command       :  assign  /*1*/
              |  fcall ';'  /*1*/
              |  loop ';'   /*1*/
              |  IDENTIFIER ';'  /* for Terms */
              ;
/*0*/
assign        :  IDENTIFIER ":=" potentialvalue ';'  /*2*/
              |  IDENTIFIER "<-" potentialvalue ';'  /*2*/
              ;

fcall         :  FCALLPREFIXOPEN args ')'                 /*2*/
              |  fcall_nonprefix                      /*2*/
              ; 

loop          :  FOR IDENTIFIER ":=" VAL_NUM TO VAL_NUM STEP VAL_NUM DO commands DONE
/*1*/
potentialvalue     :  IDENTIFIER_or_val           /*3*/
                   |  fcall                       /*3 (in 2)*/
                   |  val_therme                  /*3*/
                   ;

args          :   args_inner                /*3*/
              ;
                   
fcall_nonprefix   :  potentialvalue '+' potentialvalue
              |  potentialvalue '-' potentialvalue
              |  potentialvalue '*' potentialvalue
              |  potentialvalue '/' potentialvalue
              |  potentialvalue "mod" potentialvalue
              ;
/*2*/
              
IDENTIFIER_or_val     :  IDENTIFIER
                      |  value                  /*4*/
                      |  "<<" args_inner ">>"
                      ;

val_therme    :  '{' commands '}'
              ;
              
             
              




args_inner    :  potentialvalue
              |  args_inner ',' potentialvalue
              ;
              
/*3*/

value                 :  VAL_POINT
                      |  VAL_INT
                      |  VAL_NUM
                      |  VAL_STRING
                      ;
                      
                      



%%

int main(int argc, char* argv[]){
  extern FILE* yyin;
  ++argv;--argc;
  yyin = fopen(argv[0],"r");
  yydebug = 1;
  yyparse();
  printf("Woow!! Parse Completed!\n");

}

void yyerror(char* s){
  printf("%s\n", s);
}
