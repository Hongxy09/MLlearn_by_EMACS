fun min (x,y) = 
    if x<y
    then true
    else false

fun is_older(x:(int * int * int),y:(int * int * int))=
    if #1x < #1y orelse #1x > #1y
    then min(#1x,#1y)
    else if #2x < #2y orelse #2x > #2y
    then min(#2x,#2y)
    else min(#3x,#3y)

fun datas_in_num(x:(int * int * int),y:int)=
    if #2 x = y
    then true
    else false 


fun number_in_month(ls:(int * int * int) list,m_num:int)=
    if null ls
    then 0
    else 
        let val num = number_in_month(tl ls,m_num)
        in if datas_in_num(hd ls,m_num)
            then num+1
            else num
        end

fun number_in_months(ls:(int * int * int) list,m_ls:int list)=
    if null ls orelse null m_ls
    then 0
    else
        let val num = number_in_months(ls,tl m_ls)
        in num+number_in_month(ls,hd m_ls)
        end

fun dates_in_month(ls:(int * int * int) list,m_num:int)=
    if null ls
    then []
    else 
        let val data_ls = dates_in_month(tl ls,m_num)
        in if datas_in_num(hd ls,m_num)
            then hd ls :: data_ls
            else data_ls
        end;

fun add_list(ls1:(int * int * int) list,ls2:(int * int * int) list)=
    if null ls1 orelse null ls2
    then if null ls1
         then ls2
         else ls1
    else
        hd ls1 :: add_list(tl ls1,ls2)

fun dates_in_months(ls:(int * int * int) list,m_ls:int list)=
    if null ls orelse null m_ls
    then []
    else
        let val data_ls = dates_in_months(ls,tl m_ls)
        in add_list(dates_in_month(ls,hd m_ls),data_ls)
        end

fun get_nth(str_ls:string list,idx:int)=
    if idx=1
    then hd(str_ls)
    else get_nth(tl str_ls,idx-1)

fun date_to_string(data:int * int * int)=
    let val str_ls = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    in get_nth(str_ls,#2 data)^" "^Int.toString(#3 data)^", "^Int.toString(#1 data)
    end

fun number_before_reaching_sum(sum:int,num_ls:int list)=
    if sum < hd num_ls orelse sum = hd num_ls
    then 0
    else let val idx = 1
         in if sum < hd num_ls
            then idx
            else idx+number_before_reaching_sum(sum-hd num_ls,tl num_ls)
         end

fun what_month(x:int)=
    let val num_ls = [31,28,31,30,31,30,31,31,30,31,30,31]
    in number_before_reaching_sum(x,num_ls)+1
    end

fun month_range(x:int,y:int)=
    if x > y
    then []
    else let val ls = month_range(x+1,y)
         in what_month(x)::ls
         end

fun oldest(ls:(int * int * int) list)=
    if null ls
    then NONE
    else let val tl_old = oldest(tl ls)
         in if not(isSome(tl_old))
            then SOME(hd ls)
            else if is_older(hd ls,valOf(tl_old)) orelse (hd ls) = valOf(tl_old)
                 then SOME (hd ls)
                 else tl_old
         end


