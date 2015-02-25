% Author: Johan Oakes
% Lab 6 Functions in Erlang
-module (lab6).
-export ([productOfPairs/1, polyadd/2, polydiff/2, polyeval/2]).

% test1()
% TODO: Look to amend the last function - replacing hd/tl calls
productOfPairs([]) ->
	[];
productOfPairs([X]) ->
	[X];
productOfPairs([X | XS]) ->
	[X * hd(XS) | productOfPairs(tl(XS))].

% test2a() 
polyadd([], []) ->
	[];
polyadd(List1, []) ->
	List1;
polyadd([], List2) ->
	List2;
polyadd([X|XS], [Y|YS]) ->
	[X + Y | polyadd(XS,YS)].


% test2b()
polydiff([],[]) ->
	[];
polydiff(List1, []) ->
	List1;
polydiff([], [X|XS]) ->
	[- X | polydiff([], XS)];
polydiff([X|XS], [Y|YS]) ->
	[X - Y | polydiff(XS, YS)].

% test2c()
polyeval([], _) ->
	0;
polyeval([X | XS], N) ->
	















