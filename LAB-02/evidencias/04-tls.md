# 04 TLS

## Objetivo

Revisar si el servidor y la conexión usan TLS

## Comando

`sql/03-verificacion-tls.sql`

## Resultado obtenido

- SHOW ssl: (pon aquí)
- SHOW ssl_min_protocol_version: (pon aquí)
- pg_stat_ssl (ssl, version, cipher): (pon aquí)

## Análisis

¿La conexión actual utiliza TLS?
(sí o no, según pg_stat_ssl)

¿Qué versión de TLS se está utilizando?
(la columna version, si sale vacía ninguna)

¿Qué algoritmo de cifrado aparece?
(la columna cipher, si sale vacía ninguno)

¿Qué diferencia existe entre una conexión protegida con TLS y una conexión sin TLS?
Sin TLS los datos viajan tal cual y alguien en la red los puede leer o cambiar, con TLS van cifrados y puedes comprobar que es el servidor correcto. require solo cifra, verify-ca revisa el certificado y verify-full también revisa el nombre del servidor

## Conclusión

TLS cuida los datos mientras viajan, no los que están guardados
