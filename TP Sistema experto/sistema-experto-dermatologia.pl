% Base de conocimientos: Síntomas y enfermedades con zonas y tipos de problemas
enfermedad(acne, cara, granos, [piel_grasa, espinillas, puntos_negros]).
enfermedad(eczema, cuerpo, picazon, [piel_seca, picazon_intensa, enrojecimiento]).
enfermedad(psoriasis, cuerpo, manchas, [piel_escamosa, manchas_rojas, piel_gruesa]).
enfermedad(dermatitis_contacto, manos, picazon, [erupcion, picazon, piel_irritada]).

% Reglas
preguntar_filtros(Zona, Problema) :-
    write('¿En qué zona de la piel nota más problemas? (cara/cuerpo/manos): '),
    read(Zona),
    write('¿Cuál es el principal problema que nota? (granos/picazon/manchas): '),
    read(Problema).

% Consulta de síntomas
preguntar_sintomas(Zona, Problema, Lista_sintomas_usuario) :-
    enfermedad(_, Zona, Problema, Sintomas),
    preguntar_lista_sintomas(Sintomas, [], Lista_sintomas_usuario).

preguntar_lista_sintomas([], Lista, Lista).
preguntar_lista_sintomas([Sintoma|Resto], Lista_temp, Lista_final) :- 
    consultar_sintoma(Sintoma, Lista_temp, Nueva_lista), 
    preguntar_lista_sintomas(Resto, Nueva_lista, Lista_final).

consultar_sintoma(Sintoma, Lista_temp, Lista) :-
    write('¿Tiene usted '), write(Sintoma), write('? (si/no): '),
    read(Respuesta),
    procesar_respuesta(Sintoma, Respuesta, Lista_temp, Lista).

procesar_respuesta(Sintoma, si, Lista_temp, [Sintoma|Lista_temp]).
procesar_respuesta(_, no, Lista_temp, Lista_temp).

% Diagnóstico
diagnosticar(Zona, Problema, Lista_final) :-
    findall(X, enfermedad(X, Zona, Problema, _), Enfermedad),
    buscar_sintomas(Enfermedad, Lista_sintomas),
   	contar_sintomas(Lista_sintomas, Cant_sintomas_enfermedad),
    contar(Lista_final, Cant_sintomas_usuario),
    diagnostico_final(Enfermedad, Cant_sintomas_enfermedad, Cant_sintomas_usuario).

buscar_sintomas([H|_], Lista_sintomas) :- 
    findall(X, enfermedad(H, _, _, X), Lista_sintomas).
% Sólo contemplamos la búsqueda de los sintomas de una sola enfermedad, habría q hacerlo por enfermedad

contar_sintomas([H|_], Cant) :- contar(H, Cant).
contar([], 0).
contar([_|T], Cant):- contar(T, Cant_cola), Cant is Cant_cola + 1.

diagnostico_final(Enfermedad, Cant_sintomas_enfermedad, Cant_sintomas_usuario) :-
    X is Cant_sintomas_enfermedad / 2,
    Y is Cant_sintomas_usuario - X,
    Y >= 0, 
    write('Usted puede llegar a tener: '), write(Enfermedad), nl,
    write('Consulte con su dermatólogo de confianza.').

diagnostico_final(_, Cant_sintomas_enfermedad, Cant_sintomas_usuario) :-
    X is Cant_sintomas_enfermedad / 2,
    Y is Cant_sintomas_usuario - X,
    Y < 0, 
    write('Sus síntomas no coinciden con ninguna enfermedad. De todas formas, consulte con su dermatólogo de confianza.').

% Interfaz de usuario
inicio :-
    write('Bienvenido al sistema de diagnóstico dermatológico.'), nl,
    preguntar_filtros(Zona, Problema),
    preguntar_sintomas(Zona, Problema, Lista_sintomas_usuario),
    reverse(Lista_sintomas_usuario, Lista_final), 
    diagnosticar(Zona, Problema, Lista_final).


% ToDo:
% 1. Si no coincide ninguna zona ni problema principal, informar que no tiene ninguna enfermedad
% 2. Modificar la lógica de buscar_sintomas y lo que sigue para dos o mas enfermedades.