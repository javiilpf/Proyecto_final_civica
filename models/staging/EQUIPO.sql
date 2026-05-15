with source as (
    select * from {{ ref('stg_equipo') }}
),
pais as (
    select id_pais, nombre from {{ ref('PAIS') }}
),
categoria_uci as (
    select id_categoria, codigo from {{ ref('CATEGORIA_UCI') }}
),
renamed as (
    select
        e._ID                as _id_bronze,
        e.NOMBRE             as nombre,
        p.id_pais            as id_pais,
        e.PRESUPUESTO_EUR    as presupuesto_eur,
        e.DIRECTOR_TECNICO   as director_tecnico,
        e.ANIO_FUNDACION     as anio_fundacion,
        c.id_categoria       as id_categoria_uci,
        e.DISCIPLINA         as disciplina,
        e.PATROCINADOR_PPAL  as patrocinador_ppal,
        e.ACTIVO             as activo
    from source e
    left join pais p
        on upper(trim(e.PAIS)) = upper(trim(p.nombre))
    left join categoria_uci c
        on upper(trim(e.CATEGORIA_UCI)) = upper(trim(c.codigo))
)
select
    row_number() over (order by _id_bronze) as id_equipo,
    *
from renamed