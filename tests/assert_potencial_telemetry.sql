-- Potencia media no puede superar la máxima en ninguna vuelta
select *
from {{ ref('TELEMETRIA_VUELTA') }}
where potencia_media_w > potencia_max_w