{% snapshot snp_equipo %}

{{
    config(
        target_schema='SNAPSHOTS',
        target_database=env_var('DBT_ENVIRONMENTS', 'FAIL') ~ '_BRONZE_DB',
        unique_key='_ID',
        strategy='check',
        check_cols=[
            'NOMBRE',
            'PAIS',
            'PRESUPUESTO_EUR',
            'DIRECTOR_TECNICO',
            'ANIO_FUNDACION',
            'CATEGORIA_UCI',
            'DISCIPLINA',
            'PATROCINADOR_PPAL',
            'ACTIVO'

        ]
    )
}}

select * from {{ ref('stg_equipo') }}

{% endsnapshot %}