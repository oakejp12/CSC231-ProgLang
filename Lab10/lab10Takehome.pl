/* Lab 10 
* Author : Johan Oakes
* Author : Dr. Turkett
* Date: 4/12/2015
*/

memberOfSet(X,[X|_]).
memberOfSet(X,[_|Y]) :- memberOfSet(X,Y).

notInList(X,Y) :- not(memberOfSet(X,Y)).

listlength([],0).
listlength([_|Y],L) :- listlength(Y,Z), L is 1+Z.

stringlength(X,L) :- listlength(X,L).

listlength2(L,N) :- lengthAccumulator(L,0,N).
lengthAccumulator([],A,A).
lengthAccumulator([_|T],A,B) :- LargerSize is A+1, lengthAccumulator(T,LargerSize,B).

stringEquals(X,Y) :- intEquals(X,Y).
intEquals([],[]).
intEquals([H|T],[X|Y]) :- H=X, intEquals(T,Y).

word(john).
word(likes).
word(hates).
word(mary).
word(wine).

compose(noun, [john]).
compose(noun, [mary]).
compose(noun, [wine]).
compose(verb, [likes]).
compose(verb, [hates]).
compose(verb_phrase, [verb, noun]).
compose(sentence, [noun, verb_phrase]).

build(X,[X]) :- word(X).
build(X,P) :- compose(X, Subtype), buildlist(Subtype,P).

/* if have a list to decompose, decompose first, decompose list of rest */
/* then append results (2nd statement) */
/* if you run out of things to build, give back the empty list */
buildlist([],[]).
buildlist([H|T],Result) :- build(H,HeadComposition), buildlist(T,TailComposition), append(HeadComposition, TailComposition, Result).

deriveASentence(X) :- build(sentence,X).

printString(A) :- writef("%s", [A]).

/* START YOUR SOLUTIONS HERE */

/* 
* 1. insertSet - 3 parameters (atom, list, output list with atom inserted)
* Atom should be inserted only if it's not already in the set
*/
insertSet(A, [], [A]). /* Account for nothing in the list */
insertSet([], L, L). /* Account for atom being empty */
insertSet(A, [X | Y], [X | Z]) :- memberOfSet(A, [X | Y]), insertSet([], [X | Z], [X | Z]). /* If A is in the set then don't add */
insertSet(A, [X | Y], [X | Z]) :- not(memberOfSet(A, [X|Y])), insertSet(A, Y, Z). /* If A is not in the set, then insert at back */

/* 
* deleteSet - 3 parameters (atom, list, output list with atom deleted if in set
* TODO: Try to remake functions using memberOfSet()
*
*/
deleteSet(A, [], []).
deleteSet(A, [A | Y], OL) :- deleteSet(A, Y, L), append([], L, OL).
deleteSet(A, [X | Y], OL) :- A \= X, deleteSet(A, Y, L), append([X], L, OL).














