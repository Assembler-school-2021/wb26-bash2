# wb26-bash2

> Pregunta 2
> 
> Hay que rotar los logs de un elasticsearch de producción. En este caso la estrategia elegida ha sido reindexar los logs a un elastic externo (servidor de backups) y una vez copiado, borrar en origen y cerrar el indice en destino.
> 
> Dado el archivo que os proporcionamos a continuación output elastic cat indices, haz un script que deberá:
> 
> - listar el output proporcionado
> - saber que indices són más antiguos de 60 dias
> - lanzar comando de reindex al servidor de backup
> - esperar que acabe este reindex
> - hacer un delete del index antiguo en el nodo original
> - poner el indice en estado closed en el servidor de backup
