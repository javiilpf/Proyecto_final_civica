with source as (
    select * from {{ ref('stg_inscripcion_popular') }}
),
resultado as (
    select id_resultado, _id_bronze from {{ ref('RESULTADO') }}
),
competicion as (
    select id_competicion, _id_bronze from {{ ref('COMPETICION') }}
),
ciclista as (
    select id_ciclista, _id_bronze from {{ ref('CICLISTA') }}
),
renamed as (
    select
        i._ID                       as _id_bronze,
        r.id_resultado              as id_resultado,
        co.id_competicion           as id_competicion,
        ci.id_ciclista              as id_ciclista,
        i.CLUB_LOCAL                as club_local,
        i.MOTIVACION_PRINCIPAL      as motivacion_principal,
        i.NIVEL_AUTOPERCIBIDO       as nivel_autopercibido,
        i.TIPO_BICI_USADA           as tipo_bici_usada,
        i.PRIMERA_VEZ_PRUEBA        as primera_vez_prueba,
        i.FUENTE_CONOCIMIENTO       as fuente_conocimiento,
        i.VALORACION_ORGANIZACION   as valoracion_organizacion,
        i.VALORACION_RECORRIDO      as valoracion_recorrido,
        i.REPETIRIA                 as repetiria,
        i.KM_ENTRENADOS_SEMANA_PREV as km_entrenados_semana_prev,
        i.ANOS_PRACTICANDO_MTB      as anos_practicando_mtb
    from source i
    left join resultado r
        on i.ID_RESULTADO_FK = r._id_bronze
    left join competicion co
        on i.ID_COMPETICION_FK = co._id_bronze
    left join ciclista ci
        on i.ID_CICLISTA_FK = ci._id_bronze
)
select
    row_number() over (order by _id_bronze) as id_inscripcion,
    *
from renamed