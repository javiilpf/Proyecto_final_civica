with source as (
    select * from {{ ref('stg_telemetria_vuelta') }}
),
resultado as (
    select id_resultado, _id_bronze from {{ ref('RESULTADO') }}
),
renamed as (
    select
        t._ID                           as _id_bronze,
        r.id_resultado                  as id_resultado,
        t.NUMERO_VUELTA                 as numero_vuelta,
        t.TIEMPO_VUELTA_SEG             as tiempo_vuelta_seg,
        t.VELOCIDAD_MEDIA_KMH           as velocidad_media_kmh,
        t.VELOCIDAD_MAX_KMH             as velocidad_max_kmh,
        t.POTENCIA_MEDIA_W              as potencia_media_w,
        t.POTENCIA_MAX_W                as potencia_max_w,
        t.POTENCIA_NORM_W               as potencia_norm_w,
        t.CADENCIA_MEDIA_RPM            as cadencia_media_rpm,
        t.FC_MEDIA_BPM                  as fc_media_bpm,
        t.FC_MAX_BPM                    as fc_max_bpm,
        t.ALTITUD_GANADA_M              as altitud_ganada_m,
        t.DISTANCIA_REAL_KM             as distancia_real_km,
        t.TSS_VUELTA                    as tss_vuelta,
        t.PCT_ZONA_5                    as pct_zona_5,
        t.EFICIENCIA_PEDALEO_PCT        as eficiencia_pedaleo_pct,
        t.TEMPERATURA_EXTERIOR_C        as temperatura_exterior_c,
        t.VARIABILIDAD_POTENCIA_VI      as variabilidad_potencia_vi,
        t.VELOCIDAD_BAJADA_MAX_KMH      as velocidad_bajada_max_kmh,
        t.TIEMPO_EN_AIRE_MS             as tiempo_en_aire_ms,
        t.DESNIVELADO_POSITIVO_VUELTA_M as desnivelado_positivo_vuelta_m,
        t.PERDIDA_TIEMPO_TECNICO_SEG    as perdida_tiempo_tecnico_seg
    from source t
    left join resultado r
        on t.ID_RESULTADO_FK = r._id_bronze
)
select
    row_number() over (order by _id_bronze) as id_telemetria,
    *
from renamed