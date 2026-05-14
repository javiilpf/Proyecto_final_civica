with source as (
-- Los dos campos traen misma información, pero ninguna de las dos tablas tiene todos los registros diferentes, por lo que hago un union
-- Además es un union porque al estar sacando la información de silver no existen relaciones por lo que uno las tablas en la CTE.
    select categoria_uci
    from {{ ref('stg_competicion') }}
    union
    select categoria_uci
    from {{ ref('stg_equipo') }}
),
renamed as (
    -- En este caso me interesa que todos los nombres estén en mayúscula
    select distinct
        --Elimino los posibles espacios en blanco por delante y por detrás del texto y lo pongo en mayúscula
        upper(trim(categoria_uci)) as codigo
    from source
    where categoria_uci is not null
)
select
    codigo,
    case codigo
        -- Catelogo de los distintos niveles según el tipo de competición
        -- Máxima categoría
        when 'WORLDTOUR'     then 1
        when 'WT'            then 1
        when 'WORLDTEAM'     then 1
        when 'WC'            then 1
        when 'XCO_WORLD'     then 1
        when 'DH_WORLD'      then 1
        when 'CX_WORLD'      then 1
        when 'TRACK_ELITE'   then 1
        when 'OLY'           then 1
        -- PROSERIES
        when 'PROSERIES'     then 2
        when 'PROTEAM'       then 2
        when 'NC'            then 2
        when 'CE'            then 2
        when 'EWS_PRO'       then 2
        when 'UCI_ENDURO'    then 2
        -- UCI PRO SERIES
        when 'CONTINENTAL'   then 3
        when 'C1'            then 3
        when 'UCI_MARATHON'  then 3
        when 'XCO_REG'       then 3
        when 'XCO_CONT'      then 3
        when 'GRAVEL_PRO'    then 3
        -- NACIONALES
        when 'C2'            then 4
        when 'C3'            then 5
        -- NACIONALES MENOS IMPORTANTES
        when 'CN'            then 6
        when 'GRAVEL'        then 6
        -- REGIONAL
        when 'ABIERTA'       then 7
        when 'REG'           then 7
        -- ORGANIZACIONES
        when 'AMATEUR'       then 8
        when 'GRAVEL_AM'     then 8
    
        when 'INVITACIONAL'  then 9
        -- EL RESTO DE CATEGORIAS SERÁN TIPO 10 Y POR TANTO CONSIDERARADAS NO RELEVANTES
    else 10
end as nivel
from renamed