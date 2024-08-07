% Ejercicio 4
% Dados los siguientes predicados:
%   hombre(unHombre).
%   mujer(unaMujer).
%   padres(persona, madre, padre).
% a. Construya una base de hechos con los miembros de su familia.
% b. Defina las siguientes reglas:
%   • hermana/2, donde hermana(A,B) significa que A es hermana de B.
%   • nieto/2, donde nieto(A,B) significa que A es el nieto de B.
%   • abuelo/2, donde abuelo(A,B) significa que A es el abuelo de B.
%   • tia/2, donde tia(A,B) significa que A es la tía de B. Esta regla
%   definirla, en una primera instancia, valiéndose sólo de los hechos
%   disponibles. En una segunda instancia, valiéndose de alguna otra
%   regla que pudieron haber definido previamente. 
hombre(humberto).
hombre(rafael).
hombre(gregorio).
hombre(juan).
hombre(benito).
mujer(elba).
mujer(estela).

padres(juan, elba, humberto).
padres(rafael, elba, humberto).
padres(gregorio, elba, humberto).
padres(elba, maria, benito).
padres(estela, maria, benito).

hermana(A,B) :- A \= B, mujer(A), padres(A, X, Y), padres(B, X, Y).

% Mala práctica: uso de la disyunción ';'
% nieto(A,B) :- hombre(A), padres(A, X, Y), (padres(X, B, _); padres(X, _, B) ; padres(Y, B, _); padres(Y, _ , B)).

% Buena práctica: uso de varias cláusulas
nieto(A,B) :- hombre(A), padres(A, X, _), padres(X, B, _).
nieto(A,B) :- hombre(A), padres(A, X, _), padres(X, _, B).
nieto(A,B) :- hombre(A), padres(A, _, Y), padres(Y, B, _).
nieto(A,B) :- hombre(A), padres(A, _, Y), padres(Y, B, _).

abuelo(A,B) :- hombre(A), padres(B, X, Y), ( padres(X, A, _); padres(X, _, A); padres(Y, A, _); padres(Y, _, A)).

tia(X,Y) :- mujer(X), padres(Y, Madre, _), X \= Madre, padres(Madre, Abuela, Abuelo), padres(X, Abuela, Abuelo).
tia(X,Y) :- mujer(X), padres(Y, Madre, Padre), X \= Madre, padres(Padre, Abuela, Abuelo), padres(X, Abuela, Abuelo).
