# 03 Gestión de claves

## Objetivo

Ver el problema de tener la clave escrita en un script

## Procedimiento

Se hizo `sql/ejemplo-mala-practica.sql` con la clave escrita en el pgp_sym_decrypt, se revisó y se borró. Antes de subir se buscaron secretos con

```bash
grep -RniE 'password|passwd|secret|token|api_key|clave' sql/
```

## Resultado obtenido

Solo salieron Password123, OtraPassword, CLAVE-DE-PRUEBA y CLAVE-EQUIVOCADA, que son datos de prueba del laboratorio

## Análisis

¿Qué ocurriría si esta clave fuera una clave utilizada realmente por una organización y el archivo se publicara en un repositorio Git?
Cualquiera podría descifrar los RFC, y aunque borres el archivo la clave se queda en el historial, entonces hay que cambiarla y cifrar todo de nuevo

## Conclusión

Las claves no van en el código ni en el repositorio
