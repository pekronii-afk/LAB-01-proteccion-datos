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

Actividad 2, se creó clientes_soporte solo con id, nombre, correo y teléfono

¿Todos los campos son necesarios para atención al cliente?
No, solo nombre, correo y teléfono

¿Por qué soporte necesitaría conocer el RFC?
No lo necesita, eso es de facturación

¿Necesita conocer la edad?
No

¿Necesita conocer el código postal?
No

¿Qué principio de privacidad está relacionado con esta decisión?
Minimización de datos

## 5. Control de acceso

Actividad 3

¿Por qué esta información puede ser más apropiada para analítica que entregar directamente la tabla completa de clientes?
Porque solo ven cuántos clientes hay por ciudad y edad sin saber quién es cada uno

Actividad 4, se creó el rol analista con permiso solo a la vista v_analitica_clientes

¿Qué información puede consultar el rol?
La ciudad y el rango de edad

¿Puede consultar directamente clientes?
No, no tiene permiso sobre la tabla

¿Puede obtener nombre, correo y RFC?
No, la vista no tiene esas columnas

¿Qué principio de privacidad estás aplicando?
Minimización y limitación de finalidad

¿Qué principio de seguridad estás aplicando?
Mínimo privilegio

## 6. Derechos ARCO

Actividad 6 Derecho de acceso

¿Qué información adicional debería proporcionar la organización además del resultado de esta consulta?
Para qué se usan los datos, quién los tiene, si se pasaron a alguien y cuánto tiempo se guardan

Actividad 7 Derecho de rectificación

¿Cómo podría comprobarse que el cambio fue autorizado?
Con una solicitud del cliente aprobada por el área de privacidad

¿Debería registrarse quién realizó el cambio?
Sí, quién lo hizo y cuándo

¿Por qué la trazabilidad será importante?
Para saber si alguien cambió datos sin permiso

Actividad 8 Derecho de cancelación

Está en `evidencias/08-ciclo-vida.md`

Actividad 9 Derecho de oposición

¿Es necesario eliminar inmediatamente todos sus datos de la base?
No

- Qué se mantiene: lo que se ocupa para la operación y lo que pide la ley, como las facturas
- Qué deja de usarse: el dato para la finalidad a la que se opuso, por ejemplo promociones
- Cómo separar finalidades: un campo que marque que no quiere promociones y vistas que lo filtren
- Por qué no lo decide solo el DBA: porque es algo legal y de la empresa, el DBA solo hace la parte técnica

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
