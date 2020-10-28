(* 1 *)
fun is_older(date1: int*int*int, date2:int*int*int) = 
    if #1 date1 < #1 date2
    then true
    else if #1 date1 = #1 date2 andalso #2 date1 < #2 date2
    then true
    else if #1 date1 = #1 date2 andalso #2 date1 = #2 date2 andalso #3 date1 < #3 date2
    then true
    else false

(* 2 *)
fun number_in_month(dates: (int*int*int) list, month: int) = 
    if null dates
    then 0
    else (if #2 (hd dates) = month then 1 else 0) + number_in_month(tl dates, month)

(* 3 *)
fun number_in_months(dates: (int*int*int) list, months: int list) =
    if null months
    then 0
    else number_in_month(dates, hd months) + number_in_months(dates, tl months)

(* 4 *)
fun dates_in_month(dates: (int*int*int) list, month: int) = 
    if null dates
    then []
    else if #2 (hd dates) = month
        then (hd dates) :: dates_in_month(tl dates, month)
        else dates_in_month(tl dates, month)

(* 5 *)
fun dates_in_months(dates: (int*int*int) list, months: int list) = 
    if null months
    then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

(* 6 *)
fun get_nth(s: string list, n: int) = 
    if n = 1
    then hd s
    else get_nth(tl s, n - 1)

(* 7 *)
fun date_to_string(date: int*int*int) = 
    let 
        val month_names = ["January", "February", "March", "April", "May",
            "June", "July", "August", "September", "October", "November", "December"]
    in
        get_nth(month_names, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
    end

(* 8 *)
fun number_before_reaching_sum(sum: int, nums: int list) = 
    if sum <= hd nums
    then 0
    else 1 + number_before_reaching_sum(sum - (hd nums), tl nums)

(* 9 *)
fun what_month(day: int) = 
    let 
        val days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in 
        number_before_reaching_sum(day, days_in_month) + 1
    end

(* 10 *)
fun month_range(day1: int, day2: int) = 
    if day1 > day2
    then []
    else what_month(day1) :: month_range(day1 + 1, day2)

(* 11 *)
fun oldest(dates: (int*int*int) list) = 
    if null dates
    then NONE
    else 
        let 
            val first = hd dates
            val rest = oldest(tl dates)
        in
            if isSome rest andalso is_older(valOf rest, first)
            then rest
            else SOME first
        end
