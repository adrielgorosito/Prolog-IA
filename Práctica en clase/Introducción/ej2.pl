le_gusta(alejandro, camila).
le_gusta(alejandro, sofia).
observa_a(alejandro, camila).
observa_a(alejandro, sofia).
observa_a(sofia, alejandro).

se_pone_nervioso(Persona) :- le_gusta(Persona, Persona2), observa_a(Persona2, Persona).