with 

source as (

    select tipo_segmento from {{ ref('stg_segmento_trayecto') }}

),

renamed as (

    select
        *
    from source

)

select * from renamed