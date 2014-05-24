# 番組表を更新
# 番組録画中は更新しないようにする
NOW=`date "+%Y-%m-%d %H:%M:%S"`
COUNT=`echo "SELECT count(*) FROM programme WHERE start < DATETIME(" "'"$NOW"'" ", " "'"+15 minutes"'" ") AND stop > DAT\
ETIME(" "'"$NOW"'" ", " "'"-2 minutes"'" ");" | sqlite3 ./resv/resv.sqlite`
if [ $COUNT != "0" ]; then
    echo "Skipped."
    exit 0
fi

# 更新
./epg/update.sh
