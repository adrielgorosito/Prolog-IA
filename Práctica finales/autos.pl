% persona(dni,nombre,edad).
% auto_vendido(patente,codModelo,fecha,precio,[DNItitulares]).
% auto(codModelo,modelo).

% 1) ingresar dni de una persona y mostrar todos los autos de los que es titular.
% 2) ingresar el codigo de un auto y calcular el precio promedio de autos vendidos.
% 3) mostrar el titular mas joven de cada auto vendido.

--------------------------------------------------------------------------------------

:-dynamic(persona/3).
:-dynamic(auto_vendido/5).
:-dynamic(auto/2).

abrir_base:- retractall(persona/3),
retractall(auto_vendido/5),
retractall(auto/2),
consult("db_autos.txt").


% Menú
inicio :- abrir_base,
writeln("Ingrese una opción:"),
writeln("1. Titularidad de autos por dni"),
writeln("2. Precio promedio de autos vendidos por código de auto"),
writeln("3. Titular más joven de cada auto vendido"),
read(Op), menu(Op), inicio.


% Opción 1
menu(1):- writeln("Ingrese el dni"),
read(Dni),
buscar_autos_por_dni(Dni, Lista_autos),
writeln("Es titular de:"), write(Lista_autos).

buscar_autos_por_dni(Dni, [H | T]):-
auto_vendido(_, Cod_modelo, _, _, Dni_titulares),
retract(auto_vendido(_, Cod_modelo, _, _, Dni_titulares)),
pertenece(Dni, Dni_titulares),
auto(Cod_modelo, H),
retract(auto(Cod_modelo, H)),
buscar_autos_por_dni(Dni, T).

buscar_autos_por_dni(_, []).


% Opción 2
menu(2):- writeln("Ingrese el código del auto"),
read(Cod),
obtener_cant_sum_autos_vendidos(Cod, Cant, Sum),
mostrar_promedio(Cant, Sum).


obtener_cant_sum_autos_vendidos(Cod, Cant, Sum):-
auto_vendido(_, Cod, _, Precio, _),
retract(auto_vendido(_, Cod, _, Precio, _)),
obtener_cant_sum_autos_vendidos(Cod, Cant2, Sum2),
Cant is Cant2 + 1,
Sum is Sum2 + Precio.

obtener_cant_sum_autos_vendidos(_, 0, 0).


mostrar_promedio(Cant, Sum):-
Prom is Sum / Cant,
writeln("El promedio de precios es de:"),
write(Prom).

mostrar_promedios(0, _):- writeln("No hay autos con dicho código").


% Opción 3
menu(3):- mostrar_mas_joven_por_auto.

mostrar_mas_joven_por_auto:- auto_vendido(Patente, _, _, _, Dni_titulares),
retract(auto_vendido(Patente, _, _, _, Dni_titulares)),
buscar_mas_joven(Dni_titulares, Nombre),
write("El menor de "), write(Patente), write(" es "), write(Nombre),
mostrar_mas_joven_por_auto.

mostrar_mas_joven_por_auto.

buscar_mas_joven([Dni], Nombre):- persona(Dni, Nombre, _).

buscar_mas_joven([Dni1, Dni2 | T], Nombre):-
persona(Dni1, _, Edad1),
persona(Dni2, _, Edad2),
Edad1 < Edad2,
buscar_mas_joven([Dni1 | T], Nombre).

buscar_mas_joven([Dni1, Dni2 | T], Nombre):-
persona(Dni1, _, Edad1),
persona(Dni2, _, Edad2),
Edad1 > Edad2,
buscar_mas_joven([Dni2 | T], Nombre).


% Utils
pertenece(H, [H|_]).
pertenece(H, [_|T]):- pertenece(H, T).