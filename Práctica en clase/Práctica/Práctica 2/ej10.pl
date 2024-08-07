% Ejercicio 10
inicio :- write('Ingresar lista: '), leer(L),write('Ingresar num: '),read(Num), esta(L,Num).

leer([H|T]) :- read(H), H \= [], leer(T).
leer([]).


esta([H|_],H).
esta([_|T],N) :- esta(T,N).