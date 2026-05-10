with 

source as (

    select * from {{ source('SILVER', 'TIPO_TERRENO') }}

),

renamed as (

    select

    from source

)

select * from renamed