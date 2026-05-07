{{config(materialized='view')}}  


with source as (

    select * from {{ source('RAW', 'COMPETICION') }}

),


renamed as (
    select
        _ID,
        _SOURCE,
        _INGESTED_AT,
        NOMBRE,
        TIPO,
        CATEGORIA_UCI,
        DISCIPLINA,
        PAIS,
        CIUDAD,
        FECHA_INICIO,
        FECHA_FIN,
        TEMPORADA,
        ORGANIZADOR,
        CIRCUITO,
        DISTANCIA_TOTAL_KM,
        NUM_PARTICIPANTES_INSCRITOS,
        NIVEL,
        PRESUPUESTO_PREMIOS_EUR,
        ALTITUD_MEDIA_M,
        PCT_TIERRA_NATURAL,
        DIFICULTAD_TECNICA,
        VALORACION_MEDIA_CORREDORES,
        NUM_VOLUNTARIOS,
        TRANSMISION_ONLINE,
        PATROCINADOR_LOCAL

    from source

)

select * from renamed