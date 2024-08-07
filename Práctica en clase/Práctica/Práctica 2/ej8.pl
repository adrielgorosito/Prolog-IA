% Ejercicio 8
inicio:- write('Ingresar lista: '),leer(L), sumar(L,C), write(C).
leer([H|T]) :- read(H), H\=[], leer(T).
leer([]).

sumar([], 0).
sumar([H|T], Suma) :- sumar(T, S2), Suma is H + S2.