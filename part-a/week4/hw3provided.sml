(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu



(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

(* 1 *)
(* List.filter = fn : ('a -> bool) -> 'a list -> 'a list *)
val only_capitals = 
	List.filter(fn x => Char.isUpper(String.sub(x, 0)))

(* 2 *)
(* foldl = fn : ('a * 'b -> 'b) -> 'b -> 'a list -> 'b *)
val longest_string1 = 
	foldl(fn (a: string, b: string) => if String.size(a) > String.size(b) then a else b)
		("")
(* 3 *)
val longest_string2 = 
	foldl(fn (a: string, b: string) => if String.size(a) >= String.size(b) then a else b)
		("")

(* 4 *)
fun longest_string_helper (f: (int*int)->bool)=
	foldl(fn (a:string, b:string) => 
		if f(String.size(a), String.size(b)) then a else b)
		("")

val longest_string3 = longest_string_helper(fn (a, b) => a > b)

val longest_string4 = longest_string_helper(fn (a, b) => a >= b)

(* 5 *)
val longest_capitalized = longest_string1 o only_capitals 

(* 6 *)
val rev_string = implode o rev o explode

(* 7 *)
fun first_answer f xs = 
	case xs of
		[] => raise NoAnswer
		| x::xs' => case f x of 
			SOME v => v
			| NONE => first_answer f xs'
	
(* 8 *)
fun all_answers f xs = 
	case xs of
		[] => SOME []
		| x::xs' => case f x of
			SOME v => (case all_answers f xs' of
				SOME v' => SOME (v @ v')
				| NONE => NONE)
			| NONE => NONE

(* 9 *)
fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(* 9a *)
val count_wildcards = g (fn () => 1) (fn (x) => 0)

(* 9b *)
val count_wild_and_variable_lengths = g (fn () => 1) (fn x => String.size(x))

(* 9c *)
fun count_some_var (s: string, p: pattern) = 
	g (fn () => 0) (fn x => if x = s then 1 else 0) p

(* 10 *)
fun check_pat (p: pattern) = 
	let 
		fun unique xs = 
			case xs of
				[] => true
				| x::xs' => if List.exists (fn x' => x = x') xs' 
					then false
					else unique xs'
				
		fun gather_vars (p: pattern) = 
			case p of 
				Variable x => [x]
				| TupleP ps => List.foldl (fn (p', acc) => acc @ (gather_vars p')) [] ps
				| ConstructorP (s, p') => gather_vars p'
				| _ => []
	in
		(* gather_vars p *)
		unique (gather_vars p)
	end

(* 11 *)
fun match (v: valu, p: pattern) = 
	case (v, p) of
		(_, Wildcard) => SOME []
		| (v', Variable s) => SOME [(s, v')]
		| (Unit, UnitP) => SOME []
		| (Const v', ConstP p') => if v' = p' then SOME [] else NONE
		| (Tuple vs, TupleP ps) =>
			if List.length(vs) = List.length(ps)
			then all_answers (fn (v', p') => match(v', p')) (ListPair.zip(vs, ps))
			else NONE
		| (Constructor(s2, v'), ConstructorP(s1, p')) => 
			if s1 = s2
			then match(v', p')
			else NONE
		| _ => NONE

(* 12 *)
fun first_match (v: valu) (ps: pattern list) = 
	SOME (first_answer (fn p => match(v, p)) ps) handle NoAnswer => NONE