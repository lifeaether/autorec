# 予約を更新
echo "DELETE FROM programme; DELETE FROM category;" | sqlite3 ./resv/resv.sqlite
find resv_data -type f -exec /bin/sh ./resv/epg.sh {} \;
(cat ./cron.txt; find resv_data -type f -exec /bin/sh ./resv/resv.sh {} \;) | crontab
crontab -l
