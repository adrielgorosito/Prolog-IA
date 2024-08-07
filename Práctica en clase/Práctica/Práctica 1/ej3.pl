% Ejercicio 3
grupo(brasil, 1).
grupo(españa, 1).
grupo(jamaica, 1).
grupo(italia, 1).
grupo(argentina, 2).
grupo(nigeria, 2).
grupo(holanda, 2).
grupo(escocia, 2).


son_rivales(X,Y) :- grupo(X, G), grupo(Y, G), X \= Y.