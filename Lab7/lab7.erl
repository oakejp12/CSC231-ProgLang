% Author: Johan Oakes and Dr. Turkett
% Date: March 4, 2015

-module(lab7).
-export([isLarger/2, evaluate/1, findInTree/2, max/1, strcat/1, longStrings/1, logicalOR/1, extractAWords/1, extractEvens/1, map/2,reduce/2,filter/2,getStringTree/0,stringToFloat/1,getExpression1/0,getExpression2/0,getExpression3/0]).

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

% Helper function used to map out an auxiliary function
% over a list of elements
map(_,[]) ->
	[];
map(F,[X|XS]) ->
	[F(X)|map(F,XS)].

% Takes an assoc. function F and a list L of data and 
% returns the result of F(data1, F(data2,..., F(dataN))).
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


% ---------------------------------------------------------------------- %
% ---------------------------------------------------------------------- %

% Check whether input is even or not
% Use exact comparison since using integers
even(X) ->
	N = (X rem 2),
	if
		N =:= 0 -> true;
		N =:= 1 -> false
	end.
	
% Extracts the evens out from a list
extractEvens([]) -> [];
extractEvens(L) -> filter(fun even/1, L).

% ---------------------------------------------------------------------- %
% ---------------------------------------------------------------------- %

% Check whether input begins with an 'a' or an 'A'
alphaWord(A) ->
	M = hd(A),
	if
		M =:= $a -> true;
		M =:= $A -> true;
		M =/= $a -> false;
		M =/= $A -> false
	end.

% Extracts all words that begin with an 'a' or an 'A'
% from an input list
extractAWords([]) -> [];
extractAWords(L) -> filter(fun alphaWord/1, L).

% ---------------------------------------------------------------------- %
% ---------------------------------------------------------------------- %

% Function to logically OR two input parameters
logic(X,Y) -> 
	if
		X == true -> true;
		Y == true -> true;
		true -> false
	end.

% Find the logical OR of a list of Boolean values.
logicalOR([]) -> "No input parameters to OR";
logicalOR(L) -> reduce(fun logic/2, L).

% ---------------------------------------------------------------------- %
% ---------------------------------------------------------------------- %

% Check if string is longer than 3 characters
isLong(S) ->
	if
		length(S) > 3 -> true;
		true -> false
	end.

% Filter out elements of a list longer than 3 characters
longStrings([]) -> [];
longStrings(List) -> filter(fun isLong/1, List).

% ---------------------------------------------------------------------- %
% ---------------------------------------------------------------------- %

% Append two strings together
append(String1, String2) -> String1 ++ String2.

% Concatenate a list of strings
strcat([]) -> [];
strcat(L) -> reduce(fun append/2, L).

% ---------------------------------------------------------------------- %
% ---------------------------------------------------------------------- %

% Returns larger of two elements
isLarger(EL1, EL2) ->
	if 
		(EL1 - EL2) > 0 -> EL1;
		(EL2 - EL1) > 0 -> EL2;
		true -> EL1 % Since we are supposing they are the same
	end.

% Take care of empty case
% Find the maximum element of a list
max([]) -> [];
max(L) -> reduce(fun isLarger/2, L).

% ---------------------------------------------------------------------- %
% ---------------------------------------------------------------------- %

% findInTree takes a string label S to search for & 
% 	the tree T to search within as arguments.
% Send the rootNode of the tree to search
findInTree(String, Tree) ->
	search(String, Tree#binaryTree.rootNode).

% Search the empty tree
% Use orelse since it resembles the ';'
search(_, null) -> false;
search(String, Tree) ->
	String == Tree#binaryTreeNode.value
	orelse search(String, Tree#binaryTreeNode.left)
	% Search right subtree if S isn't present in left
	orelse search(String, Tree#binaryTreeNode.right).

% ---------------------------------------------------------------------- %
% ---------------------------------------------------------------------- %

% Evaluates mathematical expressions from binary tress
evaluate(T) ->
	lookUP(T#binaryTree.rootNode).

% Recursively move up through the binary tree, evaluate
% mathematical expressions through operators
lookUP(T) ->
	if
		T#binaryTreeNode.value =:= "+" -> lookUP(T#binaryTreeNode.left) + lookUP(T#binaryTreeNode.right);
		T#binaryTreeNode.value =:= "-" -> lookUP(T#binaryTreeNode.left) - lookUP(T#binaryTreeNode.right);
		T#binaryTreeNode.value =:= "*" -> lookUP(T#binaryTreeNode.left) * lookUP(T#binaryTreeNode.right);
		T#binaryTreeNode.value =:= "/" -> lookUP(T#binaryTreeNode.left) / lookUP(T#binaryTreeNode.right);
		true -> stringToFloat(T#binaryTreeNode.value)
	end.




