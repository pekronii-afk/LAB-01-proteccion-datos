# Actividad 5 Analizar una finalidad secundaria

¿El hecho de que la organización ya tenga los datos significa automáticamente que puede utilizarlos para cualquier finalidad?
No, los datos se dieron para una finalidad, que era atender y facturar. Usarlos para promociones es otra finalidad y se tiene que revisar si es compatible y si el cliente fue informado o dio su consentimiento

¿Qué preguntas debería realizar la organización antes de implementar este tratamiento?
- ¿El aviso de privacidad dice que los datos se usan para promociones?
- ¿Se necesita el consentimiento del cliente?
- ¿El cliente se puede oponer o darse de baja?
- ¿Qué datos se ocupan de verdad para esto?
- ¿Quién va a tener acceso y por cuánto tiempo?
- ¿Se van a pasar los datos a otra empresa?

¿Qué datos serían realmente necesarios?
El correo para mandar la promoción y si acaso la ciudad o el rango de edad para segmentar. No se ocupa el RFC, el teléfono ni la edad exacta

¿Necesitaría el área de marketing acceso directo a clientes?
No, porque la tabla tiene datos que no le sirven como el RFC. Se le puede dar solo lo que ocupa y solo de los clientes que aceptaron recibir promociones

¿Qué controles técnicos podrían limitar la información entregada?
- Una vista con solo el correo, la ciudad y el rango de edad
- Un rol para marketing con permiso nada más sobre esa vista
- Un campo para saber quién aceptó promociones y filtrar con eso
- Registrar quién consulta esos datos
