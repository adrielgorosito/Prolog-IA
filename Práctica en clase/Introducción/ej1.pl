observa_a(alejandro, adriel).
observa_a(alejandro, bruno).
observa_a(adriel, alejandro).
observa_a(bruno, facundo).

es_feliz(Persona) :- observa_a(Persona, Persona2), observa_a(Persona2, Persona).