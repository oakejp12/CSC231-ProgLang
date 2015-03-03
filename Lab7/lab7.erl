-module(lab7).
-export([extractEvens/1, map/2,reduce/2,filter/2,getStringTree/0,stringToFloat/1,getExpression1/0,getExpression2/0,getExpression3/0]).

-record(binaryTreeNode, {value,left=null,right=null}).
-record(binaryTree, {rootNode=null}).

getStringTree() -> 
#binaryTree{rootNode = #binaryTreeNode{value = "Erlang", left = #binaryTreeNode{value = "as", left = #binaryTreeNode{value = "a",left = null,right = null},right = #binaryTreeNode{value = "in",left = null,right = null}},right = #binaryTreeNode{value = "types",left = null, right = null}}}.

getExpression1() ->
#binaryTree{rootNode = #binaryTreeNode{value="2.0"}}.

getExpression2() ->
#binaryTree{rootNode = #binaryTreeNode{value="+",left=#binaryTreeNode{value="2.0"},right=#binaryTreeNode{value="4.0"}}}.

getExpression3() ->
#binaryTree{rootNode = #binaryTreeNode{value="/",left=#binaryTreeNode{value="+", left=#binaryTreeNode{value="3.0"},right=#binaryTreeNode{value="2.0"}},right=#binaryTreeNode{value="*",left=#binaryTreeNode{value="2.0"},right=#binaryTreeNode{value="2.5"}}}}.

stringToFloat(X) -> 
	element(1,string:to_float(X)).

map(_,[]) ->
	[];
map(F,[X|XS]) ->
	[F(X)|map(F,XS)].


reduce(_, [A]) ->
	A;
reduce(F, [A|AS]) ->
	F(A, reduce(F,AS)).

% Filters out a list of elements based on predicate P(X)
filter(_,[]) ->
	[];
filter(P,[X|XS]) ->
	case P(X) of 
	true ->
		 [X|filter(P,XS)];
	_ -> 
		filter(P,XS)
	end.

% Check whether input is even or not
even(X) -> 
	if
		(X rem 2) == 0 -> true;
		true -> false
	end.
	
% Extracts the evens out from a list
extractEvens(L) ->
	filter(fun even/1, L).








