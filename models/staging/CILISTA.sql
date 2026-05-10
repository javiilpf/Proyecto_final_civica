with source as (
    select * from {{ ref('stg_ciclista') }}
),
renamed as (
    select
        _ID                     as _id_bronze,
        ID_EQUIPO_FK            as id_equipo,
        upper(trim(NOMBRE))     as nombre,
        upper(trim(APELLIDOS))  as apellidos,
        FECHA_NACIMIENTO        as fecha_nacimiento,
        NACIONALIDAD            as id_nacionalidad,
        PAIS_RESIDENCIA         as id_pais_residencia,
        PESO_KG                 as peso_kg,
        ALTURA_CM               as altura_cm,
        DISCIPLINA              as disciplina,
        ESPECIALIDAD            as especialidad,
        ACTIVO                  as activo,
        coalesce(GENERO, 'U')   as genero,
        CATEGORIA               as categoria,
        BICI_MARCA              as bici_marca,
        BICI_MODELO             as bici_modelo,
        PALMARES_VICTORIAS      as palmares_victorias,
        ESTILO_PEDALEO          as estilo_pedaleo,
        LATERALIDAD             as lateralidad,
        ANOS_EXPERIENCIA        as anos_experiencia
    from source
    qualify row_number() over (
        partition by upper(trim(NOMBRE)), upper(trim(APELLIDOS))
        order by _INGESTED_AT desc
    ) = 1
)
select * from renamed