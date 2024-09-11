consultar:- consult("./db.txt").

mostrar_servicios:- pagar(Persona, Servicio, _), write("Persona: " ), write(Persona), write(" - Servicio: "), writeln(Servicio), fail.
mostrar_servicios.

mostrar_montos(Persona) :- pagar(Persona, Servicio, Monto), write("Servicio: "), write(Servicio), write(" - Monto: "), writeln(Monto), fail.
mostrar_montos(_).

inicio :- consultar, writeln('Ingrese la opción:'), writeln('1 - Listar servicios por persona'), writeln('2 - Listar montos de una persona'), read(Op), opera(Op).
opera(1) :- mostrar_servicios.
opera(2) :- writeln("Ingrese el nombre de la persona:"), read(Persona), mostrar_montos(Persona).
opera(_) :- writeln('Error').