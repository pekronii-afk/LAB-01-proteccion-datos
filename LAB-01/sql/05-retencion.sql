SELECT *
FROM clientes
WHERE fecha_alta <
      CURRENT_DATE - INTERVAL '5 years';

SET ROLE soporte_joel_cuadras;

SELECT *
FROM v_clientes_soporte;


SELECT *
FROM clientes;

RESET ROLE;
