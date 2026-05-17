-- El tiempo total debe ser mayor que 0
select *
from {{ ref('RESULTADO') }}
where tiempo_total_seg <= 0
  and abandono = false