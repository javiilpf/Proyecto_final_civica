with 

source as (

    select * from {{ ref('stg_forma_fisica') }}

),

renamed as (

    select
        _ID as _id_bronze,
        FECHA_MEDICION,
        PESO_KG,
        FTP_W,
        VO2MAX,
        FC_REPOSO,
        FC_MAX,
        POTENCIA_POR_KG,
        HORAS_ENTRENO_SEMANA,
        FORMA_SUBJETIVA,
        NOTAS,
        CTL_CARGA_CRONICA,
        ATL_CARGA_AGUDA,
        TSB_FORMA,
        PROTEINA_DIARIA_G_KG,
        SUENO_HORAS_NOCHE,
        NIVEL_ESTRES_1_10,
        HRV_MS,
        LACTATO_UMBRAL_MMOL,
        CADENCIA_OPTIMA_RPM

    from source

)

select * from renamed