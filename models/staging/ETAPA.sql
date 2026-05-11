with source as (
    select * from {{ ref('stg_etapa') }}
),
competicion as (
    select id_competicion, _id_bronze from {{ ref('COMPETICION') }}
),
tipo_terreno as (
    select id_terreno, codigo from {{ ref('TIPO_TERRENO') }}
),
renamed as (
    select
        e._ID                       as _id_bronze,
        c.id_competicion            as id_competicion,
        e.NOMBRE_ETAPA              as nombre_etapa,
        e.NUMERO_ETAPA              as numero_etapa,
        e.FECHA                     as fecha,
        e.DISTANCIA_KM              as distancia_km,
        e.DESNIVEL_POS_M            as desnivel_pos_m,
        e.DESNIVEL_NEG_M            as desnivel_neg_m,
        e.ALTITUD_MAX_M             as altitud_max_m,
        e.ALTITUD_SALIDA_M          as altitud_salida_m,
        tt.id_terreno               as id_tipo_terreno,
        e.NUMERO_VUELTAS            as numero_vueltas,
        e.LONGITUD_VUELTA_KM        as longitud_vuelta_km,
        e.NUM_TRAMOS_TECNICOS       as num_tramos_tecnicos,
        e.NUM_PUERTOS               as num_puertos,
        e.ALTITUD_MEDIA_M           as altitud_media_m,
        e.INDICE_EXPOSICION_CALOR   as indice_exposicion_calor,
        ts.id_terreno               as id_superficie,
        e.FACTOR_RIESGO_DESCENSO    as factor_riesgo_descenso,
        e.PUNTOS_ABASTECIMIENTO     as puntos_abastecimiento
    from source e
    left join competicion c
        on e.ID_COMPETICION_FK = c._id_bronze
    left join tipo_terreno tt
        on upper(trim(e.TIPO_TERRENO)) = upper(trim(tt.codigo))
    left join tipo_terreno ts
        on upper(trim(e.SUPERFICIE_PREDOMINANTE)) = upper(trim(ts.codigo))
)
select * from renamed