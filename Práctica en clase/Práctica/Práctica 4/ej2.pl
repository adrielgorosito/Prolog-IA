consultar:- consult("./db.txt").
inicio :- consultar, writeln('Ingrese el código:'), read(Codigo), mostrar(Codigo).

mostrar(Codigo) :- personas(Codigo, Nombre), writeln(Nombre).
mostrar(Codigo) :- writeln("La persona no existe. Ingresar nombre: "), read(Persona), assert(personas(Codigo, Persona)), writeln('Persona agregada').

% Para ejecutar: swipl -s ej2.pl -g inicio (sin el -t halt, para quedar en memoria). Luego, llamar a mostrar con el código nuevo para que muestre la persona agregada.