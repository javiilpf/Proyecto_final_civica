with 

source as (

    select * from {{ ref('stg_equipo') }}

),

renamed as (

    select
        _ID as __id_bronze,
        _SOURCE,
        NOMBRE,
        PRESUPUESTO_EUR,
        DIRECTOR_TECNICO,
        ANIO_FUNDACION,
        DISCIPLINA,
        PATROCINADOR_PPAL,
        ACTIVO

    from source

)

select * from renamed