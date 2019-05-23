#!/bin/bash
solo_check(){
    script="$1"
    encoded_name=$(sed 's|/|_|g' <<< "$script")

    export LOCK=/var/lock/"$encoded_name"
    

    if [ -f $LOCK ]; then
        echo Job is already running\!
        exit 6
    fi
    touch $LOCK
    trap 'rm -f "$LOCK"; exit $?' INT TERM EXIT

    $script

    rm -f $LOCK
    trap - INT TERM EXIT
}

source /vagrant/config.ini
export $(cut -d= -f1 /vagrant/config.ini)

solo_check /vagrant/scripts/process-logs.sh  | mail -s "Logs report" "$MAILTO"