with source as (
    select * from {{ ref('stg_competicion') }}
),
renamed as (
    select distinct
        initcap(trim(nivel)) as codigo,
        case upper(trim(nivel))
            when 'INTERNACIONAL' then 1
            when 'ELITE'         then 2
            when 'NACIONAL'      then 3
            when 'SUB23'         then 4
            when 'JUNIOR'        then 5
            when 'MASTERS'       then 6
            when 'REGIONAL'      then 7
            when 'PROVINCIAL'    then 8
            when 'LOCAL'         then 9
            when 'AMATEUR'       then 10
            when 'POPULAR'       then 11
            when 'OPEN'          then 12
            else 99
        end as orden
    from source
    where nivel is not null
)
select
    row_number() over (order by orden, codigo) as id_nivel,
    codigo,
    orden
from renamed
