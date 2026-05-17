-- La frecuencia cardiaca nunca puede ser inferior a 50 ni superior a 230 ppm
SELECT fc_max_bpm
FROM {{ ref('TELEMETRIA_VUELTA') }}
WHERE fc_max_bpm < 50
   OR fc_max_bpm > 230