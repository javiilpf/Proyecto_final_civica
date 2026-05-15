with source as (
    select distinct
        upper(trim(tipo)) as codigo
    from {{ ref('stg_competicion') }}
    where tipo is not null
),
renamed as (
    select
        codigo,
        case codigo
            when 'MTB'        then 'MTB'
            when 'RUTA'       then 'Ruta'
            when 'CICLOCROSS' then 'Ciclocross'
            when 'PISTA'      then 'Pista'
            when 'BMX'        then 'BMX'
            when 'GRAVEL'     then 'Gravel'
            else initcap(replace(codigo, '_', ' '))
        end as descripcion,
        case codigo
            when 'MTB'        then 'MTB'
            when 'RUTA'       then 'Ruta'
            when 'CICLOCROSS' then 'Ciclocross'
            when 'PISTA'      then 'Pista'
            when 'BMX'        then 'BMX'
            when 'GRAVEL'     then 'Gravel'
            else 'Ruta'
        end as disciplina
    from source
)
select
    row_number() over (order by codigo) as id_tipo,
    codigo,
    descripcion,
    disciplina
from renamed