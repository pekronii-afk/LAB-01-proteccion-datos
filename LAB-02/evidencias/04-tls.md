# 04 TLS

## Objetivo

Revisar si el servidor tiene TLS activado y si la conexión lo está usando

## Comando

Script `sql/03-verificacion-tls.sql`

```sql
SHOW ssl;
SHOW ssl_min_protocol_version;
SHOW port;
SHOW listen_addresses;

SELECT inet_client_addr(), inet_client_port();

SELECT ssl, version, cipher
FROM pg_stat_ssl
WHERE pid = pg_backend_pid();
```

## Resultado obtenido

| Consulta | Resultado |
|---|---|
| SHOW ssl | (pon aquí lo que salió) |
| SHOW ssl_min_protocol_version | (pon aquí lo que salió) |
| SHOW port | (pon aquí lo que salió) |
| SHOW listen_addresses | (pon aquí lo que salió) |
| inet_client_addr(), inet_client_port() | (pon aquí lo que salió) |
| pg_stat_ssl | (pon aquí lo que salió) |

## Análisis

**¿La conexión actual utiliza TLS?**
(sí o no, según lo que salió en pg_stat_ssl)

**¿Qué versión de TLS se está utilizando?**
(la columna version, si sale vacía pon que ninguna porque no usa TLS)

**¿Qué algoritmo de cifrado aparece?**
(la columna cipher, si sale vacía pon que ninguno)

**¿Qué diferencia existe entre una conexión protegida con TLS y una conexión sin TLS?**
Sin TLS lo que mandas viaja tal cual por la red y alguien que esté viendo el tráfico podría leer las consultas, los resultados y hasta contraseñas. Con TLS todo va cifrado, se nota si alguien lo modifica y puedes comprobar que te estás conectando al servidor correcto

Sobre sslmode

- require pide TLS pero no revisa que el servidor sea el correcto
- verify-ca además revisa que el certificado sea de una autoridad confiable
- verify-full además revisa que el nombre del servidor coincida con el certificado, es el más seguro

## Conclusión

TLS cuida los datos mientras viajan entre el cliente y el servidor, no los que están guardados
