# Política de claves

1. Las claves se generan random con una herramienta segura, nada de inventarlas
2. Se guardan en un gestor de secretos, nunca en el código ni en el repositorio
3. Solo las usa quien de verdad las ocupa y se registra cada vez que alguien las usa
4. La clave no se guarda en el mismo lugar que los datos que protege
5. Se cambian cada cierto tiempo y también cuando alguien que tenía acceso se va
6. Se respaldan en otro lugar seguro, porque si se pierde la clave se pierden los datos
7. Si se cree que una clave se filtró se deja de usar y se cifra todo con una nueva
8. Si una clave se sube al repositorio se toma como filtrada aunque se borre, porque se queda en el historial
9. Cuando una clave ya no se usa se borra de todos lados
