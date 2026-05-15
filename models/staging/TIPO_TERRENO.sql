with source as (
    select tipo_terreno from {{ ref('stg_etapa') }}
    union
    select tipo_terreno from {{ ref('stg_resultado') }}
),
normalizado as (
    select distinct
        case upper(trim(tipo_terreno))
            when 'ADOQUIN/ASFALTO'      then 'ADOQUIN_ASFALTO'
            when 'ADOQUIN/PAVÉ'         then 'ADOQUIN_PAVE'
            when 'ADOQUÍN'              then 'ADOQUIN'
            when 'ADOQUÍN/TIERRA'       then 'ADOQUIN_TIERRA'
            when 'ARENA/TÉCNICO'        then 'ARENA_TECNICO'
            when 'ASFALTO'              then 'ASFALTO'
            when 'ASFALTO LLANO'        then 'ASFALTO_LLANO'
            when 'ASFALTO MONTAÑA'      then 'ASFALTO_MONTANA'
            when 'ASFALTO/GRAVA'        then 'ASFALTO_GRAVA'
            when 'BARRO/ADOQUÍN'        then 'BARRO_ADOQUIN'
            when 'BARRO/BOSQUE'         then 'BARRO_BOSQUE'
            when 'BARRO/ENDURO'         then 'BARRO_ENDURO'
            when 'BARRO/HIERBA'         then 'BARRO_HIERBA'
            when 'BOSCOSO/BARRO'        then 'BOSCOSO_BARRO'
            when 'BOSCOSO/HIERBA'       then 'BOSCOSO_HIERBA'
            when 'BOSCOSO/ROCA'         then 'BOSCOSO_ROCA'
            when 'BOSCOSO/TIERRA'       then 'BOSCOSO_TIERRA'
            when 'CAMINO TIERRA'        then 'CAMINO_TIERRA'
            when 'CONTRARRELOJ ASFALTO' then 'CONTRARRELOJ_ASFALTO'
            when 'DIRT TRACK'           then 'DIRT_TRACK'
            when 'GRAVA/ASFALTO'        then 'GRAVA_ASFALTO'
            when 'GRAVA/TIERRA'         then 'GRAVA_TIERRA'
            when 'HIERBA/ARENA'         then 'HIERBA_ARENA'
            when 'MIXTO'                then 'MIXTO'
            when 'MIXTO DH'             then 'MIXTO_DH'
            when 'MIXTO XCO'            then 'MIXTO_XCO'
            when 'MIXTO CX'             then 'MIXTO_CX'
            when 'MIXTO GRAVA'          then 'MIXTO_GRAVEL'
            when 'MIXTO GRAVEL'         then 'MIXTO_GRAVEL'
            when 'MIXTO TÉCNICO'        then 'MIXTO_TECNICO'
            when 'OFFROAD GRAVEL'       then 'OFFROAD_GRAVEL'
            when 'PIEDRA/TÉCNICO'       then 'PIEDRA_TECNICO'
            when 'PISTA BMX'            then 'PISTA_BMX'
            when 'PISTA CUBIERTA'       then 'PISTA_CUBIERTA'
            when 'PISTA FORESTAL'       then 'PISTA_FORESTAL'
            when 'PISTAS FORESTALES'    then 'PISTA_FORESTAL'
            when 'ROCOSO/BOSQUE'        then 'ROCOSO_BOSQUE'
            when 'ROCOSO/TÉCNICO'       then 'ROCOSO_TECNICO'
            when 'TIERRA/PIEDRA'        then 'TIERRA_PIEDRA'
            when 'TIERRA/SECO'          then 'TIERRA_SECO'
            when 'TÉCNICO/BARRO'        then 'TECNICO_BARRO'
            when 'VELÓDROMO OLÍMPICO'   then 'VELODROMO_OLIMPICO'
            else upper(replace(trim(tipo_terreno), ' ', '_'))
        end as codigo
    from source
    where tipo_terreno is not null
)
select
    row_number() over (order by codigo) as id_terreno,
    codigo,
    initcap(replace(codigo, '_', ' ')) as descripcion
from normalizado
