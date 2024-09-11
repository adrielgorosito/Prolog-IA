% Ejercicio 3
% Ingresar una cadena de texto e informar cuántos caracteres tiene. 
% En primer lugar haciendo uso del predicado atom_length/2 y en una segunda instancia utilizando sub_atom/5 de forma recursiva.


% Con atom_length
atom_length(“Facultad”, X)

% Con sub_atom/5 de forma recursiva
% Regla para obtener el primer carácter de una cadena de texto
primer_caracter(X) :- sub_atom('Facultad', 0, 1, _, X).

% Primer forma: abrimos la cadena y luego contamos
contar_letras('', 0).
contar_letras(Cadena, Cont) :- 
sub_atom(Cadena, 1, _, 0, Subcadena), contar_letras(Subcadena, Cont2), Cont is Cont2 + 1.

% Para ejecutar: contar_letras('Facultad', X)


% Segunda forma: vamos abriendo la cadena y a la vez contando
contar_letras_2('', Cont, Cont).
contar_letras_2(Cadena, Cont, Cont2) :- sub_atom(Cadena, 1, _, 0, Subcadena), Cont1 is Cont + 1, contar_letras_2(Subcadena, Cont1, Cont2).

% Para ejecutar: contar_letras_2('Facultad', 0, X)