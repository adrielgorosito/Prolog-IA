:- dynamic(heladeria/3).
:- dynamic(locales/3).

abrir_base :- 
retractall(heladeria/3),
retractall(locales/3),
consult('db_heladerias.txt').

% Menú
inicio :- abrir_base,
writeln("Ingrese una opción:"),
writeln("1 - Heladerías del centro"),
writeln("2 - Heladerías por calle"),
read(Op), menu(Op), inicio.

% Opción 1
menu(1) :- writeln("Ingrese una lista de heladerías"),
leer(Lista_heladerias),
esta_en_el_centro(Lista_heladerias, Lista_centro),
writeln(Lista_centro).

esta_en_el_centro([H | T], [H | Lista_centro]) :-
heladeria(Codigo, H, _),
retract(heladeria(Codigo, H, _)),
locales(Codigo, Zona, _),
retract(locales(Codigo, Zona, _)),
Zona = 'centro',
esta_en_el_centro(T, Lista_centro).

esta_en_el_centro([_ | T], Lista_centro) :- esta_en_el_centro(T, Lista_centro).

esta_en_el_centro([], []).

% Opción 2
menu(2) :- writeln("Ingrese una calle"),
read(Calle),
heladerias_por_calle(Calle, [], Lista_heladerias),
writeln(Lista_heladerias).


heladerias_por_calle(Calle, Lista_temp, Lista_heladerias) :-
locales(Codigo, _, Lista_direcciones),
writeln('>>> Lei direcciones'),
retract(locales(Codigo, _, Lista_direcciones)),
pertenece(Calle, Lista_direcciones),
writeln('>>> vi el pertenece'),
retractall(locales(Codigo, _, _)),
heladeria(Codigo, Nombre, _),
retract(heladeria(Codigo, Nombre, _)),
writeln('>>> estoy por llamarme de vuelta'),
heladerias_por_calle(Calle, [Nombre | Lista_temp], Lista_heladerias).

heladerias_por_calle(_, Lista_heladerias, Lista_heladerias).

% Utils
leer([H | T]) :- read(H), H \= [], leer(T).
leer([]).

pertenece(X, [D | _]) :- sub_atom(D, _, _, _, X).
pertenece(X, [_ | T]) :- pertenece(X, T).