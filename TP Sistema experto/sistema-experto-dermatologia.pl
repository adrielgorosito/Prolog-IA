% Base de conocimientos: Síntomas y enfermedades con zonas y tipos de problemas
enfermedad(acne, cara, granos, [piel_grasa, espinillas, puntos_negros]).
enfermedad(eczema, cuerpo, picazon, [piel_seca, picazon_intensa, enrojecimiento]).
enfermedad(psoriasis, cuerpo, manchas, [piel_escamosa, manchas_rojas, piel_gruesa]).
enfermedad(dermatitis_contacto, manos, picazon, [erupcion, picazon, piel_irritada]).
enfermedad(rosacea, cara, granos, [enrojecimiento, piel_sensible]).

% Reglas
preguntar_filtros(Zona, Problema) :-
    write('¿En qué zona de la piel nota más problemas? (cara/cuerpo/manos): '),
    read(Zona),
    write('¿Cuál es el principal problema que nota? (granos/picazon/manchas): '),
    read(Problema).

% Consulta de síntomas
preguntar_sintomas(Zona, Problema, Lista_sintomas_usuario) :-
    findall(X, enfermedad(_, Zona, Problema, X), Lista_sintomas_enfermedades),
    desglosar_sintomas(Lista_sintomas_enfermedades, [], Lista_sintomas_usuario).

desglosar_sintomas([], Lista_sintomas_usuario, Lista_sintomas_usuario).

desglosar_sintomas([H|T], Lista_temp, Lista_sintomas_usuario) :-
    preguntar_lista_sintomas(H, Lista_temp, Nueva_lista),
    desglosar_sintomas(T, Nueva_lista, Lista_sintomas_usuario).

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
diagnosticar(Zona, Problema, Lista_final, Enfermedades_posibles) :-
    findall(X, enfermedad(X, Zona, Problema, _), Enfermedades),
    Enfermedades \= [],
    proceso_diagnostico(Enfermedades, Lista_final, [], Enfermedades_posibles).

diagnosticar(_, _, _, _).

proceso_diagnostico([], _, Enfermedades_acc, Enfermedades_acc).

proceso_diagnostico([H|T], Lista_final, Enfermedades_acc, Enfermedades_posibles) :-
    buscar_sintomas(H, Lista_sintomas_enfermedad),
    contar(Lista_sintomas_enfermedad, Cant_sintomas_enfermedad),
    filtrar_sintomas(Lista_final, Lista_sintomas_enfermedad, Lista_nueva),
    contar(Lista_nueva, Cant_sintomas_usuario),
    diagnostico_final(H, Cant_sintomas_enfermedad, Cant_sintomas_usuario, Enfermedades_acc, Nuevas_enfermedades_acc),
    proceso_diagnostico(T, Lista_final, Nuevas_enfermedades_acc, Enfermedades_posibles).

% Filtra las enfermedades que cumplan con los criterios y las agrega a la lista de enfermedades posibles
diagnostico_final(Enfermedad, Cant_sintomas_enfermedad, Cant_sintomas_usuario, Enfermedades_acc, [Enfermedad|Enfermedades_acc]) :-
    X is Cant_sintomas_enfermedad / 2,
    Y is Cant_sintomas_usuario - X,
    Y >= 0. % Si pasa esta condición, agrega la enfermedad a la lista

diagnostico_final(_, _, _, Enfermedades_acc, Enfermedades_acc).

buscar_sintomas(Enfermedad, Lista_sintomas) :- 
    enfermedad(Enfermedad, _, _, Lista_sintomas).

contar([], 0).
contar([_|T], Cant) :- contar(T, Cant_cola), Cant is Cant_cola + 1.

filtrar_sintomas([], _, []).
filtrar_sintomas([H|T], Lista_sintomas_enfermedad, [H|Lista_nueva]) :-
    pertenece(H, Lista_sintomas_enfermedad),
    filtrar_sintomas(T, Lista_sintomas_enfermedad, Lista_nueva).
filtrar_sintomas([_|T], Lista_sintomas_enfermedad, Lista_nueva) :-
    filtrar_sintomas(T, Lista_sintomas_enfermedad, Lista_nueva).

pertenece(X, [X|_]). 
pertenece(X, [_|T]) :- pertenece(X, T).

% Resultados finales
resultados([]) :-
    write('No se encontró ninguna enfermedad que coincida con los síntomas proporcionados.'), nl.
resultados(Enfermedades_posibles) :-
    Enfermedades_posibles \= [], 
    write('Usted puede llegar a tener las siguientes enfermedades:'), nl,
    imprimir_enfermedades(Enfermedades_posibles),
    write('Consulte con su dermatólogo de confianza').

imprimir_enfermedades([]).
imprimir_enfermedades([H|T]) :-
    write('- '), write(H), nl,
    imprimir_enfermedades(T).

% Interfaz de usuario
inicio :-
    write('Bienvenido al sistema de diagnóstico dermatológico.'), nl,
    preguntar_filtros(Zona, Problema),
    preguntar_sintomas(Zona, Problema, Lista_sintomas_usuario),
    reverse(Lista_sintomas_usuario, Lista_final),
    diagnosticar(Zona, Problema, Lista_final, Enfermedades_posibles),
    resultados(Enfermedades_posibles).

% ToDo:
% 1. Ver si dos o mas enfermedades con la misma zona y problema tienen uno o mas sintomas compartidos