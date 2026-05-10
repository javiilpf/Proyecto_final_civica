with 

source as (

    select * from {{ source('RAW', 'TIPO_SEGMENTO') }}

),

renamed as (

    select

    from source

)

select * from renamed