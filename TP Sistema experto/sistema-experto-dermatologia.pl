% Reglas
preguntar_nombre(Nombre) :-
    write('Por favor, ingrese su nombre: '),
    read_line_to_string(user_input, Nombre),
    write('\n¡Hola '), write(Nombre), write('! Soy DermAI, tu asistente virtual dermatológico.\n'),
    write('Te ayudaré a identificar posibles condiciones dermatológicas basadas en tus síntomas.\n'),
    write('Recuerda que esto es solo una guía inicial y no reemplaza la consulta médica profesional.\n\n').

preguntar_filtros(Zona, Problema) :-
    write('¿En qué zona de la piel nota más problemas? (cara/cuerpo/piel/manos/labios/pies): '),
    read(Zona),
    write('¿Cuál es el principal problema que nota? (granos/sarpullido/manchas/ampollas/ronchas): '),
    read(Problema).

% Consulta de síntomas
preguntar_sintomas(Zona, Problema, Lista_sintomas_usuario) :-
    findall(X, enfermedad(_, Zona, Problema, X), Lista_sintomas_enfermedades),
    desglosar_sintomas(Lista_sintomas_enfermedades, [], Lista_sintomas_usuario, []).

desglosar_sintomas([], Lista_sintomas_usuario, Lista_sintomas_usuario, _).

desglosar_sintomas([H|T], Lista_temp, Lista_sintomas_usuario, Lista_sintomas_consultados) :-
    preguntar_lista_sintomas(H, Lista_temp, Nueva_lista, Lista_sintomas_consultados, Nuevos_sintomas_consultados),
    desglosar_sintomas(T, Nueva_lista, Lista_sintomas_usuario, Nuevos_sintomas_consultados).

preguntar_lista_sintomas([], Lista, Lista, Lista_sintomas_consultados, Lista_sintomas_consultados).

preguntar_lista_sintomas([Sintoma|Resto], Lista_temp, Lista_final, Lista_sintomas_consultados, Lista_sintomas_actualizada) :- 
    \+ pertenece(Sintoma, Lista_sintomas_consultados),
    consultar_sintoma(Sintoma, Lista_temp, Nueva_lista),
    preguntar_lista_sintomas(Resto, Nueva_lista, Lista_final, [Sintoma|Lista_sintomas_consultados], Lista_sintomas_actualizada).

preguntar_lista_sintomas([_|Resto], Lista_temp, Lista_final, Lista_sintomas_consultados, Lista_sintomas_actualizada) :- 
    preguntar_lista_sintomas(Resto, Lista_temp, Lista_final, Lista_sintomas_consultados, Lista_sintomas_actualizada).

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
    proceso_diagnostico(Enfermedades, Lista_final, [], Enfermedades_posibles), !.

diagnosticar(_, _, _, _).

proceso_diagnostico([], _, Enfermedades_acc, Enfermedades_acc) :- !.

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
    write('No se encontró ninguna enfermedad que coincida con los síntomas proporcionados.'), nl, !.
resultados(Enfermedades_posibles) :-
    Enfermedades_posibles \= [], 
    nl, write('Usted puede llegar a tener las siguientes enfermedades:'), nl,
    imprimir_enfermedades(Enfermedades_posibles),
    write('Consulte con su dermatólogo de confianza.'), nl.

imprimir_enfermedades([]).
imprimir_enfermedades([H|T]) :-
    write('- '), write(H), nl,
    imprimir_enfermedades(T).

% Interfaz de usuario
inicio :-
    consult("./enfermedades.txt"),
    write('Bienvenido al sistema de diagnóstico dermatológico.'), nl,
    preguntar_nombre(Nombre),
    preguntar_filtros(Zona, Problema),
    preguntar_sintomas(Zona, Problema, Lista_sintomas_usuario),
    reverse(Lista_sintomas_usuario, Lista_final),
    diagnosticar(Zona, Problema, Lista_final, Enfermedades_posibles),
    resultados(Enfermedades_posibles), 
    nl, write('Gracias por usar DermAI, '), write(Nombre), write('!'), nl, halt.