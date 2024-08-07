% Ejercicio 9
inicio :- write('Ingresar lista: '), leer(L),promedio(L, S, C), C\=0,Promedio is S / C, write(Promedio).

leer([H|T]) :- read(H), H \= [], leer(T).
leer([]).

promedio([], 0, 0).

promedio([H|T], S, C) :-promedio(T, ST, CT), S is H + ST, C is CT + 1.