{{config(materialized='table')}}  


with source as (

    select * from {{ source('RAW', 'TELEMETRIA_VUELTA') }}

),


renamed as (
    select
       _ID,
        _SOURCE,
        _INGESTED_AT,
        ID_RESULTADO_FK,
        NUMERO_VUELTA,
        TIEMPO_VUELTA_SEG,
        VELOCIDAD_MEDIA_KMH,
        VELOCIDAD_MAX_KMH,
        POTENCIA_MEDIA_W,
        POTENCIA_MAX_W,
        POTENCIA_NORM_W,
        CADENCIA_MEDIA_RPM,
        FC_MEDIA_BPM,
        FC_MAX_BPM,
        ALTITUD_GANADA_M,
        DISTANCIA_REAL_KM,
        TSS_VUELTA,
        PCT_ZONA_5,
        EFICIENCIA_PEDALEO_PCT,
        TEMPERATURA_EXTERIOR_C,
        VARIABILIDAD_POTENCIA_VI,
        VELOCIDAD_BAJADA_MAX_KMH,
        TIEMPO_EN_AIRE_MS,
        DESNIVELADO_POSITIVO_VUELTA_M,
        PERDIDA_TIEMPO_TECNICO_SEG

    from source

)

select * from renamed
