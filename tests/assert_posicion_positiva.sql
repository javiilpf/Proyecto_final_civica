-- Todo resultado debe tener posición >= 1 si no abandonó
select *
from {{ ref('RESULTADO') }}
where posicion_final < 1
  and abandono = false