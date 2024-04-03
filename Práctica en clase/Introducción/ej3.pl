le_gusta_a(juan, joya).
persona_es(juan, ladron).
objeto_es(joya, valioso).

puede_robar(X, Y) :- le_gusta_a(X, Y), persona_es(X, ladron), objeto_es(Y, valioso).