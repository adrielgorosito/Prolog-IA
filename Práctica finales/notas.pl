% comision(nro, carrera, turno, [legajos], [notas]) 
/* (los legajos y notas van en pila, el primero con el primero y así sucesivamente)
1- Ingresar nro comision y lista de legajos y crear dos listas: una para los inscriptos en esa comisión y otra para los que no
2- Ingresar nro comisión y mostrar el porcentaje de alumnos aprobados (>=6) en esa comisión */

:- dynamic(comision/5).

abrir_base :- retractall(dynamic(comision/5)),
consult("db_notas.txt").

% Menú
inicio :- abrir_base, 
writeln("Ingrese una opción:"), 
writeln("1 - Inscriptos por comisión"),
writeln("2 - Porcentaje aprobados por comisión"),
read(Op), menu(Op), inicio.

% Opción 1
menu(1) :- writeln("Ingrese la comisión"),
read(Com),
writeln("Ingrese la lista de legajos"),
leer(Lista_legajos),
pertenece_comision(Com, Lista_legajos, Lista_inscriptos, Lista_no_inscriptos),
write("Inscriptos: "), writeln(Lista_inscriptos), write("No inscriptos: "), writeln(Lista_no_inscriptos).

pertenece_comision(Com, [L | T], [L | Lista_inscriptos], Lista_no_inscriptos) :-
comision(Com, _, _, Lista_legajos, _),
pertenece(L, Lista_legajos),
pertenece_comision(Com, T, Lista_inscriptos, Lista_no_inscriptos).

pertenece_comision(Com, [L | T], Lista_inscriptos, [L | Lista_no_inscriptos]) :-
comision(Com, _, _, Lista_legajos, _),
not(pertenece(L, Lista_legajos)),
pertenece_comision(Com, T, Lista_inscriptos, Lista_no_inscriptos).

pertenece_comision(_, [], [], []).

% Opción 2
menu(2) :-writeln("Ingrese la comisión"),
read(Com),
comision(Com, _, _, _, Notas),
contar_total(Notas, Cant_total),
contar_aprobados(Notas, Cant_aprobados),
Porcentaje is (Cant_aprobados / Cant_total) * 100,
write("Cantidad alumnos en la comisión: "), writeln(Cant_total),
write("Porcentaje alumnos aprobados: "), write(Porcentaje), writeln(" %").

contar_aprobados([N | T], Cant_aprobados) :-
N >= 6,
contar_aprobados(T, Cant_aprobados_temp),
Cant_aprobados is Cant_aprobados_temp + 1.

contar_aprobados([_ | T], Cant_aprobados) :- contar_aprobados(T, Cant_aprobados).

contar_aprobados([], 0).

contar_total([_ | T], Cant_total) :-
contar_total(T, Cant_total_temp),
Cant_total is Cant_total_temp + 1.

contar_total([], 0).

% Utils
pertenece(X, [X | _]).
pertenece(X, [_ | T]) :- pertenece(X, T).

leer([L | T]) :- read(L), L \= [], leer(T).
leer([]).