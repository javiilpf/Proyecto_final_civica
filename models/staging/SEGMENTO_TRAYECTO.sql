with source as (
    select * from {{ ref('stg_segmento_trayecto') }}
),
telemetria_vuelta as (
    select id_telemetria, _id_bronze from {{ ref('telemetria_vuelta') }}
),
tipo_segmento as (
    select id_tipo_segmento, codigo from {{ ref('tipo_segmento') }}
),
renamed as (
    select
        s._ID                   as _id_bronze,
        t.id_telemetria         as id_telemetria,
        ts.id_tipo_segmento     as id_tipo_segmento,
        s.NUMERO_SEGMENTO       as numero_segmento,
        s.TIEMPO_SEG            as tiempo_seg,
        s.DISTANCIA_M           as distancia_m,
        s.DESNIVEL_M            as desnivel_m,
        s.POTENCIA_MEDIA_W      as potencia_media_w,
        s.FC_MEDIA_BPM          as fc_media_bpm,
        s.VELOCIDAD_MEDIA_KMH   as velocidad_media_kmh,
        s.ERRORES_LINEA         as errores_linea,
        s.FRENADAS_BRUSCAS      as frenadas_bruscas
    from source s
    left join telemetria_vuelta t
        on s.ID_TELEMETRIA_VUELTA_FK = t._id_bronze
    left join tipo_segmento ts
        on upper(trim(s.TIPO_SEGMENTO)) = upper(trim(ts.codigo))
)
select * from renamed