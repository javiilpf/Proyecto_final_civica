with source as (
    select * from {{ ref('stg_resultado') }}
),
ciclista as (
    select id_ciclista, _id_bronze from {{ ref('CICLISTA') }}
),
competicion as (
    select id_competicion, _id_bronze from {{ ref('COMPETICION') }}
),
etapa as (
    select id_etapa, _id_bronze from {{ ref('ETAPA') }}
),
equipo as (
    select id_equipo, _id_bronze from {{ ref('EQUIPO') }}
),
renamed as (
    select
        r._ID                       as _id_bronze,
        ci.id_ciclista              as id_ciclista,
        co.id_competicion           as id_competicion,
        e.id_etapa                  as id_etapa,
        eq.id_equipo                as id_equipo,
        r.DORSAL                    as dorsal,
        r.POSICION_FINAL            as posicion_final,
        r.TIEMPO_TOTAL_SEG          as tiempo_total_seg,
        r.DIFERENCIA_SEG            as diferencia_seg,
        r.ABANDONO                  as abandono,
        r.MOTIVO_ABANDONO           as motivo_abandono,
        r.PUNTOS_UCI                as puntos_uci,
        r.TEMPERATURA_C             as temperatura_c,
        r.HUMEDAD_PCT               as humedad_pct,
        r.VIENTO_KMH                as viento_kmh,
        r.LLUVIA_MM                 as lluvia_mm,
        r.CONDICION_METEO           as condicion_meteo,
        r.TIPO_TERRENO              as tipo_terreno,
        r.DISTANCIA_KM              as distancia_km,
        r.DESNIVEL_POS_M            as desnivel_pos_m,
        r.EFICIENCIA_ENERGETICA     as eficiencia_energetica,
        r.INDICE_PACING             as indice_pacing,
        r.PENALIZACION_SEG          as penalizacion_seg,
        r.CAIDAS_REPORTADAS         as caidas_reportadas,
        r.BONIFICACION_SEG          as bonificacion_seg,
        r.PORCENTAJE_COMPLETADO     as porcentaje_completado,
        r.POSICION_TOP10            as posicion_top10
    from source r
    left join ciclista ci
        on r.ID_CICLISTA_FK = ci._id_bronze
    left join competicion co
        on r.ID_COMPETICION_FK = co._id_bronze
    left join etapa e
        on r.ID_ETAPA_FK = e._id_bronze
    left join equipo eq
        on r.ID_EQUIPO_FK = eq._id_bronze
)
select * from renamed