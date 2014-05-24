#/bin/sh

./epg/archive.sh

recpt1 --b25 --strip 27 90 - | epgdump - - | xsltproc ./epg/epgxml2sqlite.xslt - | sqlite3 ./epg/epg.sqlite
recpt1 --b25 --strip 26 90 - | epgdump - - | xsltproc ./epg/epgxml2sqlite.xslt - | sqlite3 ./epg/epg.sqlite
recpt1 --b25 --strip 25 90 - | epgdump - - | xsltproc ./epg/epgxml2sqlite.xslt - | sqlite3 ./epg/epg.sqlite
recpt1 --b25 --strip 24 90 - | epgdump - - | xsltproc ./epg/epgxml2sqlite.xslt - | sqlite3 ./epg/epg.sqlite
recpt1 --b25 --strip 23 90 - | epgdump - - | xsltproc ./epg/epgxml2sqlite.xslt - | sqlite3 ./epg/epg.sqlite
recpt1 --b25 --strip 22 90 - | epgdump - - | xsltproc ./epg/epgxml2sqlite.xslt - | sqlite3 ./epg/epg.sqlite
recpt1 --b25 --strip 21 90 - | epgdump - - | xsltproc ./epg/epgxml2sqlite.xslt - | sqlite3 ./epg/epg.sqlite
recpt1 --b25 --strip 16 90 - | epgdump - - | xsltproc ./epg/epgxml2sqlite.xslt - | sqlite3 ./epg/epg.sqlite
#recpt1 --b25 --strip 32 90 - | epgdump - - | xsltproc ./epg/epgxml2sqlite.xslt - | sqlite3 ./epg/epg.sqlite
