
/** Modified from JSON grammar */

grammar Jinja2;

jinja
   : value
   ;

blck_start
   : '{%'
   | '{%-'
   ;

blck_end
   : '%}'
   | '-%}'
   ;

statement
   : blck_start assignment blck_end
   ;

//{{ ... }} for Expressions to print to the template output
exp_start
   : '{{'
   ;

exp_end
   : '{{'
   ;

expression
   : exp_start value exp_end
   ;

//{# ... #} for Comments not included in the template output

//#  ... ## for Line Statements

assignment
   : 'set' STRING '=' value
   ;

obj
   : '{' pair (',' pair)*','? '}'
   | '{' '}'
   ;

pair
   : STRING ':' value
   ;

array
   : '[' value (',' value)* ']'
   | '[' ']'
   ;

value
   : STRING
   | NUMBER
   | obj
   | array
   | statement
   | expression
   | 'true'
   | 'false'
   | 'null'
   ;


STRING : ([a-zA-Z_0-9] | '-')+
       | '\'' ( ~'\'' | '\'\'' )* '\''
	   ;


fragment ESC
   : '\\' (["\\/bfnrt] | UNICODE)
   ;


fragment UNICODE
   : 'u' HEX HEX HEX HEX
   ;


fragment HEX
   : [0-9a-fA-F]
   ;


fragment SAFECODEPOINT
   : ~ ["\\\u0000-\u001F]
   ;


NUMBER
   : '-'? INT ('.' [0-9] +)? EXP?
   ;


fragment INT
   : '0' | [1-9] [0-9]*
   ;

// no leading zeros

fragment EXP
   : [Ee] [+\-]? INT
   ;

// \- since - means "range" inside [...]

WS
   : [ \t\n\r] + -> skip
   ;
