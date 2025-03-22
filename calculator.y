%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h> // derleme sirasinda -lm ile linkleme gereklidir
// gcc lex.yy.c y.tab.c -o calculator -lm

// Function prototypes (bu sekilde tanimlanmayinca implicit declaration hatasi aldik)
int yylex(void);
int yyerror(const char *s);
%}

/* Semantik degerleri tutmak icin union tanimi */
%union {
    double dval;  /* float/double degerleri sakla */
}

/* token ve nonterminal type atamalari */
%token <dval> NUMBER
%token PLUS MINUS TIMES DIVIDE LPAREN RPAREN POWER
%type <dval> expr


// Oncelik tanimlari
%left PLUS MINUS
%left TIMES DIVIDE
%right POWER

%%
input:
      /* empty */
    | input line
    ;

/* Tek satir -> bos satir veya 'expr' ile biten satir */
line:
      '\n'
    | expr '\n'  { printf("Output: %g\n", $1); }
    ;

/* Aritmetik ifadeler */
expr:
      expr PLUS expr    { $$ = $1 + $3; }
    | expr MINUS expr   { $$ = $1 - $3; }
    | expr TIMES expr   { $$ = $1 * $3; }
    | expr DIVIDE expr  { 
                            if ($3 == 0) {
                                printf("Division by zero error!\n");
                                exit(1);
                            } else {
                                $$ = $1 / $3;
                            }
                         }
    | expr POWER expr   {
                            /* math.h iCindeki pow fonksiyonu */
                            $$ = pow($1, $3);
                        }
    | LPAREN expr RPAREN { $$ = $2; }
    | NUMBER             { $$ = $1; }
    ;
%%

int main(void) {
    printf("Input:\n");
    yyparse();
    return 0;
}

/* Hata mesaji yazdiran fonksiyon */
int yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}