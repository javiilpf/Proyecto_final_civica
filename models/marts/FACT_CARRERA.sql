{{
    config(
        materialized='incremental',
        unique_key='SK_FACT',
        pre_hook="CREATE SEQUENCE IF NOT EXISTS DEV_GOLD_DB.GOLD.SEQ_FACT_CARRERA START 1 INCREMENT 1"
    )
}}

with resultado as (
    select * from {{ ref('RESULTADO') }}
),

etapa as (
    select id_etapa, _id_bronze, fecha from {{ ref('ETAPA') }}
),

telemetria as (
    select
        id_resultado,
        avg(potencia_media_w)   as potencia_media,
        avg(cadencia_media_rpm) as cadencia_media,
        sum(tss_vuelta)         as tss
    from {{ ref('TELEMETRIA_VUELTA') }}
    group by id_resultado
),

forma_fisica as (
    select
        id_ciclista,
        fecha_medicion,
        ctl_carga_cronica,
        atl_carga_aguda,
        tsb_forma,
        hrv_ms
    from {{ ref('FORMA_FISICA') }}
),

-- SKs de dimensiones
dim_ciclista as (
    select SK_CICLISTA, ID_CICLISTA from {{ ref('DIM_CICLISTA') }}
),

dim_etapa as (
    select SK_ETAPA, ID_ETAPA from {{ ref('DIM_ETAPA') }}
),

dim_competicion as (
    select SK_COMPETICION, ID_COMPETICION from {{ ref('DIM_COMPETICION') }}
),

dim_tiempo as (
    select SK_FECHA, FECHA from {{ ref('DIM_TIEMPO') }}
),

-- join forma física con ASOF JOIN por ciclista y fecha más cercana anterior
resultado_con_forma as (
    select
        r._id_bronze,
        r.id_ciclista,
        r.id_competicion,
        r.id_etapa,
        r.posicion_final,
        r.tiempo_total_seg,
        r.eficiencia_energetica,
        r.indice_pacing,
        r.penalizacion_seg,
        r.caidas_reportadas,
        e.fecha,
        f.ctl_carga_cronica,
        f.atl_carga_aguda,
        f.tsb_forma,
        f.hrv_ms
    from resultado r
    left join etapa e
        on r.id_etapa = e.id_etapa
    asof join forma_fisica f
        match_condition (r.id_ciclista = f.id_ciclista and e.fecha >= f.fecha_medicion)
        on r.id_ciclista = f.id_ciclista
),

final as (
    select
        DEV_GOLD_DB.GOLD.SEQ_FACT_CARRERA.NEXTVAL  as SK_FACT,
        dc.SK_CICLISTA                              as SK_CICLISTA,
        de.SK_ETAPA                                 as SK_ETAPA,
        dco.SK_COMPETICION                          as SK_COMPETICION,
        dt.SK_FECHA                                 as SK_FECHA,
        r.posicion_final                            as POSICION,
        r.tiempo_total_seg                          as TIEMPO_SEG,
        r.eficiencia_energetica                     as EFICIENCIA_ENERGETICA,
        r.indice_pacing                             as INDICE_PACING,
        r.penalizacion_seg                          as PENALIZACION_SEG,
        r.caidas_reportadas                         as CAIDAS,
        t.potencia_media                            as POTENCIA_MEDIA,
        t.cadencia_media                            as CADENCIA_MEDIA,
        r.ctl_carga_cronica                         as CTL,
        r.atl_carga_aguda                           as ATL,
        r.tsb_forma                                 as TSB,
        r.hrv_ms                                    as HRV,
        t.tss                                       as TSS
    from resultado_con_forma r
    left join telemetria t
        on r._id_bronze = t.id_resultado
    left join dim_ciclista dc
        on r.id_ciclista = dc.ID_CICLISTA
    left join dim_etapa de
        on r.id_etapa = de.ID_ETAPA
    left join dim_competicion dco
        on r.id_competicion = dco.ID_COMPETICION
    left join dim_tiempo dt
        on r.fecha = dt.FECHA

    {% if is_incremental() %}
    where r._id_bronze not in (select ID_CICLISTA from {{ this }})
    {% endif %}
)

select * from final