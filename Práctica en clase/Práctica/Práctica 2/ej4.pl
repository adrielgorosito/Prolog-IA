% Ejercicio 4
inicio:-  write('Ingresar lista: '),leer([H|[H2|_]]), write(H),write(' '),write(H2).
leer([H|T]) :- read(H), H\=[], leer(T).
leer([]).

%inicio2:-write('Ingresar lista: '),leer([H,Y|_]), write(H),write(' '),write(Y).