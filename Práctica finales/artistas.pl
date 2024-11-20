:- dynamic(artista/3).
:- dynamic(cancion/4).
:- dynamic(usuario/4).
:- dynamic(listaReproduccion/4).

abrir_base :- retractall(artista/3), retractall(cancion/4), retractall(usuario/4), 
retractall(listaReproduccion/4), consult('db_artistas.txt').

% Menú
inicio :- abrir_base,
writeln('Ingrese una opcion'),
writeln('1- Artistas por año'),
writeln('2- Listas del usuario'),
read(Op), menu(Op),
inicio.

% Opción 1
menu(1) :- write('Ingrese un año: '),
read(Año),
artistas_por_año(Año, [], Lista_artistas),
write('Los artistas que lanzaron canciones en '), write(Año), write(' son: '),
writeln(Lista_artistas).

artistas_por_año(Año, Lista_temp, Lista_artistas) :-
cancion(_, Id_artista, Fecha, _),
retract(cancion(_, Id_artista, Fecha, _)),
sub_atom(Fecha, _, 4, 0, Año),
artista(Id_artista, Nombre, _),
not(pertenece(Nombre, Lista_temp)),
artistas_por_año(Año, [Nombre | Lista_temp], Lista_artistas).

artistas_por_año(_, Lista_artistas, Lista_artistas).

% Opción 2
menu(2) :- listas_usuarios.

listas_usuarios :- usuario(Id_usuario, Nombre, _, _),
retract(usuario(Id_usuario, Nombre, _, _)),
ver_listas(Id_usuario, Cant_listas, Cant_canciones), 
Prom_canciones is Cant_canciones / Cant_listas,
write(Nombre), write(' tiene '), write(Cant_listas), write(' listas y en promedio '),
write(Prom_canciones), writeln(' canciones por lista.'), 
listas_usuarios.

listas_usuarios.

ver_listas(Id_usuario, Cant_listas, Cant_canciones) :- 
listaReproduccion(_, Id_usuario, _, Lista_canciones),
retract(listaReproduccion(_, Id_usuario, _, Lista_canciones)),
ver_canciones(Lista_canciones, Cant_canciones_lista),
ver_listas(Id_usuario, Cant_listas_temp, Cant_canciones_temp),
Cant_listas is Cant_listas_temp + 1,
Cant_canciones is Cant_canciones_temp + Cant_canciones_lista.

ver_listas(_, 0, 0).

ver_canciones([_ | T], Cant_canciones) :- ver_canciones(T, Cant_canciones_temp),
Cant_canciones is Cant_canciones_temp + 1.

ver_canciones([], 0).


% Utils
pertenece(A, [A | _]).
pertenece(A, [_ | T]) :- pertenece(A, T).