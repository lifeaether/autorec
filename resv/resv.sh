#!/bin/sh

FILE_PATH=${1}
FILE_NAME=${1##*/}

FILE_CRONTAB=./crontab_resv
OUTPUT_DIR=/media/datb/${FILE_NAME}

if [ ! -d ${OUTPUT_DIR} ]; then
    if ! mkdir ${OUTPUT_DIR}; then
	exit 1
    fi
fi

WHERE=`cat ${FILE_PATH}`
OUTPUT_DIR_ESCAPED=`echo ${OUTPUT_DIR} | sed -e 's/\//\\\\\//g'`

echo "select distinct channel,datetime(start,'-1 minutes'),duration+60,title from programme join category using (channel, event_id) where ${WHERE} order by start;" | sqlite3 ./epg/epg.sqlite | sed -f ./resv/cron.sed | sed -e "s/__OUTDIR__/\"${OUTPUT_DIR_ESCAPED}\"/g"
