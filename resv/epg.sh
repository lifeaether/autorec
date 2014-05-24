WHERE=`cat $1`
echo "ATTACH DATABASE './epg/epg.sqlite' AS epg; INSERT OR REPLACE INTO programme SELECT event_id,channel,title,start,stop,duration,freeCA,video,audio,desc,extdesc FROM epg.programme WHERE $WHERE;" | sqlite3 ./resv/resv.sqlite
echo "ATTACH DATABASE './epg/epg.sqlite' AS epg; INSERT OR REPLACE INTO category SELECT event_id,channel,category,middle FROM epg.programme JOIN epg.category USING (channel, event_id) WHERE $WHERE;" | sqlite3 ./resv/resv.sqlite
