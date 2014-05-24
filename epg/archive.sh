NOW=`date "+%Y-%m-%d %H:%M:%S"`
echo "ATTACH DATABASE './epg/archive.sqlite' AS archive; BEGIN; INSERT OR REPLACE INTO archive.programme SELECT channel,start,stop,duration,title,freeCA,video,audio,desc,extdesc FROM programme WHERE stop < " '"'$NOW'"'"; END;" | sqlite3 ./epg/epg.sqlite
echo "ATTACH DATABASE './epg/archive.sqlite' AS archive; BEGIN; INSERT OR REPLACE INTO archive.category SELECT channel,start,category,middle FROM programme JOIN category USING (channel, event_id) WHERE stop < "'"'$NOW'"'"; END;"  | sqlite3 ./epg/epg.sqlite
echo "DELETE FROM programme WHERE stop < "'"'$NOW'"'";" | sqlite3 ./epg/epg.sqlite
echo "DELETE FROM category WHERE NOT EXISTS (SELECT * FROM programme WHERE category.channel = programme.channel AND category.event_id = programme.event_id);" | sqlite3 ./epg/epg.sqlite
