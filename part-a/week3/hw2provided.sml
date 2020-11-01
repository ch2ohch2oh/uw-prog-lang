(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
(* 1a *)
fun all_except_option (s:string, slist: string list) = 
   case slist of
      [] => NONE
      | first::rest => if same_string(s, first)
            then SOME rest
            else case all_except_option(s, rest) of
               NONE => NONE
               | SOME lst => SOME (first::lst)

(* 1b *)
fun get_substitutions1 (subs: string list list, s: string) = 
   case subs of
      [] => []
      | first::rest => case all_except_option(s, first) of 
         NONE => get_substitutions1(rest, s)
         | SOME lst => lst @ get_substitutions1(rest, s)

(* 1c *)

(* 1d *)
