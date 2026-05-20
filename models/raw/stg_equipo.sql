{{config(materialized='table')}}  


with source as (

    select * from {{ source('RAW', 'EQUIPO') }}

),


renamed as (
    select
        _ID,
        _SOURCE,
        _INGESTED_AT,
        NOMBRE,
        PAIS,
        PRESUPUESTO_EUR,
        DIRECTOR_TECNICO,
        ANIO_FUNDACION,
        CATEGORIA_UCI,
        DISCIPLINA,
        PATROCINADOR_PPAL,
        ACTIVO

    from source

)

select * from renamed