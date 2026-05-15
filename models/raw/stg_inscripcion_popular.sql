{{config(materialized='view')}}  


with source as (

    select * from {{ source('RAW', 'INSCRIPCION_POPULAR') }}

),


renamed as (
    select
       _ID,
        _SOURCE,
        _INGESTED_AT,
        ID_RESULTADO_FK,
        ID_COMPETICION_FK,
        ID_CICLISTA_FK,
        CLUB_LOCAL,
        MOTIVACION_PRINCIPAL,
        NIVEL_AUTOPERCIBIDO,
        TIPO_BICI_USADA,
        PRIMERA_VEZ_PRUEBA,
        FUENTE_CONOCIMIENTO,
        VALORACION_ORGANIZACION,
        VALORACION_RECORRIDO,
        REPETIRIA,
        KM_ENTRENADOS_SEMANA_PREV,
        ANOS_PRACTICANDO_MTB

    from source

)

select * from renamed