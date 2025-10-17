/* Task 1 */
/* 1a */
declare fun {Lex Input}
	{String.tokens Input & }
end
{Show {Lex '1 2 + 3 *'}}

/* 1b */
declare fun {LexemeToToken Lexeme}
	case Lexeme
	of '+' then operator(type:plus)
	[] '-' then operator(type:minus)
	[] '*' then operator(type:multiply)
	[] '/' then operator(type:divide)
	[] 'p' then command(print)
	[] 'd' then command(duplicate)
	[] 'i' then command(invert)
	[] 'c' then command(clear)
	else
		try number({String.toInt Lexeme})
		catch _ then raise "invalid lexeme ’"#Lexeme#"’" end
		end
	end
end
{Show {LexemeToToken '1'}}
{Show {LexemeToToken '2'}}
{Show {LexemeToToken '+'}}
{Show {LexemeToToken '3'}}
{Show {LexemeToToken '*'}}

declare fun {Tokenize Lexemes}
	{List.map Lexemes LexemeToToken}
end
{Show {Tokenize ['1' '2' '+' '3' '*']}}

/* 1c */
declare fun {Interpret TokenList}
	fun {Read Tokens Stack}
		case Tokens
		of nil then Stack

		[] number(N)|_ then {Read Tokens.2 N|Stack}
	
		[] operator(type:T)|_ then
			case Stack of B|A|Rest then
				case T
				of plus then {Read Tokens.2 (A+B)|Rest}
				[] minus then {Read Tokens.2 (A-B)|Rest}
				[] multiply then {Read Tokens.2 (A*B)|Rest}
				[] divide then {Read Tokens.2 (A.0/B.0)|Rest}
				else raise 'unknown operator type:'#T end
				end
			else raise 'cant apply, too few arguments' end
			end
	
		[] command(C)|_ then
			case C
			of print then % 1d
				{Show Stack}
				{Read Tokens.2 Stack}
			[] duplicate then {Read Tokens.2 Stack.1|Stack} % 1e
			[] invert then {Read Tokens.2 (~Stack.1)|Stack.2} % 1f
			[] clear then {Read Tokens.2 nil} % 1g
			else raise 'unknown command'#C end
			end
		else raise 'unknown token:'#Tokens.1 end
		end
	end
in
	{Read TokenList nil}
end
{Show {Interpret [number(1) number(2) number(3) operator(type:plus)]}}

{Show {Interpret {Tokenize ['1' '2' 'p' '3' '+']}}} % 1d: test

{Show {Interpret {Tokenize ['1' '2' '3' '+' 'd']}}} % 1e: test

/* Task 2 */

/* Explanation
	I don't really see why the converting from postfix to expression tree needs to be explained.

	When you're parsing postfix left to right you're pushing items onto an empty stack.

	When you pop items off of the stack you are fetching them in the reverse order you put them in. LIFO, Last In First Out

	That way when you pop the items off the stack and add them to an operator item they end up the right way.
 */
declare fun {ExpressionTree TokenList}
	fun {Expr T Left Right}
		case T
      of plus then plus(Left Right)
      [] minus then minus(Left Right)
      [] multiply then multiply(Left Right)
      [] divide then divide(Left Right)
      else raise 'unknown operator type:'#T end
      end
	end

	fun {ExpressionTreeInternal Tokens Stack}
   	case Tokens
   	of nil then Stack.1
   	[] number(N)|_ then
      {ExpressionTreeInternal Tokens.2 N|Stack}
   	[] operator(type:T)|_ then
      case Stack of Left|Right|Rest then
        {ExpressionTreeInternal Tokens.2 {Expr T Left Right}|Rest}
      else
        raise 'not enough operands for operator:'#T end
      end
   	else
      raise 'unknown token:'#Tokens.1 end
   	end
	end
in
  {ExpressionTreeInternal TokenList nil}
end

{Show {ExpressionTree
   [number(3) number(10) number(9) operator(type:multiply)
    operator(type:minus) number(7) operator(type:plus)]}}

/* Task 3 */

% a):
/* 
Terminals:
	Digit = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
	Operator = {+, -, *, /}
	Command = {p, d, i, c}
Non-terminals: Number, Operator, Command, Token, Program
Productions:
	Number = Digit | Digit Number
	Operator = Number Number Operator
	Command = Number Command
	Token = Number | Operator | Command
	Program = Token Program | e
Start-Symbol: any Digit
*/

% b):
/* 
Expression   ::= Number | Operation
Number       ::= "number(" Integer ")"
Integer      ::= Digit { Digit }
Digit        ::= "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
Operation    ::= Operator "(" Expression " " Expression ")"
Operator     ::= "plus" | "minus" | "multiply" | "divide"
*/

% c):
/* 
Grammar A is context-free grammar as it is accurately described using

A -> a

where A is a non-terminal and a is a string of terminals and non-terminals.

It is also a regular language as it can be validated using regular expressions :p or rather it can be visualized as a DFA (Deterministic Finite Automaton)

Grammar B is context-free, but not regular as it can not be visualized as a DFA.
You can recognize this by being able to nest parenthesis which means you would have to be able to track the state, how many parenthesis deep we are, which DFA does not.
*/