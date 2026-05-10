with competicion as (
    select pais as nombre_raw from {{ ref('stg_competicion') }} where pais is not null
),
equipo as (
    select pais as nombre_raw from {{ ref('stg_equipo') }} where pais is not null
),
ciclista as (
    select NACIONALIDAD     as nombre_raw from {{ ref('stg_ciclista') }} where NACIONALIDAD    is not null
    union all
    select PAIS_RESIDENCIA  as nombre_raw from {{ ref('stg_ciclista') }} where PAIS_RESIDENCIA is not null
),
source as (
    select nombre_raw from competicion
    union all
    select nombre_raw from equipo
    union all
    select nombre_raw from ciclista
),
normalizado as (
    select distinct
        case upper(trim(nombre_raw))
            when 'BAHRAIN'      then 'Bahréin'
            when 'TAIWAN'       then 'Taiwán'
            when 'UAE'          then 'Emiratos Árabes Unidos'
            when 'USA'          then 'Estados Unidos'
            when 'REP. CHECA'   then 'República Checa'
            else initcap(trim(nombre_raw))
        end as nombre
    from source
    where upper(trim(nombre_raw)) not in ('EUROPA', 'VARIOS', 'KENYA/GB', 'MAN/GB')
)
select * from normalizado