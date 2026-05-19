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
            -- MTB
            when 'MTB'            then 'MTB'
            when 'XCO'            then 'MTB'
            when 'XCO_WORLD'      then 'MTB'
            when 'XCO_REG'        then 'MTB'
            when 'XCO_CONT'       then 'MTB'
            when 'DH_WORLD'       then 'MTB'
            when 'EWS_PRO'        then 'MTB'
            when 'EWS'            then 'MTB'
            when 'UCI_MARATHON'   then 'MTB'
            when 'MARATÓNMTB'     then 'MTB'
            when 'MARATÓNENDURO'  then 'MTB'
            -- Ciclocross
            when 'CX_WORLD'       then 'Ciclocross'
            when 'WC_CX'          then 'Ciclocross'
            when 'SERIE_CX'       then 'Ciclocross'
            when 'CE'             then 'Ciclocross'
            when 'CN'             then 'Ciclocross'
            -- Gravel
            when 'GRAVEL_PRO'     then 'Gravel'
            when 'GRAVEL_AM'      then 'Gravel'
            when 'GRAVEL'         then 'Gravel'
            -- Pista
            when 'TRACK_ELITE'    then 'Pista'
            when 'SIXDAYS'        then 'Pista'
            -- BMX
            when 'OLY'            then 'BMX'
            when 'OLIMPIADA'      then 'BMX'
            -- Ruta
            when 'CLASICA'        then 'Ruta'
            when 'ETAPAS'         then 'Ruta'
            when 'GT'             then 'Ruta'
            when 'CAMPEONATO'     then 'Ruta'
            when 'REGIONAL'       then 'Ruta'
            when 'COPAESPAÑA'     then 'Ruta'
            when 'GRANFONDO'      then 'Ruta'
            when 'INTERNACIONAL'  then 'Ruta'
            when 'POPULAR'        then 'Ruta'
            when 'ESPECIAL'       then 'Ruta'
            when 'WC'             then 'Ruta'
            when 'C1'             then 'Ruta'
            else                       'Ruta'
        end as disciplina,
        case codigo
            when 'MTB'            then 'MTB'
            when 'XCO'            then 'XCO Series UCI'
            when 'XCO_WORLD'      then 'XCO World'
            when 'XCO_REG'        then 'XCO Regional'
            when 'XCO_CONT'       then 'XCO Continental'
            when 'DH_WORLD'       then 'Descenso World'
            when 'EWS_PRO'        then 'Enduro World Series Pro'
            when 'EWS'            then 'Enduro World Series'
            when 'UCI_MARATHON'   then 'Maratón UCI'
            when 'MARATÓNMTB'     then 'Maratón MTB'
            when 'MARATÓNENDURO'  then 'Maratón Enduro'
            when 'CX_WORLD'       then 'Ciclocross World'
            when 'WC_CX'          then 'Ciclocross World Cup'
            when 'SERIE_CX'       then 'Serie Ciclocross'
            when 'CE'             then 'Campeonato Europa CX'
            when 'CN'             then 'Campeonato Nacional CX'
            when 'GRAVEL_PRO'     then 'Gravel Pro'
            when 'GRAVEL_AM'      then 'Gravel Amateur'
            when 'GRAVEL'         then 'Gravel'
            when 'TRACK_ELITE'    then 'Pista Elite'
            when 'SIXDAYS'        then 'Six Days'
            when 'OLY'            then 'BMX Racing'
            when 'OLIMPIADA'      then 'BMX Olímpico'
            when 'CLASICA'        then 'Clásica'
            when 'ETAPAS'         then 'Carrera por Etapas'
            when 'GT'             then 'Grand Tour'
            when 'CAMPEONATO'     then 'Campeonato'
            when 'REGIONAL'       then 'Regional'
            when 'COPAESPAÑA'     then 'Copa España'
            when 'GRANFONDO'      then 'GranFondo'
            when 'INTERNACIONAL'  then 'Internacional'
            when 'POPULAR'        then 'Popular'
            when 'ESPECIAL'       then 'Especial'
            when 'WC'             then 'World Cup'
            when 'C1'             then 'Categoría 1'
            else initcap(replace(codigo, '_', ' '))
        end as descripcion
    from source
)
select
    row_number() over (order by codigo) as id_tipo,
    codigo,
    descripcion,
    disciplina
from renamed