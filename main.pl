/* MALE CHARACTERS */

male(john_smith).
male(robert_smith).
male(michael_smith).
male(william_smith).
male(david_smith).
male(charles_johnson).
male(george_williams).
male(thomas_williams).
male(brian_davis).
male(steven_davis).
male(nathan_davis).
male(christopher_brown).
male(ryan_brown).
male(kevin_taylor).

female(jane_smith).
female(emily_smith).
female(olivia_smith).
female(ava_smith).
female(sophia_smith).
female(emma_johnson).
female(isabella_williams).
female(amelia_williams).
female(chloe_davis).
female(abigail_davis).
female(evelyn_davis).
female(ella_brown).
female(aria_brown).
female(mia_taylor).

parent(john_smith, emily_smith).
parent(john_smith, ava_smith).
parent(jane_smith, emily_smith).
parent(jane_smith, ava_smith).
parent(robert_smith, michael_smith).
parent(robert_smith, olivia_smith).
parent(michael_smith, william_smith).
parent(michael_smith, david_smith).
parent(charles_johnson, john_smith).
parent(charles_johnson, emma_johnson).
parent(george_williams, thomas_williams).
parent(george_williams, amelia_williams).
parent(steven_davis, nathan_davis).
parent(steven_davis, evelyn_davis).
parent(sophia_smith, jane_smith).
parent(sophia_smith, michael_smith).
parent(ava_smith, david_smith).
parent(ava_smith, william_smith).
parent(emma_johnson, amelia_williams).
parent(emma_johnson, thomas_williams).
parent(brian_davis, chloe_davis).
parent(brian_davis, nathan_davis).
parent(chloe_davis, chloe_davis).
parent(chloe_davis, nathan_davis).
parent(kevin_taylor, chloe_davis).
parent(evelyn_davis, chloe_davis).
parent(evelyn_davis, ella_brown).
parent(nathan_davis, ella_brown).
parent(nathan_davis, aria_brown).
parent(ryan_brown, ella_brown).
parent(ryan_brown, aria_brown).



/* ----PROCEDURES---- */

child(X, Y) :- parent(Y, X).

daughter(X, Y) :- 
  child(X, Y),
  female(X).

son(X, Y) :-
  child(X, Y),
  male(X).

children(X, Children) :-
  setof(Y, parent(X, Y), Children).


mother(X, Y) :- 
  parent(X,Y), 
  female(X).

father(X, Y) :- 
  parent(X,Y), 
  male(X).

sister(X, Y) :- 
  siblings(X,Y), 
  female(X).

brother(X, Y) :- 
  siblings(X, Y), 
  male(X).

aunt(X, Y) :- 
  parent(Z, Y), 
  sister(X, Z).

uncle(X, Y) :- 
  parent(Z, Y), 
  brother(X, Z).

niece(X, Y) :-
  parent(Z, X),
  siblings(Z, Y),
  female(X).

nephew(X, Y) :-
  parent(Z, X),
  siblings(Z, Y),
  male(X).

grandfather(X,Y) :-
  parent(Z, Y),
  father(X, Z).

grandmother(X,Y) :-
  parent(Z, Y),
  mother(X, Z).

cousin(X, Y) :-
  parent(Z, X),
  siblings(Z, S),
  parent(S, Y),
  dif(X,Y).

cousins(X, Cousins) :-
  setof(Y, cousin(X, Y), Cousins).


 sibling(X, Y) :-
  parent(Z, X),
  parent(Z, Y),
  dif(X, Y).

list_siblings(X, Siblings) :-
  setof(Y, sibling(X, Y), Siblings);
  Siblings = none.

siblings(X,Y) :-
  list_siblings(X, Siblings),
  member(Y, Siblings).

siblings(sandor_clegane, gregor_clegane).


parents(X, Parents) :-
	setof(Y, parent(Y, X), Parents),
	!.

parents(X, Parents) :-
	not(setof(Y, parent(Y, X), Parents)),		
	Parents = unknown.	


niece_and_nephews(X, NieceAndNephews) :-
  setof(AU, (aunt(X, AU); uncle(X, AU)), NieceAndNephews),
  !.

niece_and_nephews(_, NieceAndNephews) :-
  NieceAndNephews = none.

aunts_and_uncles(X, AuntsAndUncles) :-
  setof(NN, (niece(X, NN); nephew(X, NN)), AuntsAndUncles),
  !.
  
aunts_and_uncles(_, AuntsAndUncles) :-
  AuntsAndUncles = none.
  
grandparent(X, Grandparent) :-
  parent(Parent, X), 
  parent(Grandparent, Parent). 

grandparents(X, Grandparents) :-
  setof(G, grandparent(X, G), Grandparents),
  !.

grandparents(_, Grandparents) :-
  Grandparents = none.


descendant(X, Y) :- 
   parent(X, Y).

descendant(X, Y) :-
    parent(X, Z),    descendant(Z, Y).

descendants(X, Descendant_of) :- 
  findall(A, descendant(X, A), 
  Descendant_of).
