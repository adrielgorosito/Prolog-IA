% Ejercicio 8 
horoscopo(aries,21,3,20,4).
horoscopo(tauro,21,4,21,5).
horoscopo(geminis,22,5,21,6). 
horoscopo(cancer,22,6,22,7).
horoscopo(sagitario,23,11,21,12).

signo(Dia,Mes,Signo) :- horoscopo(Signo,DiaD,Mes,_,_), Dia >= DiaD.
signo(Dia,Mes,Signo) :- horoscopo(Signo,_,_,DiaH,Mes), Dia =< DiaH.