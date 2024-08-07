% Ejercicio 10
inicio10():-
    write('Ingrese una lista de elemento: '),leer(Lista),
    write('Ingresar elemento a evaluar: '),
    read(Elemento),
    estaEnLista(Lista,Elemento).

estaEnLista([],_):-write('No esta en la lista').
estaEnLista([H|_],H):-write('Si esta').
estaEnLista([_|T],Elemento):- estaEnLista(T,Elemento).
