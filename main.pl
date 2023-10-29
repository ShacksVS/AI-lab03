% Факти
male(harry).
female(liz).
male(phil).
female(chas).
male(chas).
male(wills).
parent(phil, harry).
parent(liz, harry).
parent(phil, wills).
parent(liz, wills).
parent(chas, phil).
parent(chas, liz).

grandmother(GM, C):-  
    mother(GM, P),  
    parent(P, C).

mother(M,C):-  
    female(M),  
    parent(M, C).

father(F, C):-  
    male(F),  
    parent(F, C).

grandfather(GF, C):-  
    father(GF, P),  
    parent(P, C).

son(S, P):-  
    male(S),  
    parent(P, S).

daughter(D, P):-  
    female(D),  
    parent(P, D).

greatgrandfather(GGF, C):-  
    father(GGF, GF),  
    father(GF, P),  
    parent(P, C).

greatgrandmother(GGM, C):-  
    mother(GGM, GM),  
    mother(GM, P),  
    parent(P, C).

% Check if "liz" is a mother
?- mother(liz, Child).

% Find the sons of "chas"
?- son(Son, chas).

% Determine who the great-grandmothers of "harry" are
?- greatgrandmother(GGM, harry).

% Check if "harry" is a grandfather
?- grandfather(harry, Child).
