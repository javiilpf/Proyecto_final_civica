# 🚴 Proyecto Final Cívica — Data Engineering de Ciclismo

Proyecto de ingeniería de datos orientado a competiciones ciclistas profesionales. Construido con **dbt + Snowflake + Power BI**, implementando una arquitectura medallion (Bronze → Silver → Gold) para transformar data raw de telemetría, etapas y ciclistas en insights listos para visualizar.

---

## 🏗️ Arquitectura

```
PRO_BRONZE_DB (RAW)                 PRO_SILVER_DB (STAGING)                 PRO_GOLD_DB (MARTS)
───────────────────                 ───────────────────────                 ──────────────────────
Raw / Views             →           Tables (NORMALIZADO)          →         TABLES / INCREMENTALES
(Fuentes)                           (Limpieza y                             (Dimensiones y Facts para PBI)
                                    validaciones)                           DESNORMALIZADO
```

### Capas del modelo

| Capa | Base de datos | Materialización | Descripción |
|---|---|---|---|
| **Raw** | `PRO_BRONZE_DB` | View | Datos en bruto sin transformar |
| **Staging** | `PRO_SILVER_DB` | Table | Normalizado de datos, limpieza, tipado y validaciones |
| **Marts** | `PRO_GOLD_DB` | Table | Modelo estrella listo para el análisis de datos |

---

## 📁 Estructura del proyecto

```
Proyecto_final_civica/
│
├── models/
│   ├── raw/              # Vistas sobre las fuentes originales (Sin modelar, creada para mostrar el linaje en dbt completo)
│   ├── staging/          # Modelos de limpieza y estandarización para normalizar los datos y tener relaciones en las tablas
│   └── marts/            # Dimensiones y Facts desnormalizando la data de stagging según los casos de uso (Gold)
│       ├── dim_ciclista
│       ├── dim_etapa
│       ├── dim_competicion
│       ├── dim_categoria_uci
│       └── fact_telemetria_vuelta
│
├── tests/                # Validación de ciertos datos
├── snapshots/            # SCD Tipo 2 para dimensiones
├── seeds/                # Datos de referencia estáticos
├── dbt_project.yml       # Configuración proyecto
└── packages.yml
```

---

## 🧪 Tests de calidad

Se han implementado tests de auditoría para garantizar la integridad de los datos:

- **Frecuencia cardíaca**: `fc_max_bpm` debe estar entre 50 y 230 ppm
- **Categoría UCI**: `id_categoria` no puede ser negativa ni cero
- **Claves primarias**: unicidad y no nulos en todas las SKs
- **Claves foráneas**: integridad referencial entre Facts y Dimensiones

```bash
# Ejecutar solo los tests
dbt test

# Build completo con tests incluidos
dbt build --full-refresh
```

---

## 🛠️ Stack tecnológico

| Herramienta | Uso |
|---|---|
| **dbt Core** | Transformación y orquestación de modelos |
| **Snowflake** | Data Warehouse (Bronze / Silver / Gold) |
| **Power BI** | Visualización y dashboards |
| **dbt-utils** | Tests genéricos adicionales |
| **Git** | Control de versiones |

---

## 🚀 Cómo ejecutar el proyecto

### Requisitos previos
- dbt Core instalado (`pip install dbt-snowflake`)
- Acceso a Snowflake con perfil configurado en `~/.dbt/profiles.yml`

### Comandos principales

```bash
# Instalar dependencias
dbt deps

# Compilar modelos (sin ejecutar)
dbt compile

# Ejecutar todos los modelos
dbt run

# Ejecutar forzando reconstrucción completa
dbt run --full-refresh

# Ejecutar tests
dbt test

# Build completo (run + test + snapshot + seed)
dbt build --full-refresh

# Limpiar artefactos compilados
dbt clean
```

### Ejecutar por capas

```bash
# Solo staging
dbt run --select staging

# Solo marts (Gold)
dbt run --select marts

# Un modelo concreto y sus dependencias
dbt run --select +dim_ciclista
```

---

## 📊 Modelo de datos (Gold)

El modelo estrella en Gold está diseñado para ser consumido directamente por Power BI:

```
                    ┌──────────────────┐
                    │  FACT_TELEMETRIA │
                    │     _VUELTA      │
                    └────────┬─────────┘
                             │
          ┌──────────────────┼──────────────────┐
          │                  │                  │
   ┌──────▼──────┐   ┌───────▼──────┐   ┌──────▼──────┐
   │DIM_CICLISTA │   │  DIM_ETAPA   │   │DIM_COMPETICION│
   └─────────────┘   └──────────────┘   └─────────────┘
                             │
                    ┌────────▼────────┐
                    │DIM_CATEGORIA_UCI│
                    └─────────────────┘
```

---

## 👤 Autor

**Javier** — Proyecto Final Cívica 2024/2025
