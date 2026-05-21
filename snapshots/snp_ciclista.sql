{% snapshot snp_ciclista %}

{{
    config(
        target_schema='SNAPSHOTS',
        target_database=env_var('DBT_ENVIRONMENTS', 'FAIL') ~ '_BRONZE_DB',
        unique_key='_ID',
        strategy='check',
        check_cols=[
                'NOMBRE',
                'APELLIDOS',
                'FECHA_NACIMIENTO',
                'NACIONALIDAD',
                'PESO_KG',
                'ALTURA_CM',
                'DISCIPLINA',
                'ESPECIALIDAD',
                'ACTIVO',
                'GENERO',
                'CATEGORIA',
                'PAIS_RESIDENCIA',
                'BICI_MARCA',
                'BICI_MODELO',
                'PALMARES_VICTORIAS',
                'ESTILO_PEDALEO',
                'LATERALIDAD',
                'ANOS_EXPERIENCIA'
        ]
    )
}}

select * from {{ ref('stg_ciclista') }}

{% endsnapshot %}