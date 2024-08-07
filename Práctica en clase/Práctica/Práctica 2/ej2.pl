% Ejercicio 2
inicio:- write('Ingresar lista: '),leer([H|T]), write(H), write(T).
leer([H|T]) :- read(H), H\=[], leer(T).
leer([]).