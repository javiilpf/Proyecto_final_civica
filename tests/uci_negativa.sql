-- La categoría en la que se encuentra no puede ser negativa y tampoco 
-- La categoría UCI no puede ser negativa ni cero
SELECT id_categoria
FROM {{ ref('CATEGORIA_UCI') }}
WHERE id_categoria <= 0
   OR id_categoria > 10