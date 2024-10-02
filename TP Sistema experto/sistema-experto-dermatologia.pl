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
diagnosticar(Zona, Problema, Lista_final) :-
    findall(X, enfermedad(X, Zona, Problema, _), Enfermedades),
    Enfermedades \= [],
    proceso_diagnostico(Enfermedades, Lista_final).
diagnosticar(Zona, Problema, _) :-
    findall(X, enfermedad(X, Zona, Problema, _), Enfermedades),
    Enfermedades = [],
    write('No se encontró ninguna enfermedad que coincida con los síntomas proporcionados.'), nl.

proceso_diagnostico([], _) :-
    write('No se pudo realizar un diagnóstico preciso.'), nl.

proceso_diagnostico([H|T], Lista_final) :-
    buscar_sintomas(H, Lista_sintomas_enfermedad),
    contar(Lista_sintomas_enfermedad, Cant_sintomas_enfermedad),
    write("CANT SÍNTOMAS ENF: "), write(Cant_sintomas_enfermedad), nl, nl,
    filtrar_sintomas(Lista_final, Lista_sintomas_enfermedad, Lista_nueva),
    contar(Lista_nueva, Cant_sintomas_usuario),
    write("CANT SÍNTOMAS USU: "), write(Cant_sintomas_usuario), nl, nl,
    diagnostico_final(H, Cant_sintomas_enfermedad, Cant_sintomas_usuario),
    proceso_diagnostico(T, Lista_final).

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

% Lógica para el diagnóstico final
diagnostico_final(Enfermedad, Cant_sintomas_enfermedad, Cant_sintomas_usuario) :-
    X is Cant_sintomas_enfermedad / 2,
    Y is Cant_sintomas_usuario - X,
    Y >= 0, 
    write('Usted puede llegar a tener: '), write(Enfermedad), nl,
    write('Consulte con su dermatólogo de confianza.'), nl.

diagnostico_final(_, Cant_sintomas_enfermedad, Cant_sintomas_usuario) :-
    X is Cant_sintomas_enfermedad / 2,
    Y is Cant_sintomas_usuario - X,
    Y < 0, 
    write('Sus síntomas no coinciden con ninguna enfermedad. De todas formas, consulte con su dermatólogo de confianza.'), nl.

% Interfaz de usuario
inicio :-
    write('Bienvenido al sistema de diagnóstico dermatológico.'), nl,
    preguntar_filtros(Zona, Problema),
    preguntar_sintomas(Zona, Problema, Lista_sintomas_usuario),
    reverse(Lista_sintomas_usuario, Lista_final),
    diagnosticar(Zona, Problema, Lista_final).


% ToDo:
% 1. Ver impresión de enfermedades
% 2. Ver si dos o mas enfermedades tienen uno o mas sintomas