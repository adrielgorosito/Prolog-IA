% Ejercicio 6 
% Escribir un programa Prolog que ayude a un organizador a armar un
% festival, considerando las diferentes bandas de música que se pueden formar en cada ciudad.
% Para formar una banda son necesarios un guitarrista, un cantante y un baterista
% El programa debe responder si en una ciudad (dato de entrada), se puede o no formar una banda. 
rol(carolina, guitarra).
rol(jose, guitarra).
rol(miguel, guitarra).
rol(mariano, voz).
rol(silvia, voz).
rol(eduardo, bateria).
rol(diego, bateria).
rol(laura, bateria).
rol(mauro, voz).
ciudad(carolina, rosario).
ciudad(jose, rosario).
ciudad(miguel, funes).
ciudad(mariano, rosario).
ciudad(silvia, funes).
ciudad(eduardo, roldan).
ciudad(diego, casilda).
ciudad(laura, rosario).
ciudad(mauro, funes).


banda(C) :- ciudad(X1, C), ciudad(X2, C), ciudad(X3, C), rol(X1, guitarra), rol(X2, bateria), rol(X3, voz).
