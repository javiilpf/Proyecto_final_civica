{{config(materialized='table')}}  


with source as (

    select * from {{ source('RAW', 'ETAPA') }}

),


renamed as (
    select
        _ID,
        _SOURCE,
        _INGESTED_AT,
        ID_COMPETICION_FK,
        NOMBRE_ETAPA,
        NUMERO_ETAPA,
        FECHA,
        DISTANCIA_KM,
        DESNIVEL_POS_M,
        DESNIVEL_NEG_M,
        ALTITUD_MAX_M,
        ALTITUD_SALIDA_M,
        TIPO_TERRENO,
        NUMERO_VUELTAS,
        LONGITUD_VUELTA_KM,
        NUM_TRAMOS_TECNICOS,
        NUM_PUERTOS,
        ALTITUD_MEDIA_M,
        INDICE_EXPOSICION_CALOR,
        SUPERFICIE_PREDOMINANTE,
        FACTOR_RIESGO_DESCENSO,
        PUNTOS_ABASTECIMIENTO

    from source

)

select * from renamed