#!/bin/bash
FILENAME="listado"
DIAS=15
INDEXFILE="antiguos"
ELASTICSERVER="localhost"

mostrar(){
        echo "CONTENIDO DE LISTADO"
        cat $FILENAME
}

buscaAntiguos(){
        echo "Indices mas antiguos de $DIAS dias"
        rm $INDEXFILE
        REFDATE=`date -d "today -${DIAS} days 00:00:00" +%s`
        while read I; do
                FECHA=`echo $I | awk '{print $3;}' | cut -d- -f3 | sed 's/\./-/g'`
                PARSEDD=`date -d "$FECHA" +%s 2> /dev/null`
                if [ $? -eq 0 ]; then
                        if [ $PARSEDD -lt $REFDATE ]; then
                                echo $I | tee -a $INDEXFILE
                        fi
                fi
        done < $FILENAME
}

reindex(){
        echo "Reindexacion de los ficheros encontrados"
        COMANDO="curl -HContent-Type:application/json -XPOST $ELASTICSERVER:9200/_reindex?pretty -d'{"
        while read I; do
                echo "$COMANDO"
                SRC=`echo $I | awk '{print $3;}'`
                echo "\"source\": { \"index\": \"$SRC\"}, \"dest\": { \"index\": \"${SRC}-reindexed\"}}'"
        done < $INDEXFILE
}

deleteindex(){
        echo "Borrado de indices antiguos"
        COMANDO="curl -X DELETE '$ELASTICSERVER:9200"
        while read I; do
                SRC=`echo $I | awk '{print $3;}'`
                echo "$COMANDO/$SRC/_doc/1'"
        done < $INDEXFILE
}

cerrarIndex(){
        echo "Cerramos los indices"
        COMANDO="curl -X POST '$ELASTICSERVER:9200/"
        while read I; do
                SRC=`echo $I | awk '{print $3;}'`
                echo "$COMANDO/${SRC}-reindexed/_close'"
        done < $INDEXFILE
}

mostrar
buscaAntiguos
reindex 
deleteindex
cerrarIndex
