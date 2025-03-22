%{
#include "y.tab.h" /* Yacc tarafindan uretilen token tanimlarini kullanabilmek icin */
#include <stdlib.h>
#include <stdio.h>
%}

%%

"+"           { return PLUS; }
"-"           { return MINUS; }
"*"           { return TIMES; }
"/"           { return DIVIDE; }
"^"           { return POWER; }
"("           { return LPAREN; }
")"           { return RPAREN; }

[0-9]+(\.[0-9]+)?  { yylval.dval = atof(yytext); return NUMBER; }

\n           { return '\n'; }

[ \t]+       { /* ignore whitespace */ }

.             { printf("Unknown character: %s\n", yytext); }
%%

int yywrap(void) {
    return 1;
}