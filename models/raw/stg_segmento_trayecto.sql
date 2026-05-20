{{config(materialized='view')}}  


with source as (

    select * from {{ source('RAW', 'SEGMENTO_TRAYECTO') }}

),


renamed as (
    select
        _ID,
        _SOURCE,
        _INGESTED_AT,
        ID_TELEMETRIA_VUELTA_FK,
        NUMERO_SEGMENTO,
        TIPO_SEGMENTO,
        TIEMPO_SEG,
        DISTANCIA_M,
        DESNIVEL_M,
        POTENCIA_MEDIA_W,
        FC_MEDIA_BPM,
        VELOCIDAD_MEDIA_KMH,
        ERRORES_LINEA,
        FRENADAS_BRUSCAS

    from source

)

select * from renamed