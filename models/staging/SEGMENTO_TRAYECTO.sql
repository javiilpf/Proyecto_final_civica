with 

source as (

    select * from {{ ref('stg_segmento_trayecto') }}

),
renamed as (

    select
        _id as _id_bronze,
        numero_segmento,
        tipo_segmento,
        tiempo_seg,
        distancia_m,
        desnivel_m,
        potencia_media_w,
        fc_media_bpm,
        velocidad_media_kmh,
        errores_linea,
        frenadas_bruscas

    from source

)

select * from renamed