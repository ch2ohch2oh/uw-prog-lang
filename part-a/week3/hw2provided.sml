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
fun get_substitutions2 (subs: string list list, s: string) = 
   let
      fun get_subs(subs: string list list, acc: string list) = 
         case subs of
            [] => acc
            | first :: rest => case all_except_option(s, first) of
               NONE => get_subs(rest, acc)
               | SOME lst => get_subs(rest, lst @ acc)
   in
      get_subs(subs, [])
   end

(* 1d *)
fun similar_names(subs: string list list, 
   full_name: {first:string, middle:string, last:string}) = 
   let 
      val {first=first_name, middle=middle_name, last=last_name} = full_name
      fun replace_first_name (first_names: string list) = 
         case first_names of
            [] => []
            | first::rest => {first=first, middle=middle_name, last=last_name} :: replace_first_name(rest)
   in 
      full_name :: replace_first_name (get_substitutions1(subs, first_name))
   end

(* 2a *)
fun card_color (s:suit, r:rank) = 
   case s of
      Spades => Black
      | Clubs => Black
      | _ => Red

(* 2b *)
fun card_value (s:suit, r:rank) = 
   case r of
      Ace => 11
      | Num value => value
      | _ => 10

(* 2c *)
fun remove_card (cs:card list, c:card, e) = 
   case cs of
      [] => raise e
      | first::rest => 
            if first = c
            then rest
            else remove_card(rest, c, e)

(* 2d *)
fun all_same_color (cs:card list) = 
   case cs of 
      [] => true
      | c::[] => true
      | c1::c2::rest => 
            if card_color(c1) = card_color(c2)
            then all_same_color(c2::rest)
            else false

(* 2e *)
fun sum_cards (cs:card list) = 
   let 
      fun sum_card_value(card_list: card list, partial_sum: int) = 
         case card_list of
            [] => partial_sum
            | first::rest => sum_card_value(rest, partial_sum + card_value(first))
   in
      sum_card_value(cs, 0)
   end

(* 2f *)
fun score (cs:card list, goal:int) = 
   let
      val sum = sum_cards(cs)
      val prelim_score = if sum > goal then 3 * (sum - goal) else (goal - sum)
      val final_score = if all_same_color(cs) then prelim_score div 2 else prelim_score
   in
      final_score
   end

(* 2g *)
fun officiate (cs:card list, ms:move list, goal:int) = 
   let 
      fun run (card_held:card list, card_remains:card list, moves:move list) = 
         case moves of
            [] => score (card_held, goal)
            | (Discard x)::moves' => run (remove_card(card_held, x, IllegalMove), card_remains, moves')
            | (Draw)::moves' => 
                  case card_remains of
                     [] => score(card_held, goal)
                     | first::card_remains' => 
                           if sum_cards(card_held) + card_value(first) > goal
                           then score(first::card_held, goal)
                           else run(first::card_held, card_remains', moves')
   in
      run ([], cs, ms)
   end
