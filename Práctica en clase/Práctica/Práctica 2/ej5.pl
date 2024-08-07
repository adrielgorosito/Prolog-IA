% Ejercicio 5
inicio:- write('Ingresar lista: '),leer(U), ultimo(U).
leer([H|T]) :- read(H), H\=[], leer(T).
leer([]).

ultimo([U]) :- write(U).
ultimo([_|T]) :- ultimo(T).

inicio2:- write('Ingresar lista: '),leer2(U), ultimo2(U,L),write(L).
leer2([H|T]) :- read(H), H\=[], leer(T).
leer2([]).

ultimo2([U|[]],U).
ultimo2([_|T],U) :- ultimo2(T,U).