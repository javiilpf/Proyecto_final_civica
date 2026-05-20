{{config(materialized='table')}}  


with source as (

    select * from {{ source('RAW', 'CICLISTA') }}

),


renamed as (
    select
        _ID,
        _SOURCE,
        _INGESTED_AT,
        ID_EQUIPO_FK,
        NOMBRE,
        APELLIDOS,
        FECHA_NACIMIENTO,
        NACIONALIDAD,
        PESO_KG,
        ALTURA_CM,
        DISCIPLINA,
        ESPECIALIDAD,
        ACTIVO,
        GENERO,
        CATEGORIA,
        EQUIPO_NOMBRE,
        PAIS_RESIDENCIA,
        BICI_MARCA,
        BICI_MODELO,
        PALMARES_VICTORIAS,
        ESTILO_PEDALEO,
        LATERALIDAD,
        ANOS_EXPERIENCIA

    from source

)

select * from renamed