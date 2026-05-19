{{
    config(
        materialized='incremental',
        unique_key='SK_FECHA',
        pre_hook="CREATE SEQUENCE IF NOT EXISTS DEV_GOLD_DB.GOLD.SEQ_DIM_TIEMPO START 1 INCREMENT 1",
        incremental_strategy='merge'
    )
}}

with fechas_raw as (
    select 
        fecha_nacimiento  as fecha 
    from {{ ref('CICLISTA') }}  
    where 
        fecha_nacimiento is not null
    union
    select fecha_inicio      as fecha from {{ ref('COMPETICION') }} where fecha_inicio is not null
    union
    select fecha_fin         as fecha from {{ ref('COMPETICION') }} where fecha_fin is not null
    union
    select fecha             as fecha from {{ ref('ETAPA') }}     where fecha is not null
    union
    select fecha_medicion    as fecha from {{ ref('FORMA_FISICA') }} where fecha_medicion is not null
),

fechas_nuevas as (
    select distinct fecha::date as fecha
    from fechas_raw

    {% if is_incremental() %}
    where fecha::date not in (select FECHA from {{ this }})
    {% endif %}
),

final as (
    select
        DEV_GOLD_DB.GOLD.SEQ_DIM_TIEMPO.NEXTVAL    as SK_FECHA,
        fecha                                        as FECHA,
        year(fecha)                                  as ANIO,
        quarter(fecha)                               as TRIMESTRE,
        month(fecha)                                 as MES,
        case month(fecha)
            when 1  then 'Enero'
            when 2  then 'Febrero'
            when 3  then 'Marzo'
            when 4  then 'Abril'
            when 5  then 'Mayo'
            when 6  then 'Junio'
            when 7  then 'Julio'
            when 8  then 'Agosto'
            when 9  then 'Septiembre'
            when 10 then 'Octubre'
            when 11 then 'Noviembre'
            when 12 then 'Diciembre'
        end                                          as NOMBRE_MES,
        weekofyear(fecha)                            as SEMANA_ANIO,
        dayofweek(fecha)                             as DIA_SEMANA,
        case dayofweek(fecha)
            when 0 then 'Domingo'
            when 1 then 'Lunes'
            when 2 then 'Martes'
            when 3 then 'Miércoles'
            when 4 then 'Jueves'
            when 5 then 'Viernes'
            when 6 then 'Sábado'
        end                                          as NOMBRE_DIA,
        dayofweek(fecha) in (0, 6)                   as ES_FIN_SEMANA
    from fechas_nuevas
)

select * from final