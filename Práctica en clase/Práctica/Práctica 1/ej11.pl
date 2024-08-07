% Ejercicio 11
factorial(0, 1).
factorial(N,Fact) :- N2 is N-1, factorial(N2, F), Fact is F*N.