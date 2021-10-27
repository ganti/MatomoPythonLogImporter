#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR

source $DIR/config.sh
source $DIR/functions.sh


#ACCESSLOG_PATH=$DIR/access_logs
LASTLINE_PATH=$DIR/last_lines
TOPROCESS_PATH=$DIR/to_process


cat $DIR/config_matomo.config| while read line || [[ -n $line ]];
do
    [[ ${line//[[:space:]]/} =~ ^#.* || -z "$line" ]] && continue
    echo $line | tr "=" "\n" | while read -r key; do
    read -r value
        LOGFILE=${key}
        SITEID=${value}

        get_logfile $LOGFILE
        import_stats_to_matomo $LOGFILE $SITEID
    done
done


php $MATOMO_PATH/console core:archive --force-all-websites --url="$MATOMO_BASEURL"