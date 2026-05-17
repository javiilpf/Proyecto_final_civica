-- FTP y VO2max deben estar en rangos razonables
select *
from {{ ref('FORMA_FISICA') }}
where ftp_w < 50 or ftp_w > 600
   or vo2max < 30 or vo2max > 100