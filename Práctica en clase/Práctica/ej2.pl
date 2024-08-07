% Ejercicio 2
% Teniendo la siguiente base de hechos, definir una regla que permita
% determinar quienes hablan el idioma inglés y francés. 
conoce(franco,ingles).
conoce(renzo,ingles).
conoce(franco,frances).
conoce(renzo,frances).
conoce(franco,italiano).
conoce(marco,ingles).
conoce(omar,ingles).
conoce(maria,frances). 


habla_idiomas(X):- conoce(X, ingles), conoce(X, frances).
