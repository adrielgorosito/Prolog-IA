% Ejercicio 7
inicio:- write('Ingresar lista: '),leer(L), contador(L,C), write(C).
leer([H|T]) :- read(H), H\=[], leer(T).
leer([]).

contador([],0).
contador([_|T], N) :- contador(T, N1), N is N1 + 1.