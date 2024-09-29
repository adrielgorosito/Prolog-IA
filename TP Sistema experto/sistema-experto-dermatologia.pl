% Base de conocimientos: Síntomas y enfermedades con zonas y tipos de problemas
enfermedad(acne, cara, granos, [piel_grasa, espinillas, puntos_negros]).
enfermedad(eczema, cuerpo, picazon, [piel_seca, picazon_intensa, enrojecimiento]).
enfermedad(psoriasis, cuerpo, manchas, [piel_escamosa, manchas_rojas, piel_gruesa]).
enfermedad(dermatitis_contacto, manos, picazon, [erupcion, picazon, piel_irritada]).

% Pesos de los síntomas
peso_sintoma(piel_grasa, 0.7).
peso_sintoma(espinillas, 0.8).
peso_sintoma(puntos_negros, 0.6).
peso_sintoma(piel_seca, 0.7).
peso_sintoma(picazon_intensa, 0.8).
peso_sintoma(enrojecimiento, 0.6).
peso_sintoma(piel_escamosa, 0.8).
peso_sintoma(manchas_rojas, 0.7).
peso_sintoma(piel_gruesa, 0.6).
peso_sintoma(erupcion, 0.7).
peso_sintoma(picazon, 0.8).
peso_sintoma(piel_irritada, 0.6).

% Base de conocimientos dinámica para respuestas del usuario
:- dynamic tiene_sintoma/1.
:- dynamic zona_afectada/1.
:- dynamic tipo_problema/1.

% Interfaz de usuario
inicio :-
    write('Bienvenido al sistema de diagnóstico dermatológico.'), nl,
    preguntar_filtros,
    preguntar_sintomas,
    diagnosticar,
    limpiar.

preguntar_filtros :-
    write('¿En qué zona de la piel nota más problemas? (cara/cuerpo/manos): '),
    read(Zona),
    assert(zona_afectada(Zona)),
    write('¿Cuál es el principal problema que nota? (granos/picazon/manchas): '),
    read(Problema),
    assert(tipo_problema(Problema)).

preguntar_sintomas :-
    zona_afectada(Zona),
    tipo_problema(Problema),
    enfermedad(_, Zona, Problema, Sintomas),
    preguntar_lista_sintomas(Sintomas).

preguntar_lista_sintomas([]).
preguntar_lista_sintomas([Sintoma|Resto]) :-
    preguntar_sintoma(Sintoma),
    preguntar_lista_sintomas(Resto).

preguntar_sintoma(Sintoma) :-
    write('¿Tiene usted '), write(Sintoma), write('? (si/no): '),
    read(Respuesta),
    procesar_respuesta(Sintoma, Respuesta).

procesar_respuesta(Sintoma, si) :-
    assert(tiene_sintoma(Sintoma)).
procesar_respuesta(_, no).

% Diagnóstico
diagnosticar :-
    zona_afectada(Zona),
    tipo_problema(Problema),
    enfermedad(Enfermedad, Zona, Problema, _),
    calcular_certeza(Enfermedad, Certeza),
    Certeza > 0.5,
    mostrar_resultado(Enfermedad, Certeza),
    fail.
diagnosticar :-
    \+ (zona_afectada(Zona),
        tipo_problema(Problema),
        enfermedad(_, Zona, Problema, _),
        calcular_certeza(_, Certeza),
        Certeza > 0.5),
    write('No se pudo determinar un diagnóstico claro con los síntomas proporcionados.'), nl,
    write('Por favor, consulte a un dermatólogo para una evaluación más detallada.'), nl.
diagnosticar.

calcular_certeza(Enfermedad, Certeza) :-
    enfermedad(Enfermedad, _, _, Sintomas),
    sumar_pesos(Sintomas, 0, 0, SumaPesos, Total),
    Certeza is SumaPesos / Total.

sumar_pesos([], SumaPesos, Total, SumaPesos, Total).
sumar_pesos([Sintoma|Resto], SumaParcial, TotalParcial, SumaPesos, Total) :-
    peso_sintoma(Sintoma, Peso),
    (tiene_sintoma(Sintoma) ->
        NuevaSuma is SumaParcial + Peso
    ;
        NuevaSuma is SumaParcial
    ),
    NuevoTotal is TotalParcial + Peso,
    sumar_pesos(Resto, NuevaSuma, NuevoTotal, SumaPesos, Total).

mostrar_resultado(Enfermedad, Certeza) :-
    format('Posible diagnóstico: ~w (Certeza: ~2f)~n', [Enfermedad, Certeza]).

% Limpiar la base de conocimientos dinámica
limpiar :-
    retractall(tiene_sintoma(_)),
    retractall(zona_afectada(_)),
    retractall(tipo_problema(_)).

% Para iniciar el sistema
:- inicio.