% Ejercicio 12
inicio :- read(N), suma(N, Sum), write(Sum).
suma(0, 0).
suma(N, Sum) :- N2 is N-1, suma(N2, S), Sum is S+N.