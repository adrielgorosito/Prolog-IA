% Ejercicio 8 
% Definir una regla del estilo signo(Dia, Mes, Signo) que permita:
% a. Ingresar un signo, día y mes y me informe si es correcto ese signo para esa fecha.
% Ejemplo:
%   ?-signo(3,5,tauro).
%   ?-signo(23,4,aries).
% b. Ingresar una fecha (día y mes) y me informe de qué signo soy.
% Ejemplo:
%   ?-signo(16,12,Signo).
%   ?-signo(7,4,Signo). 
horoscopo(aries,21,3,20,4).
horoscopo(tauro,21,4,21,5).
horoscopo(geminis,22,5,21,6). 
horoscopo(cancer,22,6,22,7).
horoscopo(sagitario,23,11,21,12).

signo(Dia,Mes,Signo) :- horoscopo(Signo,DiaD,Mes,_,_), Dia >= DiaD.
signo(Dia,Mes,Signo) :- horoscopo(Signo,_,_,DiaH,Mes), Dia =< DiaH.
