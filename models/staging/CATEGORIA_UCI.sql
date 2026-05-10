with source as (
    select categoria_uci
    from {{ ref('stg_competicion') }}
    union
    select categoria_uci
    from {{ ref('stg_equipo') }}
),
renamed as (
    select distinct
        upper(trim(categoria_uci)) as codigo
    from source
    where categoria_uci is not null
)
select
    codigo,
    case codigo
        when 'WORLDTOUR'     then 1
        when 'WT'            then 1
        when 'WORLDTEAM'     then 1
        when 'WC'            then 1
        when 'XCO_WORLD'     then 1
        when 'DH_WORLD'      then 1
        when 'CX_WORLD'      then 1
        when 'TRACK_ELITE'   then 1
        when 'OLY'           then 1
    
        when 'PROSERIES'     then 2
        when 'PROTEAM'       then 2
        when 'NC'            then 2
        when 'CE'            then 2
        when 'EWS_PRO'       then 2
        when 'UCI_ENDURO'    then 2
    
        when 'CONTINENTAL'   then 3
        when 'C1'            then 3
        when 'UCI_MARATHON'  then 3
        when 'XCO_REG'       then 3
        when 'XCO_CONT'      then 3
        when 'GRAVEL_PRO'    then 3
    
        when 'C2'            then 4
        when 'C3'            then 5
    
        when 'CN'            then 6
        when 'GRAVEL'        then 6
    
        when 'ABIERTA'       then 7
        when 'REG'           then 7
    
        when 'AMATEUR'       then 8
        when 'GRAVEL_AM'     then 8
    
        when 'INVITACIONAL'  then 9

    else 10
end as nivel
from renamed