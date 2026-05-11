with source as (
    select * from {{ ref('stg_ciclista') }}
),
equipo as (
    select id_equipo, _id_bronze from {{ ref('EQUIPO') }}
),
pais as (
    select id_pais, nombre from {{ ref('PAIS') }}
),
renamed as (
    select
        c._ID                       as _id_bronze,
        e.id_equipo                 as id_equipo,
        upper(trim(c.NOMBRE))       as nombre,
        upper(trim(c.APELLIDOS))    as apellidos,
        c.FECHA_NACIMIENTO          as fecha_nacimiento,
        pn.id_pais                  as id_nacionalidad,
        pr.id_pais                  as id_pais_residencia,
        c.PESO_KG                   as peso_kg,
        c.ALTURA_CM                 as altura_cm,
        c.DISCIPLINA                as disciplina,
        c.ESPECIALIDAD              as especialidad,
        c.ACTIVO                    as activo,
        coalesce(c.GENERO, 'U')     as genero,
        c.CATEGORIA                 as categoria,
        c.BICI_MARCA                as bici_marca,
        c.BICI_MODELO               as bici_modelo,
        c.PALMARES_VICTORIAS        as palmares_victorias,
        c.ESTILO_PEDALEO            as estilo_pedaleo,
        c.LATERALIDAD               as lateralidad,
        c.ANOS_EXPERIENCIA          as anos_experiencia
    from source c
    left join equipo e
        on c.ID_EQUIPO_FK = e._id_bronze
    left join pais pn
        on upper(trim(c.NACIONALIDAD)) = upper(trim(pn.nombre))
    left join pais pr
        on upper(trim(c.PAIS_RESIDENCIA)) = upper(trim(pr.nombre))
    qualify row_number() over (
        partition by upper(trim(c.NOMBRE)), upper(trim(c.APELLIDOS))
        order by c._INGESTED_AT desc
    ) = 1
)
select * from renamed