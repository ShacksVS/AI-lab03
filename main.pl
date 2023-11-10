% Facts (F)
likes(john, pizza).
likes(mary, pizza).
likes(viktor, chocolate).
likes(zhenia, shaurma).
likes(anna, ice_cream).
likes(peter, sushi).

hates(john, cola).
hates(mary, tomato).
hates(viktor, milkshake).
hates(zhenia, apple)
hates(anna, broccoli).
hates(peter, anchovies).

discount(john, shaurma).
discount(john, ice_cream).
discount(viktor, ice_cream).
discount(viktor, sushi).
discount(zhenia, broccoli).

% Rules (R)
friend(X, Y) :- likes(X, Z), likes(Y, Z), X \= Y.
suggest_alternative_food(X, DislikedFood, AlternativeFood) :- hates(X, DislikedFood), likes(X, AlternativeFood), \+(hates(X, AlternativeFood)).
eligible_for_discount(Person, Food) :- discount(Person, Food).

% Procedures (P)
recommend_food(X, Y) :- likes(Y, F), Y\=X, write(X), write(' recommends '), write(F), write(' to '), write(Y), nl.
suggest_alternative_food_for_hater(Person) :-
    hates(Person, DislikedFood),
    suggest_alternative_food(Person, DislikedFood, AlternativeFood),
    write('Suggestion for '), write(Person), write(' who hates '), write(DislikedFood),
    write(': You may like '), write(AlternativeFood), nl.

suggest_discounts(Person) :-
    write('Discounts available for '), write(Person), write(':'), nl,
    discount(Person, Food),
    write('- 50% off on '), write(Food), nl,
    fail.
suggest_discounts(_).

% Example query

?- recommend_food(john, mary).
?- suggest_alternative_food(john, cola, Suggest).
% Suggest = pizza
?- suggest_alternative_food(mary, tomato, pizza). 
% true
?- suggest_alternative_food_for_hater(Person)
?- eligible_for_discount(john, ice_cream).
?- suggest_discounts(john).
% To find all
?- findall(Person, eligible_for_discount(Person, ice_cream), PeopleList).