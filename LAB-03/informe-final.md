# LAB-03 Privacidad, cumplimiento y gobierno de los datos

20321619_joel_cuadras

## 1. Introducción

En los labs pasados protegimos los datos, en este se vio si de verdad se ocupa tener cada dato, para qué se usa, quién lo ve y cuánto tiempo se guarda

## 2. Inventario de datos

Casi todos los campos de clientes son datos personales. Nombre, correo, teléfono y RFC identifican directo a la persona y edad, ciudad y código postal juntos también (`evidencias/01-inventario-datos.md`)

## 3. Finalidades

- Atención: nombre, correo y teléfono
- Facturación: nombre, RFC y código postal
- Analítica: ciudad y rango de edad agrupados
- DBA: administra pero no usa los datos

## 4. Minimización

Soporte no ocupa el RFC, la edad ni el código postal, por eso clientes_soporte solo tiene id, nombre, correo y teléfono

## 5. Control de acceso

A analítica se le dan datos agrupados en vez de la tabla completa. El rol analista solo puede ver la vista v_analitica_clientes, que tiene ciudad y rango de edad, no puede consultar clientes ni ver nombre, correo o RFC. Aquí se aplica minimización y mínimo privilegio

## 6. Derechos ARCO

- Acceso: además de los datos hay que decirle al cliente para qué se usan y quién los tiene
- Rectificación: se cambió solo el correo y debería quedar registrado quién lo cambió y que estaba autorizado
- Cancelación: antes de borrar hay que ver en qué otros lados está el dato (`evidencias/08-ciclo-vida.md`)
- Oposición: no se borra todo, solo se deja de usar el dato para eso, por ejemplo con un campo que lo marque. Eso no lo decide solo el DBA

## 7. Retención

No se debe guardar todo para siempre, el plazo depende de para qué se usa el dato y de lo que pida la ley (`evidencias/10-retencion.md`)

## 8. Gobierno de datos

Cada dato tiene un área responsable y solo lo ven las áreas que lo ocupan. La matriz está en `evidencias/11-gobierno-datos.md` y la tabla de controles técnicos y administrativos en `evidencias/12-privacidad-diseno.md`

## 9. Evaluación integral

Lo más grave es que analítica ve la tabla completa, que se guardan datos de hace 12 años y que desarrollo tiene copias con datos reales (`evidencias/14-evaluacion-integral.md` y `evidencias/15-arquitectura.md`)

## 10. Conclusiones

Aprendí que seguridad y privacidad no son lo mismo, una base puede estar protegida y aun así guardar datos de más. El DBA hace la parte técnica pero las decisiones de finalidad y retención son de otras áreas

## Preguntas de reflexión

1. ¿Una base de datos técnicamente segura necesariamente cumple con todos los requisitos de privacidad?
No, puede guardar datos de más o usarlos para otra cosa

2. ¿Por qué el principio de mínimo privilegio también contribuye a la privacidad?
Porque menos gente ve los datos personales

3. ¿Por qué el DBA no debería decidir por sí solo la finalidad del tratamiento de los datos?
Porque depende de la ley y de la empresa, el DBA solo hace la parte técnica

4. ¿Por qué los desarrolladores no deberían recibir automáticamente copias completas de bases de datos productivas?
Porque para probar no ocupan datos reales

5. ¿Por qué una copia utilizada para desarrollo también puede representar un riesgo de privacidad?
Porque tiene los mismos datos pero con menos protección

6. ¿Por qué la retención debe formar parte del ciclo de vida de los datos?
Porque los datos no se deben guardar para siempre

7. ¿Qué relación existe entre privacidad por diseño y diseño de bases de datos?
Que desde que se hacen las tablas se decide qué datos se guardan

8. ¿Qué controles técnicos implementarías para reducir el riesgo de exposición de datos personales?
Roles, vistas, cifrado, enmascaramiento y auditoría

9. ¿Qué información debería conocer un DBA para responder técnicamente a una solicitud ARCO?
En qué tablas, respaldos y copias está el dato y qué le autorizaron hacer

10. ¿Qué responsabilidades deberían corresponder al DBA, al responsable de privacidad, al área jurídica y al propietario de los datos?
El DBA aplica los controles, privacidad atiende las solicitudes, jurídico dice qué pide la ley y el propietario decide para qué se usan los datos
