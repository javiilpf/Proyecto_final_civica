{{
    config(
        materialized='incremental',
        unique_key='SK_COMPETICION',
        pre_hook="CREATE SEQUENCE IF NOT EXISTS DEV_GOLD_DB.GOLD.SEQ_DIM_COMPETICION START 1 INCREMENT 1"
    )
}}

with competicion as (
    select * from {{ ref('COMPETICION') }}
),

pais as (
    select id_pais, nombre from {{ ref('PAIS') }}
),

final as (
    select
        DEV_GOLD_DB.GOLD.SEQ_DIM_COMPETICION.NEXTVAL  as SK_COMPETICION,
        c._id_bronze                                    as ID_COMPETICION,
        c.nombre                                        as NOMBRE,
        p.nombre                                        as PAIS,
        c.distancia_total_km                            as DISTANCIA_TOTAL_KM,
        c.num_participantes_inscritos                   as NUM_PARTICIPANTES,
        c.nivel                                         as NIVEL,
        c.presupuesto_premios_eur                       as PRESUPUESTO_PREMIOS,
        c.altitud_media_m                               as ALTITUD_MEDIA,
        c.dificultad_tecnica                            as DIFICULTAD_TECNICA,
        c.valoracion_media_corredores                   as VALORACION_CORREDORES,
        c.transmision_online                            as TRANSMISION_ONLINE,
        c.patrocinador_local                            as PATROCINADOR_LOCAL
    from competicion c
    left join pais p
        on c.id_pais = p.id_pais

    {% if is_incremental() %}
    where c._id_bronze not in (select ID_COMPETICION from {{ this }})
    {% endif %}
)

select * from final