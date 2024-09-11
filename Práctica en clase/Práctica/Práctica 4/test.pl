inicio:- consultar, accion.
consultar:- consult("./db.txt").
accion:- mostrar_hijos(ticiana).


mostrar_hijos(Persona):- padres(Hijo, Persona, _), write("Hijo: "), writeln(Hijo), fail.
mostrar_hijos(_).

% Para ejecutar: swipl -s test.pl -g inicio -g halt