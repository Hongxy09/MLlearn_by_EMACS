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

