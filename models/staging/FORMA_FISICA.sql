with source as (
    select * from {{ ref('stg_forma_fisica') }}
),
ciclista as (
    select id_ciclista, _id_bronze from {{ ref('CICLISTA') }}
),
renamed as (
    select
        f._ID                       as _id_bronze,
        c.id_ciclista               as id_ciclista,
        f.FECHA_MEDICION            as fecha_medicion,
        f.PESO_KG                   as peso_kg,
        f.FTP_W                     as ftp_w,
        f.VO2MAX                    as vo2max,
        f.FC_REPOSO                 as fc_reposo,
        f.FC_MAX                    as fc_max,
        f.POTENCIA_POR_KG           as potencia_por_kg,
        f.HORAS_ENTRENO_SEMANA      as horas_entreno_semana,
        f.FORMA_SUBJETIVA           as forma_subjetiva,
        f.NOTAS                     as notas,
        f.CTL_CARGA_CRONICA         as ctl_carga_cronica,
        f.ATL_CARGA_AGUDA           as atl_carga_aguda,
        f.TSB_FORMA                 as tsb_forma,
        f.PROTEINA_DIARIA_G_KG      as proteina_diaria_g_kg,
        f.SUENO_HORAS_NOCHE         as sueno_horas_noche,
        f.NIVEL_ESTRES_1_10         as nivel_estres_1_10,
        f.HRV_MS                    as hrv_ms,
        f.LACTATO_UMBRAL_MMOL       as lactato_umbral_mmol,
        f.CADENCIA_OPTIMA_RPM       as cadencia_optima_rpm
    from source f
    left join ciclista c
        on f.ID_CICLISTA_FK = c._id_bronze
)
select * from renamed