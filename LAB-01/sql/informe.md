# Informe LAB-01 Protección y privacidad de datos

Cuadras Renteria Joel - Grupo 4-1

## 19.1 Clasificación

Casi todos los datos de la tabla clientes hay que cuidarlos porque son de personas. Los que más hay que proteger son el nombre, el correo, el teléfono y el RFC porque con cualquiera de esos ya sabes quién es la persona. La edad, la ciudad y el código postal no te dicen quién es de una, pero si los juntas sí puedes llegar a la persona, sobre todo si son pocos clientes como aquí

## 19.2 Enmascaramiento

**Qué se ocultó:** una parte del correo, del teléfono y del RFC, se les pusieron asteriscos y nada más se ve un pedacito

**Para quién:** para el rol de soporte

**Por qué:** porque los de soporte necesitan saber quién es el cliente para atenderlo pero no tienen por qué ver todos sus datos completos, con ver los últimos números del teléfono ya pueden confirmar que es la persona

**Qué mecanismo se usó:** una vista que muestra los datos ya con asteriscos. Al rol de soporte solo le dimos permiso de ver la vista y le quitamos el permiso de la tabla clientes con REVOKE, entonces si intenta ver la tabla le sale error

## 19.3 Seudonimización

**Cómo se generaron los tokens:** con gen_random_uuid(), que le da un código random a cada cliente

**Dónde está el mapa:** en la tabla pii.mapa_cliente, que está en otro esquema aparte del de analítica

**Quién debería poder entrar al mapa:** nada más el administrador o alguien que tenga permiso, el analista no

**Por qué se separaron los permisos:** porque si el analista pudiera ver el mapa y los datos de analítica al mismo tiempo podría juntar todo y saber quién es cada cliente, y entonces no tendría caso haberle puesto tokens

## 19.4 Anonimización

**Qué identificadores se eliminaron:** el nombre, el correo, el teléfono, el RFC y el id, en los resultados ya nada más salen grupos y conteos

**Qué atributos se generalizaron:** la edad se puso en rangos y el código postal se dejó solo con los primeros números

**Qué grupos se suprimieron:** los que tenían menos de 5 personas, y como solo hay 5 clientes se suprimieron todos. En el reto hicimos los rangos más grandes y ya salió un grupo con los 5

**Qué riesgo queda:** como son muy poquitos datos cualquier grupo chiquito se puede relacionar con una persona, y además la tabla original sigue ahí con todo

## 19.5 Retención

**Criterio:** se tomaron 5 años contando desde la fecha de alta del cliente

**Qué se debería conservar:** los datos de los clientes que siguen activos y lo que pida la ley

**Qué se podría eliminar:** los datos de clientes que ya no tienen nada que ver con la empresa y que ya pasaron los 5 años

**Qué controles debería haber antes de borrar:** que alguien responsable lo autorice, sacar un respaldo antes, anotar qué se borró y quién lo hizo, y tener forma de regresar los datos por si se borra algo por error

## 19.6 Conclusiones

**¿Qué técnica usarías para soporte?**
Enmascaramiento, porque tienen que saber quién es el cliente pero no ocupan ver todo

**¿Qué técnica usarías para analítica?**
Seudonimización, porque pueden trabajar con los datos sin saber de quién son

**¿Qué técnica usarías para publicar estadísticas?**
Anonimización, porque nada más se publican números y grupos, no personas

**¿Por qué ninguna sustituye al control de acceso?**
Porque los datos originales siguen en la base, entonces si alguien tiene permiso de ver la tabla o el mapa se brinca todo lo demás. Las técnicas cuidan lo que se muestra pero los permisos son los que deciden quién puede entrar

## 20. Preguntas de reflexión

**1. ¿Cuál es la diferencia entre enmascaramiento y seudonimización?**
En el enmascaramiento nada más se tapa una parte del dato pero igual sabes quién es la persona. En la seudonimización le cambias la identidad por un código y lo que conecta el código con la persona se guarda aparte

**2. ¿Por qué la seudonimización no significa anonimización?**
Porque con el mapa todavía puedes saber quién es la persona

**3. ¿Por qué eliminar nombre y RFC no garantiza que un conjunto de datos sea anónimo?**
Porque quedan cosas como la edad, la ciudad y el código postal y si las juntas puedes saber quién es

**4. ¿Qué función tienen los cuasi-identificadores?**
Son datos que solitos no dicen quién eres pero juntándolos con otros sí

**5. ¿Por qué es importante separar el mapa de seudonimización?**
Porque el mapa es como la llave, si cualquiera lo puede ver los tokens ya no sirven de nada

**6. ¿Qué principio de seguridad se aplica al impedir que el analista acceda al mapa?**
Separación de funciones y mínimo privilegio

**7. ¿Por qué una vista puede ser preferible a entregar acceso directo a la tabla?**
Porque con la vista tú decides qué columnas se ven y cómo se ven, y el usuario no ocupa tener permiso en la tabla

**8. ¿Qué diferencia existe entre proteger un dato para visualización y protegerlo contra acceso no autorizado?**
Para visualización es nada más cambiar cómo se ve, por ejemplo con asteriscos. Contra acceso no autorizado es que de plano no puedas llegar al dato, eso se hace con permisos

**9. ¿Por qué la retención forma parte de la protección de datos?**
Porque si un dato ya se borró ya no se puede filtrar, entre menos cosas innecesarias guardes menos riesgo hay

**10. ¿Qué riesgo existe si una organización conserva información indefinidamente?**
Que si hay una fuga se sale más información y de más gente, hasta de clientes que ya ni tienen que ver con la empresa
