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
            when 'MTB'          then 'MTB'
            when 'XCO_WORLD'    then 'XCO World'
            when 'XCO_REG'      then 'XCO Regional'
            when 'XCO_CONT'     then 'XCO Continental'
            when 'DH_WORLD'     then 'Descenso World'
            when 'EWS_PRO'      then 'Enduro World Series'
            when 'UCI_MARATHON' then 'Maratón UCI'
            when 'CX_WORLD'     then 'Ciclocross World'
            when 'CE'           then 'Campeonato Europa'
            when 'CN'           then 'Campeonato Nacional'
            when 'TRACK_ELITE'  then 'Pista Elite'
            when 'OLY'          then 'BMX Racing'
            when 'GRAVEL_PRO'   then 'Gravel Pro'
            when 'GRAVEL_AM'    then 'Gravel Amateur'
            when 'RUTA'         then 'Ruta'
            else initcap(replace(codigo, '_', ' '))
        end as descripcion,
        case codigo
            when 'MTB'          then 'MTB'
            when 'XCO_WORLD'    then 'MTB'
            when 'XCO_REG'      then 'MTB'
            when 'XCO_CONT'     then 'MTB'
            when 'DH_WORLD'     then 'MTB'
            when 'EWS_PRO'      then 'MTB'
            when 'UCI_MARATHON' then 'MTB'
            when 'CX_WORLD'     then 'Ciclocross'
            when 'CE'           then 'Ciclocross'
            when 'CN'           then 'Ciclocross'
            when 'TRACK_ELITE'  then 'Pista'
            when 'OLY'          then 'BMX'
            when 'GRAVEL_PRO'   then 'Gravel'
            when 'GRAVEL_AM'    then 'Gravel'
            when 'RUTA'         then 'Ruta'
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