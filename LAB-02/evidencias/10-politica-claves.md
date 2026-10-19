# 10 Política de claves

## Objetivo

Hacer unas reglas básicas para manejar las claves

## Reglas

1. **Generación:** las claves se generan random con una herramienta segura, nada de inventarlas uno mismo
2. **Almacenamiento:** las claves se guardan en un gestor de secretos, nunca en el código ni en el repositorio
3. **Acceso:** solo las usa quien de verdad las ocupa y se registra cada vez que alguien las usa
4. **Separación:** la clave no se guarda en el mismo lugar que los datos que protege
5. **Rotación:** se cambian cada cierto tiempo y también cuando alguien que tenía acceso se va
6. **Respaldo:** se hace respaldo de las claves en otro lugar seguro, porque si se pierde la clave se pierden los datos
7. **Revocación:** si se cree que una clave se filtró se deja de usar de inmediato y se cifra todo con una nueva
8. **Exposición accidental:** si una clave se sube al repositorio se toma como comprometida aunque la borres, porque se queda en el historial
9. **Eliminación:** cuando una clave ya no se usa se borra de todos los lugares donde estaba

## Conclusión

No importa qué tan bueno sea el cifrado si la clave se maneja mal
