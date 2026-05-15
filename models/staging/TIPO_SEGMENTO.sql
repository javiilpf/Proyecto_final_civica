with source as (
    select distinct
        upper(trim(tipo_segmento)) as codigo
    from {{ ref('stg_segmento_trayecto') }}
    where tipo_segmento is not null
),
renamed as (
    select
        codigo,
        initcap(replace(codigo, '_', ' ')) as descripcion,
        case codigo
            when 'TECNICO'          then true
            when 'DESCENSO'         then true
            when 'DESCENSO_TECNICO' then true
            when 'ENDURO'           then true
            else false
        end as es_tecnico,
        case codigo
            when 'DESCENSO'         then true
            when 'DESCENSO_TECNICO' then true
            when 'MIXTO_DH'         then true
            else false
        end as requiere_descenso
    from source
)
select
    row_number() over (order by codigo) as id_tipo_segmento,
    codigo,
    descripcion,
    es_tecnico,
    requiere_descenso
from renamed