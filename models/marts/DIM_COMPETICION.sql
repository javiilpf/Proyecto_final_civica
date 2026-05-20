{{
    config(
        materialized='table',
        pre_hook="CREATE SEQUENCE IF NOT EXISTS DEV_GOLD_DB.GOLD.SEQ_DIM_COMPETICION START 1 INCREMENT 1"
    )
}}

with competicion as (
    select * from {{ ref('COMPETICION') }}
),

pais as (
    select id_pais, nombre from {{ ref('PAIS') }}
),

nivel_competicion as (
    select id_nivel, codigo from {{ ref('NIVEL_COMPETICION') }}
),

tipo_competicion as (SELECT 
    id_tipo,
    codigo,
    disciplina 
    FROM {{ ref('TIPO_COMPETICION') }}
),

final as (
    select
        DEV_GOLD_DB.GOLD.SEQ_DIM_COMPETICION.NEXTVAL  as SK_COMPETICION,
        c.id_competicion                                as ID_COMPETICION,
        c.nombre                                        as NOMBRE,
        p.nombre                                        as PAIS,
        c.distancia_total_km                            as DISTANCIA_TOTAL_KM,
        c.num_participantes_inscritos                   as NUM_PARTICIPANTES,
        n.codigo                                        as NIVEL,
        c.presupuesto_premios_eur                       as PRESUPUESTO_PREMIOS,
        c.altitud_media_m                               as ALTITUD_MEDIA,
        c.dificultad_tecnica                            as DIFICULTAD_TECNICA,
        c.valoracion_media_corredores                   as VALORACION_CORREDORES,
        c.transmision_online                            as TRANSMISION_ONLINE,
        c.patrocinador_local                            as PATROCINADOR_LOCAL,
        tc.disciplina                                   as DISCIPLINA,
        tc.codigo                                       as TIPO
    from competicion c
    left join pais p
        on c.id_pais = p.id_pais
    left join nivel_competicion n
        on c.id_nivel = n.id_nivel
    left join tipo_competicion tc
    on c.id_tipo = tc.id_tipo


)

select * from final