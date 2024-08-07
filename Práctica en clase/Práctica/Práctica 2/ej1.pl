% Ejercicio 1
inicio:- write('Ingresar lista: '),leer(L), write(L).
leer([H|T]) :- read(H), H\=[], leer(T).
leer([]).