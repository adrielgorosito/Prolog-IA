% Ejercicio 13
suma(0,0,0).
suma(N,SumPares,SumImpares) :- 0 is N mod 2, N2 is N-1, suma(N2,SP,SumImpares), SumPares is SP+N.
suma(N,SumPares,SumImpares) :- N2 is N-1, suma(N2,SumPares,SI), SumImpares is SI+N.