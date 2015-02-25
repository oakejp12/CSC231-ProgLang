% Lab 5 Functions in Erlang
-module(lab5).
-export([fourthPower/1,  fourthPower2/1, median3/1, factorial/1, getNth/2, largest/1, contains/2, logarithm/2]).
fourthPower(N) -> N * N * N * N.
square(N) -> N * N.
fourthPower2(FourPow) -> square(FourPow) * square(FourPow).

median3({A, B, C}) -> element(2, {A,B,C}).

factorial(N) ->
    if
        N =< 1 -> 1;
        true -> N * factorial(N-1)
    end.

cycleOnce(L) -> tl(L) ++ [hd(L) | []].

% Get nth item out of a list & make use of cycleOnce
getNth(L, N) -> 
    if
	    L == [] -> []; 
    	N == 1 -> hd(L);
	    N > length(L) -> "Out of bounds";
	    N == 0 -> "Out of bounds mate";
    	true -> getNth(cycleOnce(L), N-1)
    end.

% Return the largest item in a list
largest(L) ->
	if
		tl(L) == [] -> hd(L); 
		true ->
		    if 
		    	hd(L) < hd(tl(L)) -> largest(tl(L));
		    	true -> largest(cycleOnce(L))
		    end
	end.

% Return true if list contains data item
contains(Elem, L) ->
	if
		Elem == hd(L) -> true;
		Elem /= hd(L) -> contains(Elem, tl(L));
		true -> false
	end.

% Return power of x that equals y (i.e. return x, such that 3^x = 9)
logarithm(X,Y) ->
	if
		Y < X -> "Uh.....";
		Y == 1 -> 0;
		X == Y -> 1;
		true -> 1+logarithm(X, (Y div X))
	end.









