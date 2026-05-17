{% snapshot snp_equipo %}

{{
    config(
        target_schema='SNAPSHOTS',
        target_database=env_var('DBT_ENVIRONMENTS', 'FAIL') ~ '_SILVER_DB',
        unique_key='id_equipo',
        strategy='check',
        check_cols=[
            'id_categoria_uci',
            'presupuesto_eur',
            'director_tecnico',
            'activo'
        ]
    )
}}

select * from {{ ref('EQUIPO') }}

{% endsnapshot %}