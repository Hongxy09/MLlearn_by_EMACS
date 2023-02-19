(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same string), then you avoid several of the functions in problem 1 having polymorphic types that may be confusing *)

fun same_string(s1 : string, s2 : string) =
    s1 = s2;

(* put your solutions for problem 1 here *)

fun all_except_option(str:string,strls:string list) = 
   let fun f (xs,acc) =
             case xs of
                [] => NONE
                | x::xs' => if same_string(x,str)
                            then SOME (xs' @ acc)
                            else f (xs',x::acc)
    in
        f(strls,[])
    end;

(* I can't write a non-recursive solution *)
fun get_substitutions1(inputstrlsls:string list list,str:string) =
   let fun f(strlsls,acc,str) =
        case strlsls of 
            [] => acc
            | firls::lsls => case all_except_option(str,firls) of
                            SOME xs => f(lsls,xs @ acc,str)
                            | NONE => f(lsls,acc,str)
    in
        f(inputstrlsls,[],str)
    end; 

fun get_substitutions2(strlsls:string list list,str:string) =
   let fun f(strlsls,acc,str) =
        case strlsls of 
            [] => acc
            | firls::lsls => case all_except_option(str,firls) of
                            SOME xs => f(lsls,xs @ acc,str)
                            | NONE => f(lsls,acc,str)
    in
        f(strlsls,[],str)
    end;

fun similar_names(strlsls:string list list,{first=x, last=y, middle=z}) = 
    let 
        val newnamels = get_substitutions1(strlsls,x)
    in
        let fun samename(newnamels,res)=
                case newnamels of
                    [] => res
                    |a::ls => samename(ls,res@[{first=a, last=y, middle=z}])
        in 
            samename(newnamels,[{first=x, last=y, middle=z}])
        end
    end;


(* you may assume that Num is always used with values 2, 3, ..., 10 though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

fun card_color(onecard:card) = 
    case onecard of
        (Clubs,_) => Black
        |(Clubs,_) => Black
        
