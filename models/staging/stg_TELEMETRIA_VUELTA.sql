with 

source as (

    select * from {{ source('stg_telemetria_vuelta') }}

),
renamed as (

    select
        _id as _id_bronze,
        numero_vuelta,
        tiempo_vuelta_seg,
        velocidad_media_kmh,
        velocidad_max_kmh,
        potencia_media_w,
        potencia_max_w,
        potencia_norm_w,
        cadencia_media_rpm,
        fc_media_bpm,
        fc_max_bpm,
        altitud_ganada_m,
        distancia_real_km,
        tss_vuelta,
        pct_zona_5,
        eficiencia_pedaleo_pct,
        temperatura_exterior_c,
        variabilidad_potencia_vi,
        velocidad_bajada_max_kmh,
        tiempo_en_aire_ms,
        desnivelado_positivo_vuelta_m,
        perdida_tiempo_tecnico_seg

    from source

)

select * from renamed