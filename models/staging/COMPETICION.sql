with source as (
    select * from {{ ref('stg_competicion') }}
),
pais as (
    select id_pais, nombre from {{ ref('PAIS') }}
),
categoria_uci as (
    select id_categoria, codigo from {{ ref('CATEGORIA_UCI') }}
),
tipo_competicion as (
    select id_tipo, codigo from {{ ref('TIPO_COMPETICION') }}
),
nivel_competicion as (
    select id_nivel, codigo from {{ ref('NIVEL_COMPETICION') }}
),
renamed as (
    select
        c._ID                           as _id_bronze,
        c.NOMBRE                        as nombre,
        t.id_tipo                       as id_tipo,
        cat.id_categoria                as id_categoria_uci,
        p.id_pais                       as id_pais,
        c.CIUDAD                        as ciudad,
        c.FECHA_INICIO                  as fecha_inicio,
        c.FECHA_FIN                     as fecha_fin,
        c.TEMPORADA                     as temporada,
        c.ORGANIZADOR                   as organizador,
        c.CIRCUITO                      as circuito,
        c.DISTANCIA_TOTAL_KM            as distancia_total_km,
        c.NUM_PARTICIPANTES_INSCRITOS   as num_participantes_inscritos,
        n.id_nivel                      as id_nivel,
        c.PRESUPUESTO_PREMIOS_EUR       as presupuesto_premios_eur,
        c.ALTITUD_MEDIA_M               as altitud_media_m,
        c.PCT_TIERRA_NATURAL            as pct_tierra_natural,
        c.DIFICULTAD_TECNICA            as dificultad_tecnica,
        c.VALORACION_MEDIA_CORREDORES   as valoracion_media_corredores,
        c.NUM_VOLUNTARIOS               as num_voluntarios,
        c.TRANSMISION_ONLINE            as transmision_online,
        c.PATROCINADOR_LOCAL            as patrocinador_local
    from source c
    left join pais p
        on upper(trim(c.PAIS)) = upper(trim(p.nombre))
    left join categoria_uci cat
        on upper(trim(c.CATEGORIA_UCI)) = upper(trim(cat.codigo))
    left join tipo_competicion t
        on upper(trim(c.TIPO)) = upper(trim(t.codigo))
    left join nivel_competicion n
        on upper(trim(c.NIVEL)) = upper(trim(n.codigo))
)
select * from renamed