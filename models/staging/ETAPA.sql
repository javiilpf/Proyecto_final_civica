with 

source as (

    select * from {{ ref('stg_etapa') }}

),

renamed as (

    select
        _ID as _id_bronze,
        NOMBRE_ETAPA,
        NUMERO_ETAPA,
        FECHA,
        DISTANCIA_KM,
        DESNIVEL_POS_M,
        DESNIVEL_NEG_M,
        ALTITUD_MAX_M,
        ALTITUD_SALIDA_M,
        NUMERO_VUELTAS,
        LONGITUD_VUELTA_KM,
        NUM_TRAMOS_TECNICOS,
        NUM_PUERTOS,
        ALTITUD_MEDIA_M,
        INDICE_EXPOSICION_CALOR,
        FACTOR_RIESGO_DESCENSO,
        PUNTOS_ABASTECIMIENTO

    from source

)

select * from renamed