% Ejercicio 6
inicio:- write('Ingresar lista: '),leer(L), diferencia(L,D), write(D).
leer([H|T]) :- read(H), H\=[], leer(T).
leer([]).

diferencia([P|L],Diferencia):- ultimo(L,U), Diferencia is P - U.

ultimo([U|[]],U).
ultimo([_|T],U) :- ultimo(T,U).