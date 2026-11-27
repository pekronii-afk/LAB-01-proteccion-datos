# POL-02 Respaldo

| Campo | Contenido |
|---|---|
| Objetivo | Poder recuperar los datos si se pierden o se dañan |
| Alcance | Base `comercial` (PostgreSQL y MongoDB) y las bitácoras exportadas |
| Regla | Las bases de producción se respaldan cada día y la copia se guarda en un lugar distinto del servidor. Cada respaldo queda anotado con fecha, tamaño, hash y resultado. El procedimiento técnico se definirá en la Unidad V |
| Responsable | Decide el propietario del dato cuánto se puede perder, ejecuta el DBA |
| Excepciones | Si un respaldo falla, el DBA avisa ese mismo día y lo repite. No se puede saltar dos días seguidos sin aviso al propietario |
| Evidencia | Registro de respaldos con hash. Hoy no existe |
| Revisión | Cada 6 meses |
