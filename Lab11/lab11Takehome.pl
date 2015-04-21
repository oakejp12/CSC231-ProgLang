/* Queue Code */
/* ----------- */

/* A queue is empty if it is an empty list */
queueEmpty([]).

/* Adding an item to the queue adds the Item to the back of the list */
queueAdd(Queue,Item,NewQueue) :- append(Queue,[Item],NewQueue).

/* Removing an item from the queue grabs the head component and marks the output queue as the tail */
/* of the original queue */
queueRemove([FrontQueue|RestQueue],FrontQueue,RestQueue).

/* Peeking into the queue gives you the head of the queue */
queuePeek([FrontQueue|_],FrontQueue).

/* An auxillary function to put an item onto the front of a list -- useful for Stack? */
prependItem(List, Item, NewList) :- append([Item],List,NewList).



/* Selection Sort Code */
/* The largest of a one item list is that one item */
largest([H],H).

/* Compare the first two items of a list and drop the smaller, the largest of the remaining is the largest*/
largest([H|[X|Y]],S) :- H >= X, largest([H|Y],S).

/* Compare the first two items of a list and drop the smaller, the largest of the remaining is the largest*/
largest([H|[X|Y]],S) :- H < X, largest([X|Y],S).

/* Removing an item from an empty list gives you an empty list */
remove(_,[],[]).

/* Removing an item from the head gives you the tail */
remove(H,[H|T],T).

/* Removing an item that isn't the head of the list results in the head prepended with the tail, where the tail */
/* has had the item removed. */
remove(S,[H|T],Result) :- S \= H, remove(S,T,TempResult), append([H],TempResult,Result).

/* Sorting an empty list returns an empty list */
selectionSort([],[]).

/* Sorting a list with at least one item involves: finding the largest item, removing it from the list, sorting */
/* the rest of the list recursively, and then sticking the largest item on the front of the sorted_rest */
selectionSort([H|Tail],Result) :- largest([H|Tail],RealLargest), remove(RealLargest,[H|Tail], UpdatedTail), selectionSort(UpdatedTail,TempResult),append([RealLargest],TempResult,Result).




/* Examples of the Cut Operator */
sum_to(1,1) :- !.
sum_to(X,Y) :- X1 is X-1,sum_to(X1,Y1), Y is Y1 + X.


/* code for you to update with the Cut Operator and to trace */
insertSet(H,[],[H]).
insertSet(H,[H|T],[H|T]).
insertSet(X,[H|T],Z) :- X \= H, insertSet(X,T,C), append([H],C,Z).

count(_,[],0).
count(X,[X|T],Z) :- count(X,T,C), Z is 1+C.
count(X,[H|T],Z) :- X \= H, count(X,T,Z).


/* ----------------------------------- */
/* Author : Johan Oakes */
/* Date: 4/21/15 */
/* CSC 231 Lab 11 - Prolog */
/* ----------------------------------- */


/* 1. Stack implementation. */

/* Return true if stack is empty */
stackempty([]).

/* Push an element to the top of the stack */
stackpush(Stack, Item, NewStack) :- append([Item], Stack, NewStack).

/* Pop removes the last element added to the stack, which is at the front */
stackpop([FrontStack | RestStack], FrontStack, RestStack).

/* Show item currently in front */
stackpeep([FrontStack | _], FrontStack).

/* ----------------------------------- */

/* postfix - Two parameters : list holding postfix expression, result value */
postfix([], Z) :- Z is 0.
postfix(L,Z):- worker(L,[],Z).
worker([],A,B):- stackpop(A,B,_). 
worker([H|T],A,B):- H = '+', stackpop(A,Y,Z), stackpop(Z,O,P), E is O + Y, stackpush(P,E,I), worker(T,I,B).
worker([H|T],A,B):- H = '-', stackpop(A,Y,Z), stackpop(Z,O,P), E is O - Y, stackpush(P,E,I), worker(T,I,B).
worker([H|T],A,B):- H = '/', stackpop(A,Y,Z), stackpop(Z,O,P), E is O / Y, stackpush(P,E,I), worker(T,I,B).
worker([H|T],A,B):- H = '*', stackpop(A,Y,Z), stackpop(Z,O,P), E is O * Y, stackpush(P,E,I), worker(T,I,B).
worker([H|T],A,B):- stackpush(A,H,I), worker(T,I,R), B is R.







