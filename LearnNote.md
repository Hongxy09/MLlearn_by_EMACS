### Week2
#### 程序的本质
1. Syntax: a sequence of digits表达式的语法
2. Type-checking: type int in any static environment运行前val类型的检查
3. Evaluation: to itself in any dynamic environment运行并在动态环境中记录其值

#### 表达式的定义
1. 必须是递归的，如同加法是由更小的表达式组成，表达式也是由子表达式定义的。
2. 定义表达式时要注意
* 该表达式的Syntax语法是否对？
* Type-checking表达式中的类型以及无法检查类型时如何输出错误提示？
type-check检查（在使用表达式时进行类型检查），成功->对表达式进行类型检查，没过fail->输出错误提示然后终止。即在静态环境中寻找这个表达式的类型，找到了就输出，没找到就报错。
* typecheck后在动态环境中寻找表达式的值（此处以val为例）然后使用这个值（这个值是必然存在的因为经过了静态检查，这个表达式必然存在）
* 例如：val a=10;首先检查val的语法，再检查其类型，a->int,再进行赋值a->10
   * 关于这个binding的问题
     * val的语法？后续是一个值
     * 如何检查a的类型？它这个时候就在静态环境中了吗？在静态环境中，程序会检查binding的值的类型，因为10是一个int，所以在静态环境中a->int
     * 动态环境中什么时候有的10：执行完语句之后动态环境中有a->10，因为binding的时候给了一个10，这个句子经过了语法和type检查后就会把这个值赋给a

1. 例子加法为例
语法：表达式+表达式；子表达式e1和e2typecheck过（成功），且输出其类型是int，则这个加法表达式的typecheck通过并输出int；v1+v2的值（类型检查后其和也是int）
4. 表达式与值的关系：估值（Evaluation）的结果就是值。每个值都是表达式但不是每个表达式都是值【这里是因为不是每个表达式都有估值结果，存在未通过typecheck的表达式，引出一个思考是：词语的语义和逻辑，例如42本身即代表了42这个字，也代表了42这个值】
* 有一些会自行估值其值的表达式（42 evaluates to 42,true evaluates to true）
* 每个类型都有其特定的值，当使用某种类型的表达式时，这个表达式估值得到的答案就是这些特定的值
* 以32为例，语法是一串数字；类型检查它的类型是int；估值（求值规则）是产生其自身。
1. 复杂的例子：if e1 then e2 else e3
   1. Syntax: if e1 then e2 else e3;if,then,else是语法关键词（keywords）;e1,e2,e3是子表达式
   2. Type-checking: e1:bool;e2 and e3:t(any type but same)且整个表达式类型是是t
   3. Evaluation: e1->v1(因为经过了类型检查所以v1是true或者false);if true:估值e2并作为整个表达式的结果;if else:估值e3并将v3作为整个表达式的结果。
2. less than
   1. Syntax: e1< e2("<"是一个逻辑运算符)
   2. Type-checking: e1 and e2:t(any type but same：数字型)且整个表达式类型(过了的话)是bool
   3. Evaluation: e1->v1和e2->v2(因为经过了类型检查所以e1和e2必然有v1和v2)，如果v1< v2输出true不然flase

#### REPL和错误
1. REPL：Read-Eval-Print-Loop 程序本身就是一个REPL，use语句可以更方便的使用它
* 当运行程序的时候（打开rapple输入use）发生读取-估值（如果载估值之前没有类型检查会输出错误信息）-打印结果-循环（返回提示以继续）
* 表达式的开始是以val这类开始的，如果没有键入val就开始下一行，`val x=10；y=x+1`是存在这个类型的语法的，但是可能会解析成`val x = 34 (y=x) +1`此时（y=x）输出一个bool值，而34被认为是一个函数，但是34并不是一个函数，在类型检查中34没有通过其'fun'的类型，因此报错为"operator is not a function [overload conflict]"
* 负数要用~（负号是语法错误）；整数除法不能用/要用div（类型检查错误）
  
#### Shadowing
1. Shadowing是指将变量添加到环境中时，在添加之前，该变量已在环境中。
2. 例子：val a=5;val a=10;此时a=5这个是无法改变的，我们获得是是一个遮罩值10，此时的a->10，当使用val a=a+1;此时a->11遮住了之前的10。在输出的时候，5和10的语句都会被显示为hidden-value，只有最后的a有值
*  val a = <hidden-value> : int
   val b = 9 : int
   val a = <hidden-value> : int
   val a = 6 : int
   val it = () : unit）
3. 最好不要重复赋值，因为动态环境的值除非重启不然一直存在

#### function
1. 语法：fun fun_name(arguments:int,y:int)=
            ...expression...
2. 除非只有一个参数不然要加括号，会自动返回得出的结果不用加return。
3. 在输出函数中，`val pow = fn : int * int -> int`里的*不是乘法，它只是分隔多个参数的类型。