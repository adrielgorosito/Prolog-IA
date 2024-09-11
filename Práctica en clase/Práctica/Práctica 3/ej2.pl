% Ejercicio 2
% Ingresar una cadena de texto y obtener el último carácter de la misma.

% Hay dos formas:
atom_length(“Facultad”, L), sub_atom(“Facultad”, L-1, 1, _, X)
sub_atom(“Facultad”, _, 1, 1, X)

% --------------------------------------------------------------------
% La función sub_atom se puede usar para cumplir dos objetivos:
% 1. Ver si existe la subcadena (devuelve true o false):
sub_atom(“”Atahualpa”, _, _, _, “hua”)
% Devuelve "True"

% 2. En qué posición está la subcadena:
sub_atom(“Atahualpa”, X, _, _, “hua”)
% Devuelve "3"