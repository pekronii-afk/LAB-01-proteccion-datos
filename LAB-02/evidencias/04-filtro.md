Apagué el perfilador, lo borré y lo puse en nivel 1 para que solo guarde inserts, updates y removes

La app hizo una búsqueda y cambió el teléfono del cliente 1, y en el perfilador solo salió el cambio

¿Qué perdiste de evidencia al aplicar el filtro? ¿Qué ganaste?
Ya no se ve quién consultó datos. Pero se guarda mucho menos y no se llena tan rápido

¿Qué filtro usarías si solo interesaran operaciones sobre la colección clientes?
`{ ns: "comercial.clientes", op: { $in: ["insert", "update", "remove"] } }`
