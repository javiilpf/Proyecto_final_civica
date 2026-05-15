{{
    config(
        materialized='incremental',
        unique_key='SK_ETAPA',
        pre_hook="CREATE SEQUENCE IF NOT EXISTS DEV_GOLD_DB.GOLD.SEQ_DIM_ETAPA START 1 INCREMENT 1"
    )
}}

with etapa as (
    select * from {{ ref('ETAPA') }}
),

tipo_terreno as (
    select id_terreno, codigo from {{ ref('TIPO_TERRENO') }}
),

final as (
    select
        DEV_GOLD_DB.GOLD.SEQ_DIM_ETAPA.NEXTVAL  as SK_ETAPA,
        e.id_etapa                               as ID_ETAPA,
        e.nombre_etapa                           as NOMBRE,
        e.num_tramos_tecnicos                    as NUM_TRAMOS_TECNICOS,
        e.num_puertos                            as NUM_PUERTOS,
        e.altitud_media_m                        as ALTITUD_MEDIA,
        e.indice_exposicion_calor                as INDICE_EXPOSICION_CALOR,
        tt.codigo                                as SUPERFICIE_PREDOMINANTE,
        e.factor_riesgo_descenso                 as FACTOR_RIESGO_DESCENSO,
        e.puntos_abastecimiento                  as PUNTOS_ABASTECIMIENTO
    from etapa e
    left join tipo_terreno tt
        on e.id_superficie = tt.id_terreno

    {% if is_incremental() %}
    where e.id_etapa not in (select ID_ETAPA from {{ this }})
    {% endif %}
)

select * from final