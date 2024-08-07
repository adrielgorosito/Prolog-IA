% Ejercicio 3
inicio:- write('Ingresar lista: '),leer([H|_]), write(H).
leer([H|T]) :- read(H), H\=[], leer(T).
leer([]).