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

stringlength(X, L) :- listlength(X,L).

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

/* ----------------------------------------------------------------------------------- */
/*                   																   */
/* ----------------------------------------------------------------------------------- */

/* 
* 6 - Revise grammar introduced in the lab so that the sentence, noun_phrase, and
	verb_phrase non-terminals are represented as:
* 	sentence -> noun_phrase verb_phrase
*	noun_phrase -> determinant noun | determinant adjective noun
* 	verb_phrase -> verb noun_phrase
* Add rules: ('a', 'the', 'smelly' are all non-terminals)
* 	determinant -> a | the
*	adjective -> smelly

* TODO: Do I need to test our the decompositions of words?
*/

/* Describe the terminals in the language */
word(a).
word(the).
word(smelly).

/* Describe valid decompositions - New Rules */
compose(adjective, [smelly]).
compose(determinant, [a]).
compose(determinant, [the]).

/* Rules implemented in place of original decompositions */
compose(sentence, [noun_phrase, verb_phrase]).
compose(noun_phrase, [determinant, noun]).
compose(noun_phrase, [determinant, adjective, noun]).
compose(verb_phrase, [verb, noun_phrase]).

/* ----------------------------------------------------------------------------------- */
/*                   																   */
/* ----------------------------------------------------------------------------------- */

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
* 1. insertSet - 3 params (atom, list, output list with atom inserted)
* Atom should be inserted only if it's not already in the set
*/
insertSet(A, [], [A]). /* Account for nothing in the list */
insertSet([], L, L). /* Account for atom being empty */
insertSet(A, [X | Y], [X | Z]) :- memberOfSet(A, [X | Y]), insertSet([], [X | Z], [X | Z]). /* If A is in the set then don't add */
insertSet(A, [X | Y], [X | Z]) :- not(memberOfSet(A, [X|Y])), insertSet(A, Y, Z). /* If A is not in the set, then insert at back */

/* 
* deleteSet - 3 params (atom, list, output list with atom deleted if in set
* TODO Try to remake functions using memberOfSet(A, B)
* FIXME Shouldn't have to make empty set case deleteSet(_, [], []) ? 
	Look at the rest of the problem sets that utilize this. 
*/
deleteSet(_, [], []). /* Account for empty list */ 
deleteSet(A, [A | Y], OL) :- deleteSet(A, Y, L), append([], L, OL).
deleteSet(A, [X | Y], OL) :- A \= X, deleteSet(A, Y, L), append([X], L, OL).


/* ----------------------------------------------------------------------------------- */
/*                   																   */
/* ----------------------------------------------------------------------------------- */


/* DONE
* 2. count - 3 params (atom, list, output) 
* output holds the number of times the atom passed as a parameter was found in the list
*/ 
count(_, [], 0). /* Take care of the empty list when the list has been shortened each time A is not the head or when A isn't present */
count(A, [A | Y], NUM) :- count(A, Y, TEMP), NUM is TEMP + 1. /* If A is the head of the list, increment NUM by 1, then search tail */
count(A, [X | Y], NUM) :- A \= X, count(A, Y, NUM). /* If A is not the head of the list, keep searching */

/* ----------------------------------------------------------------------------------- */
/*                   																   */
/* ----------------------------------------------------------------------------------- */

/* DONE
* 3. Two functions listSum & listSum2
* listSum - 2 params (list, output sum) : sums over the list
*/
listSum([], 0).
listSum([X | Y], L) :- listSum(Y, Z), L is X + Z.

/* listSum2 - 2 params (list, output sum) : sums over the list using accumulator approach */
/* sumAccumulator - 3 params (list, accumulator sum, output sum) */
listSum2(L, N) :- sumAccumulator(L, 0, N).
sumAccumulator([], A, A). /* For any empty list, A is set to 0 to start accumulation */
sumAccumulator([X | Y], A, B) :- Sum is X + A, sumAccumulator(Y, Sum, B).

/* ----------------------------------------------------------------------------------- */
/*                   																   */
/* ----------------------------------------------------------------------------------- */

/*
* 4. stringLessThan - 2 params (string1, string2)
* Compare two strings, return true if string1 appears before string2 in dictionary
*/
stringLessThan([], [_]). /* Doesn't matter what second string is, not null */
stringLessThan([X | _], [W | _]) :- X < W.
stringLessThan([X | Y], [W | Z]) :- X = W, stringLessThan(Y, Z).

/* ----------------------------------------------------------------------------------- */
/*                   																   */
/* ----------------------------------------------------------------------------------- */

/* DONE
* 5. strcat - Generates a single string which is concatenation of a given set of strings
* ex. ["Hey", "You", "Guys"] -> HeyYouGuys
* Use recursion, test: ?-(strcat(["Hey","You","Guys"],A), printString(A).)
*/
strcat([], []). /* Empty strings */
strcat([X | Y], A) :- strcat(Y, L), append(X, L, A). 





