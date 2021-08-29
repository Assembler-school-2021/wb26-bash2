#!/bin/bash
URLSFILE="urls.txt"
QRFOLDER="QRs"

launchCurl(){
    URL=$1
    SZ=$2
    ECC=$3
curl 'http://qr.calm9.com/en/' \
  -H 'Connection: keep-alive' \
  -H 'Pragma: no-cache' \
  -H 'Cache-Control: no-cache' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'Origin: http://qr.calm9.com' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'Referer: http://qr.calm9.com/en/' \
  -H 'Accept-Language: es-ES,es;q=0.9,en;q=0.8' \
  -H 'Cookie: __utmc=134289713; __utmz=134289713.1623267119.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); __utmt=1; __utma=134289713.844454772.1623267119.1623267119.1623267119.1; __gads=ID=d673abad00c55912-220b02e8d4c800fa:T=1623267119:RT=1623267119:S=ALNI_MYS0GczrTtC-vUsTxqoICPBbm-F7A; __utmb=134289713.2.10.1623267119' \
  --data-raw 'Lang=en&Type=URI&Size='$SZ'&Version=1&Ecc='$ECC'&Ext=.png&URI-Type=on&Subject=&Link=http%3A%2F%2F'$URL'&Link-Type=on' \
  --compressed \
  --insecure 2> /dev/null
}

iniciar(){
        echo "Inicio del programa"
    [ -d $QRFOLDER ] || mkdir $QRFOLDER
        while read I; do
        for s in `seq 7 11`; do
                    for e in L M Q H; do
                echo "QR de $I de tamaño $s y calidad $e"
                QRFILE=`launchCurl $I $s $e | egrep -o "href=\"http(.*)png\"" | cut -d= -f2 | sed 's/\"//g'`
                echo $QRFILE
                (
                    cd $QRFOLDER
                    curl -O $QRFILE
                )
            done
        done
        done < $URLSFILE
}
