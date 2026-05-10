with 

source as (

    select * from {{ ref('stg_competicion') }}

),

renamed as (

    select
        _id as _id_bronze,
        nombre,
        disciplina,
        ciudad,
        fecha_inicio,
        fecha_fin,
        temporada,
        organizador,
        circuito,
        distancia_total_km,
        num_participantes_inscritos,
        presupuesto_premios_eur,
        altitud_media_m,
        pct_tierra_natural,
        dificultad_tecnica,
        valoracion_media_corredores,
        num_voluntarios,
        transmision_online,
        patrocinador_local

    from source

)

select * from renamed