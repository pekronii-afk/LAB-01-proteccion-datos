# LAB-02 Cifrado, credenciales y comunicaciones seguras

20321619_joel_cuadras

## 1. Introducción

En el laboratorio pasado vimos quién puede ver los datos, pero eso no basta si las contraseñas están guardadas tal cual, si los datos sensibles no están cifrados, si la conexión no está protegida o si las claves están escritas en el código. En este laboratorio se trabajó con eso usando pgcrypto y revisando TLS en PostgreSQL

## 2. Protección de credenciales

- **Texto claro:** la contraseña se guarda tal cual y cualquiera que vea la tabla la puede leer
- **Hash:** la contraseña se convierte en otra cosa de la que ya no se puede sacar la original. Con crypt() y gen_salt('bf') se usa bcrypt con sal, por eso la misma contraseña sale diferente cada vez. Para comprobarla se le saca el hash otra vez y se compara
- **Cifrado:** se puede regresar con la clave, por eso no se usa para contraseñas, porque si alguien consigue la clave las saca todas

## 3. Protección de datos sensibles

Se cifró el RFC con pgp_sym_encrypt() porque es un dato personal que la empresa sí ocupa recuperar a veces. En la tabla se ve como un montón de caracteres que no se entienden y solo con la clave correcta se recupera con pgp_sym_decrypt(), si pones otra clave sale error

## 4. TLS

TLS sirve para que los datos que viajan entre el cliente y el servidor no los pueda leer ni cambiar nadie en la red, y con verify-full también compruebas que te estás conectando al servidor correcto. En PostgreSQL se revisó con SHOW ssl y con pg_stat_ssl si el servidor tiene TLS activado y si la conexión lo estaba usando

## 5. Gestión de claves

Las claves no se guardan junto con los scripts porque cualquiera que vea el código las puede usar para descifrar los datos, y si se suben al repositorio se quedan en el historial aunque las borres. En este laboratorio nada más se usó la clave de prueba CLAVE-DE-PRUEBA

## 6. Resultados

- En la tabla insegura se ve la contraseña Password123 tal cual
- El hash con crypt() sale diferente cada vez por la sal, y al comprobar salió true con la contraseña correcta y false con la incorrecta
- El RFC cifrado no se puede leer y solo se recupera con la clave correcta
- TLS en el servidor: (pon aquí si salió on u off)

## 7. Problemas encontrados

- El servidor de la escuela no dejaba conectarse porque se llenaron las conexiones, entonces la práctica se hizo en un PostgreSQL instalado en la compu
- En un PostgreSQL local TLS viene apagado por defecto, por eso SHOW ssl puede salir en off

## 8. Conclusiones

Aprendí que la seguridad de una base de datos no es nada más poner permisos. Las contraseñas se guardan con hash, los datos sensibles se pueden cifrar, la conexión se protege con TLS y las claves se guardan aparte del código. En una empresa de verdad usaría hash para las contraseñas, cifraría los datos sensibles y los respaldos, obligaría TLS con verify-full y guardaría las claves en un gestor de secretos

## Preguntas de reflexión

**1. ¿Por qué una contraseña no debe almacenarse como texto claro?**
Porque cualquiera que vea la tabla o un respaldo tendría todas las contraseñas y podría entrar como quien sea

**2. ¿Por qué un hash no es equivalente a un cifrado?**
Porque el hash no se puede regresar y el cifrado sí, con la clave

**3. ¿Por qué el cifrado de una columna no sustituye al control de acceso?**
Porque si alguien tiene permiso y también tiene la clave puede ver todo, y el cifrado no evita que borren o cambien los datos

**4. ¿Por qué TLS no sustituye a los mecanismos de autorización de PostgreSQL?**
Porque TLS nada más cuida la conexión, ya adentro lo que puedes hacer lo deciden los permisos

**5. ¿Qué ocurriría si una organización pierde una clave utilizada para cifrar información?**
Ya no podría recuperar los datos cifrados con esa clave, se perderían

**6. ¿Qué ocurriría si una clave criptográfica se publica accidentalmente en GitLab?**
Cualquiera podría descifrar los datos, habría que cambiar la clave y cifrar todo de nuevo porque aunque la borres sigue en el historial

**7. ¿Por qué un repositorio privado no debe considerarse un almacén de secretos?**
Porque lo ven varias personas, se clona en otras compus, guarda todo el historial y si le roban la cuenta a alguien ya tienen todo

**8. ¿Qué diferencia existe entre proteger información almacenada y proteger información durante su transmisión?**
La guardada se protege cifrando el disco, las columnas o los respaldos, y la que viaja se protege con TLS

**9. ¿Por qué la gestión de claves es tan importante como el algoritmo criptográfico?**
Porque aunque el algoritmo sea muy bueno, si se filtra la clave cualquiera puede descifrar todo

**10. ¿Qué mecanismo adicional implementarías en una organización para proteger los respaldos de las bases de datos?**
Cifrar los respaldos con una clave guardada aparte, guardarlos en otro lugar con acceso restringido y probar seguido que sí se puedan restaurar
