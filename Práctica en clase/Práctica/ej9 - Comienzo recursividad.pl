% Ejercicio 9
% Donde hijo(X,Y) indica que X es hijo de Y.
% Definir la regla descendiente(A,B), la cual permite determinar si A es descendiente de B.
hijo(juan,miguel).
hijo(jose,miguel).
hijo(miguel,roberto).
hijo(julio,roberto).
hijo(roberto,carlos). 

descendiente(X, Y) :- hijo(X, Y).
descendiente(X, Y) :- hijo(X, Z), descendiente(Z, Y).
