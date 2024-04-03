mujer(gabriela).
padres(mirta, roberto, gabriela).
padres(mirta, roberto, laura).

hermana(Nombre, Nombre2) :- Nombre \= Nombre2, mujer(Nombre), padres(Mama, Papa, Nombre), padres(Mama, Papa, Nombre2).

% la primera condicion es que sean distintos