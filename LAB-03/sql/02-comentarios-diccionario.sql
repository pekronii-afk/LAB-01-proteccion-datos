-- Actividad 3: diccionario dentro del motor

COMMENT ON TABLE clientes IS 'Clientes de Comercializadora Norte. Propietario: Gerencia Comercial. Custodio: DBA. Clasificación: confidencial (contiene datos personales).';
COMMENT ON COLUMN clientes.id IS 'Identificador interno del cliente. Generado por el sistema.';
COMMENT ON COLUMN clientes.nombre IS 'Nombre completo. Dato personal identificador directo.';
COMMENT ON COLUMN clientes.correo IS 'Correo de contacto. Dato personal. Uso: notificaciones al cliente.';
COMMENT ON COLUMN clientes.rfc IS 'RFC del cliente. Dato personal. Uso: facturación. Cambios auditados en auditoria.cambios_clientes.';
COMMENT ON COLUMN clientes.telefono IS 'Teléfono de contacto. Dato personal. Uso: contacto con el cliente.';
COMMENT ON COLUMN clientes.ciudad IS 'Ciudad del cliente. Uso: logística y reportes por zona.';
-- canal_alta se comenta en 04-registro-cambios.sql junto con el cambio CAM-2026-014
-- segmento quedó sin comentario (ver hallazgo H-06 del expediente)

-- Consulta del diccionario
SELECT c.ordinal_position          AS pos,
       c.column_name               AS columna,
       c.data_type                 AS tipo,
       c.character_maximum_length  AS longitud,
       c.is_nullable               AS acepta_nulos,
       c.column_default            AS valor_por_defecto,
       col_description('public.clientes'::regclass, c.ordinal_position) AS descripcion
FROM information_schema.columns c
WHERE c.table_schema = 'public'
  AND c.table_name = 'clientes'
ORDER BY c.ordinal_position;

-- Exportación a CSV (desde psql dentro del contenedor)
\pset format csv
\o /evidencias/lab03/diccionario-clientes.csv
SELECT c.column_name AS columna, c.data_type AS tipo, c.character_maximum_length AS longitud,
       c.is_nullable AS acepta_nulos,
       col_description('public.clientes'::regclass, c.ordinal_position) AS descripcion
FROM information_schema.columns c
WHERE c.table_schema = 'public' AND c.table_name = 'clientes'
ORDER BY c.ordinal_position;
\o
\pset format aligned
