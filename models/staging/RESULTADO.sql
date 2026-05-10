with 

source as (

    select * from {{ ref('stg_resultado') }}

),

renamed as (

    select
       _ID as _id_bronze,
        DORSAL,
        POSICION_FINAL,
        TIEMPO_TOTAL_SEG,
        DIFERENCIA_SEG,
        ABANDONO,
        MOTIVO_ABANDONO,
        PUNTOS_UCI,
        TEMPERATURA_C,
        HUMEDAD_PCT,
        VIENTO_KMH,
        LLUVIA_MM,
        CONDICION_METEO,
        TIPO_TERRENO,
        DISTANCIA_KM,
        DESNIVEL_POS_M,
        EFICIENCIA_ENERGETICA,
        INDICE_PACING,
        PENALIZACION_SEG,
        CAIDAS_REPORTADAS,
        BONIFICACION_SEG,
        PORCENTAJE_COMPLETADO,
        POSICION_TOP10

    from source

)

select * from renamed