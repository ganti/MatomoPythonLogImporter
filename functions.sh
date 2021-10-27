#!/bin/bash

get_logfile() {

    if [ -f "$LASTLINE_PATH/$1" ]; then
        #echo "$LASTLINE_PATH/$lf exists"
        if grep -Fxq "$(cat $LASTLINE_PATH/$1)" $ACCESSLOG_PATH/$1
        then 
            #echo "last line found"
            sed -e "1,/^$(sed 's/[][\\\/^$.*]/\\&/g' $LASTLINE_PATH/$1)\$/d" $ACCESSLOG_PATH/$1 >> $TOPROCESS_PATH/$1
        else
            #echo "last line not found, copy logs"
            cat "$ACCESSLOG_PATH/$1" >> "$TOPROCESS_PATH/$1"
        fi
    else
        #echo "$LASTLINE_PATH/$lf does not exist, creating it now"
        cat "$ACCESSLOG_PATH/$1" >> "$TOPROCESS_PATH/$1"
    fi
    tail -1 "$ACCESSLOG_PATH/$1" | tr -d '\n' > "$LASTLINE_PATH/$1"
}

import_stats_to_matomo() {
    if [ -f "$TOPROCESS_PATH/$1" ]; then
        #echo "matomo-import $1 to siteid $2"
        python3 $MATOMO_PATH/misc/log-analytics/import_logs.py --url=$MATOMO_BASEURL --idsite=$2 --enable-http-errors --enable-http-redirects --enable-bots "$TOPROCESS_PATH/$1"
        rm "$TOPROCESS_PATH/$1" 
    fi
}
