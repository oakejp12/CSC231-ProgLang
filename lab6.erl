% Author: Johan Oakes
% Lab 6 Functions in Erlang
-module (lab6).
-export ([productOfPairs/1, polyadd/2, polydiff/2, polyeval/2]).

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

% 
% All poly_ recurvsive functions below: 
% 	Use patterns in place of hd & tl calls
%	Cannot use local variables
%

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


			















