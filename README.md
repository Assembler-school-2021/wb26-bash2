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

Solución en [backup.bash](https://github.com/Assembler-school-2021/wb26-bash2/blob/main/backup.bash)

> Un compañero nos ha pedido ayuda. Tienen que generar muchos QR y ahora lo están haciendo de forma manual en : http://qr.calm9.com/en/
> 
> Busca una forma de automatizar el proceso con un script. Nos han proporcionado una lista de url y hay que sacar para cada url un qr con 4 densidades distintas ( versiones 11 10 9 8 7 ) y 4 niveles distintos de ECC ( L M Q H) para hacer pruebas.

Solución en [qr.bash](https://github.com/Assembler-school-2021/wb26-bash2/blob/main/qr.bash)
