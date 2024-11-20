:- dynamic(paciente/3).
:- dynamic(profesional/4).
:- dynamic(turno/6).

abrir_base :- retractall(paciente/3),
retractall(profesional/3),
retractall(turnos/6),
consult("db_pacientes.txt").

% Menú
inicio :- abrir_base,
writeln("Ingrese una opción:"),
writeln("1 - Especialidades por paciente y año"),
writeln("2 - Profesionales con turnos cuyo monto es mayor a 1500"),
read(Op), menu(Op), inicio.

% Opción 1
menu(1) :- writeln("Ingrese nombre de paciente"),
read(Nombre),
writeln("Ingrese el año"),
read(Año),
especialidades_cliente(Nombre, Año, [], Lista_especialidades),
writeln("Especialidades: "),
write(Lista_especialidades).

especialidades_cliente(Nombre, Año, Ltemp, Lista_especialidades) :-
paciente(Dni, Nombre, _),
turno(Dni, _, Especialidad, Fecha, _, _),
retract(turno(Dni, _, Especialidad, Fecha, _, _)),
sub_atom(Fecha, 0, 4, _, Año),
not(pertenece(Especialidad, Ltemp)),
especialidades_cliente(Nombre, Año, [Especialidad|Ltemp], Lista_especialidades).

especialidades_cliente(_, _, Lista_especialidades, Lista_especialidades).

% Opción 2
menu(2) :- recorrer_profesionales.

recorrer_profesionales:- 
profesional(Dni, Nombre, _, _),
retract(profesional(Dni, Nombre, _, _)),
turnos_por_profesional(Dni, Sum_turnos),
write("El profesional "), write(Nombre),write(" tiene "), write(Sum_turnos),
writeln(" turnos cuyo monto son mayores a 1500"),
recorrer_profesionales.

recorrer_profesionales.

turnos_por_profesional(Dni, Sum_turnos) :-
turno(_, Dni, _, _, _, Monto),
retract(turno(_, Dni, _, _, _, Monto)),
Monto > 1500,
turnos_por_profesional(Dni, Sum_temp),
Sum_turnos is Sum_temp + 1.

turnos_por_profesional(_, 0).


% Utils
pertenece(X, [X | _]).
pertenece(X, [_ | T]) :- pertenece(X, T).