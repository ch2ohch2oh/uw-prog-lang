signature COUNTER1 =
sig
    type t = int
    val newCounter : int -> t
    val increment : t -> t
    val first_larger : t * t -> bool
end

signature COUNTER2 =
sig
    type t = int
    val newCounter : int -> t
    val first_larger : t * t -> bool
end

signature COUNTER3 =
sig
    type t
    val newCounter : int -> int
    val increment : t -> t
    val first_larger : t * t -> bool
end



structure NoNegativeCounter :> COUNTER3 = 
struct

exception InvariantViolated

type t = int

fun newCounter i = if i <= 0 then 1 else i

fun increment i = i + 1

fun first_larger (i1,i2) =
    if i1 <= 0 orelse i2 <= 0
    then raise InvariantViolated
    else (i1 - i2) > 0

end

val test1 = NoNegativeCounter.first_larger(~1, 0)