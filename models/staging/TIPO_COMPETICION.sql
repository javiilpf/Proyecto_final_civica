with 

source as (

    select tipo from {{ ref('stg_competicion') }}

),

renamed as (

    select

    from source

)

select * from renamed