{% snapshot snp_ciclista %}

{{
    config(
        target_schema='SNAPSHOTS',
        target_database=env_var('DBT_ENVIRONMENTS', 'FAIL') ~ '_SILVER_DB',
        unique_key='id_ciclista',
        strategy='check',
        check_cols=[
            'id_equipo',
            'peso_kg',
            'disciplina',
            'categoria',
            'activo'
        ]
    )
}}

select * from {{ ref('CICLISTA') }}

{% endsnapshot %}