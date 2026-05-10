with 

source as (

    select * from {{ ref('stg_inscripcion_popular') }}

),
renamed as (

    select
        _ID as _id_bronze,
        CLUB_LOCAL,
        MOTIVACION_PRINCIPAL,
        NIVEL_AUTOPERCIBIDO,
        TIPO_BICI_USADA,
        PRIMERA_VEZ_PRUEBA,
        FUENTE_CONOCIMIENTO,
        VALORACION_ORGANIZACION,
        VALORACION_RECORRIDO,
        REPETIRIA,
        KM_ENTRENADOS_SEMANA_PREV,
        ANOS_PRACTICANDO_MTB

    from source
)

select * from renamed