# Informe LAB-04 Hardening

20321619_joel_cuadras

1. ¿Cuál era la principal superficie de ataque?
Que escuchaba en todas las interfaces con listen_addresses en '*'

2. ¿Qué configuración representaba el mayor riesgo?
listen_addresses en '*'

3. ¿Qué cambio produjo la mayor reducción de exposición?
Ponerlo en 'localhost'

4. ¿Qué diferencia existe entre firewall y pg_hba.conf?
El firewall bloquea antes de llegar a PostgreSQL y pg_hba.conf decide quién se autentica

5. ¿Qué diferencia existe entre autenticación y autorización?
Autenticación es quién eres y autorización es qué puedes hacer

6. ¿Por qué una cuenta de aplicación no debe ser SUPERUSER?
Porque si atacan la app pueden hacer de todo

7. ¿Por qué cambiar el puerto de PostgreSQL no constituye hardening suficiente?
Porque con un escaneo lo encuentran igual

8. ¿Por qué listen_addresses='*' puede ser innecesario?
Porque si solo te conectas desde la misma compu no ocupas las demás interfaces

9. ¿Qué papel tiene el sistema operativo en la seguridad de PostgreSQL?
Ahí están los archivos, si alguien los lee se brinca los permisos de PostgreSQL

10. ¿Qué controles deberían revisarse periódicamente?
pg_hba.conf, listen_addresses, roles, extensiones, TLS, permisos de archivos y actualizaciones

## Reflexión

¿Qué cambiarías primero si recibieras la responsabilidad de asegurar un servidor PostgreSQL que ya se encuentra funcionando en producción?

Primero cerraría el acceso de red con el firewall y pg_hba.conf, porque es lo que más baja el riesgo. Antes revisaría qué conexiones se usan para no tumbar la app, y lo haría en un horario de mantenimiento. Después quitaría los permisos de administrador a la cuenta de la app, y al final vería TLS
