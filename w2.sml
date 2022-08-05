fun min (x,y) = 
    if x<y
    then true
    else false;

fun is_older(x:(int * int * int),y:(int * int * int))=
    if #1x < #1y orelse #1x > #1y
    then min(#1x,#1y)
    else if #2x < #2y orelse #2x > #2y
    then min(#2x,#2y)
    else min(#3x,#3y)

fun number_in_month(ls:(int * int * int) list,m_num:int)=
    if null ls
    then 0
    else 
        let val num = number_in_month(tl ls,m_num)
        in if m_num = #2(hd ls)
            then num+1
            else num
        end

fun number_in_months(ls:(int * int * int) list,m_ls:int list)=
    if null ls orelse null m_ls
    then 0
    else
        let val num = number_in_months(ls,tl m_ls)
        in num+number_in_month(ls,hd m_ls)
        end;
