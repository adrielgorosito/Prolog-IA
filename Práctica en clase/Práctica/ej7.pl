% Ejercicio 7
% Escribir un programa que simule una calculadora para las operaciones
% matemáticas básicas (suma, resta, multiplicación y división) entre dos
% valores numéricos, informando el resultado. 
inicio :- writeln('Ingrese la opción:'), writeln('1 - Suma'), writeln('2 - Resta'), writeln('3 - Multiplicación'), write('4 - División'), read(Op), opera(Op).
opera(1) :- writeln('Primer valor:'), read(N1), writeln('Segundo valor:'), read(N2), R is N1+N2, write('Resultado: '), write(R).
opera(2) :- writeln('Primer valor:'), read(N1), writeln('Segundo valor:'), read(N2), R is N1-N2, write('Resultado: '), write(R).
opera(3) :- writeln('Primer valor:'), read(N1), writeln('Segundo valor:'), read(N2), R is N1*N2, write('Resultado: '), write(R).
opera(4) :- writeln('Primer valor:'), read(N1), writeln('Segundo valor:'), read(N2), R is N1/N2, write('Resultado: '), write(R).
opera(_) :- writeln('Error').
