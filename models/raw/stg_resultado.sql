{{config(materialized='view')}}  


with source as (

    select * from {{ source('RAW', 'RESULTADO') }}

),


renamed as (
    select
       _ID,
        _SOURCE,
        _INGESTED_AT,
        ID_CICLISTA_FK,
        ID_COMPETICION_FK,
        ID_ETAPA_FK,
        ID_EQUIPO_FK,
        DORSAL,
        POSICION_FINAL,
        TIEMPO_TOTAL_SEG,
        DIFERENCIA_SEG,
        ABANDONO,
        MOTIVO_ABANDONO,
        PUNTOS_UCI,
        TEMPERATURA_C,
        HUMEDAD_PCT,
        VIENTO_KMH,
        LLUVIA_MM,
        CONDICION_METEO,
        TIPO_TERRENO,
        DISTANCIA_KM,
        DESNIVEL_POS_M,
        EFICIENCIA_ENERGETICA,
        INDICE_PACING,
        PENALIZACION_SEG,
        CAIDAS_REPORTADAS,
        BONIFICACION_SEG,
        PORCENTAJE_COMPLETADO,
        POSICION_TOP10

    from source

)

select * from renamed