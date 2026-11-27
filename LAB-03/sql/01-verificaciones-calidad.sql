-- Actividad 1: verificaciones de calidad sobre clientes

INSERT INTO clientes (id, nombre, correo, telefono, rfc, ciudad) VALUES
(7, 'Ana Lopez', 'ANA.LOPEZ@example.test', '6671234567', 'LOAA850315AB', 'Culiacan'),
(8, 'Jorge Díaz', 'sin-correo', '667', NULL, 'Culiacán')
ON CONFLICT (id) DO NOTHING;

-- Posibles duplicados por correo
SELECT lower(correo) AS correo_normalizado,
       count(*) AS registros,
       string_agg(id::text, ', ') AS ids
FROM clientes
GROUP BY lower(correo)
HAVING count(*) > 1;

-- RFC ausente o con formato no válido
SELECT id, nombre, rfc
FROM clientes
WHERE rfc IS NULL
   OR rfc !~ '^[A-ZÑ&]{3,4}[0-9]{6}[A-Z0-9]{3}$';

-- Correo con formato no válido
SELECT id, nombre, correo
FROM clientes
WHERE correo !~ '^[^@\s]+@[^@\s]+\.[^@\s]+$';

-- Teléfono que no tiene 10 dígitos
SELECT id, nombre, telefono
FROM clientes
WHERE telefono !~ '^[0-9]{10}$';

-- Posibles duplicados por nombre (sin acentos ni mayúsculas)
SELECT translate(lower(nombre), 'áéíóúñ', 'aeioun') AS nombre_normalizado,
       string_agg(id::text, ', ' ORDER BY id) AS ids
FROM clientes
GROUP BY 1
HAVING count(*) > 1;

-- Completitud
SELECT count(*) AS total,
       count(*) FILTER (WHERE telefono IS NULL) AS sin_telefono,
       count(*) FILTER (WHERE rfc IS NULL) AS sin_rfc
FROM clientes;
