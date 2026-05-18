{{
    config(
        materialized='table',
        unique_key='SK_CICLISTA',
        pre_hook="CREATE SEQUENCE IF NOT EXISTS DEV_GOLD_DB.GOLD.SEQ_DIM_CICLISTA START 1 INCREMENT 1"
    )
}}

with ciclista as (
    select * from {{ ref('CICLISTA') }}
),

pais as (
    select id_pais, nombre from {{ ref('PAIS') }}
),

final as (
    select
        DEV_GOLD_DB.GOLD.SEQ_DIM_CICLISTA.NEXTVAL     as SK_CICLISTA,
        c.id_ciclista                                   as ID_CICLISTA,
        upper(trim(c.nombre)) || ' ' || upper(trim(c.apellidos)) as NOMBRE,
        c.genero                                        as GENERO,
        c.categoria                                     as CATEGORIA,
        pn.nombre                                       as PAIS,
        c.bici_marca                                    as BICI_MARCA,
        c.bici_modelo                                   as BICI_MODELO,
        c.palmares_victorias                            as PALMARES_VICTORIAS,
        c.estilo_pedaleo                                as ESTILO_PEDALEO,
        c.lateralidad                                   as LATERALIDAD,
        c.anos_experiencia                              as ANOS_EXPERIENCIA,
        c.activo                                        as VIGENTE
    from ciclista c
    left join pais pn
        on c.id_nacionalidad = pn.id_pais

    {% if is_incremental() %}
    where c.id_ciclista not in (select ID_CICLISTA from {{ this }})
    {% endif %}
)

select * from final