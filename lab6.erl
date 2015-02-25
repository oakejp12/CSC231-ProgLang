% Author: Johan Oakes
% Lab 6 Functions in Erlang
-module (lab6).
-export ([productOfPairs/1, polyadd/2, polydiff/2, polyeval/2, member/2, delete/2, insert/2]).

% test1()
% Allows you to multiply consecutive elements in a lists
%	productOfPairs([1,2,3,4]) -> [2,12]
% TODO: Look to amend the last function - replacing hd/tl calls
productOfPairs([]) ->
	[];
productOfPairs([X]) ->
	[X];
productOfPairs([X | XS]) ->
	[X * hd(XS) | productOfPairs(tl(XS))].

% -----------------------------------------
% All poly_ recurvsive functions below: 
% 	Use patterns in place of hd & tl calls
%	Cannot use local variables
% -----------------------------------------

% test2a() 
% Add two polynomials together w/ certain constraints
polyadd([], []) ->
	[];
polyadd(List1, []) ->
	List1;
polyadd([], List2) ->
	List2;
polyadd([X|XS], [Y|YS]) ->
	[X + Y | polyadd(XS,YS)].


% test2b()
% Subtract two polynomials together w/ certain constraints
polydiff([],[]) ->
	[];
polydiff(List1, []) ->
	List1;
polydiff([], [X|XS]) ->
	[- X | polydiff([], XS)];
polydiff([X|XS], [Y|YS]) ->
	[X - Y | polydiff(XS, YS)].

% test2c()
% Evaluates polynomial for a given input value
polyeval([], _) ->
	0;
polyeval([C | CS], N) ->
	C + (N * polyeval(CS, N)).


% -----------------------------------------
% Basic implementations of sets using lists
% Set definition: items in the set may appear
%	in any order in the underlying list, but only once
% Use patterns and local variables as approp.
% -----------------------------------------

% test3a()
% member(X,S) -> true if element X is in the set S.


% test3b()
% delete(X,S) -> removes x from the set S if X is present in the set


% test3c()
% insert(X,S) -> add X to set S if X is not already present in set



%------------------------------------------
% Rewrite of the largest function
% Use local variables (not patterns) to
%	reduce the number of times hd & tl are called
%------------------------------------------









