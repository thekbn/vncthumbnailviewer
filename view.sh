usage(){
     cat <<HELP_USAGE

    Usage: $0 [-h|--host host] [-p|--port ports...] [--pass password]
        -h, --host  specify host
        -p, --port  specify on or more ports
            --pass  specify password

HELP_USAGE
}

#set default values
HOST=localhost
PASS=secret

#get options
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    -h|--host)
        HOST="$2"
        shift # past argument
        shift # past value
        ;;
    -p|--port)
        shift # past argument
        for p in $@;
        do
            if [[ $p == -* ]] 
            then 
                break
            fi
            PORT="$PORT $p"
            echo "added $p -> $PORT"
            shift #shift value
        done
        ;;
    --pass)
        PASS="$2"
        shift # past argument
        shift # past value
        ;;
    *)    # unknown option
        usage
        shift # past argument
        exit
        ;;
esac
done

if [ $HOST = "localhost" ] 
then
    [ -z "$PORT" ] && PORT=$(docker ps  --format "{{.Image}} {{.Ports}}" | grep "selenium/node" | awk '{print $2}' | sed 's/.*:\([[:digit:]]*\)->.*/\1/')

    for p in $PORT; 
    do 
        params="$params HOST $HOST PORT $p PASSWORD $PASS"
    done
fi

echo $params

# java -jar bin/VncThumbnailViewer.jar $params