JAR:= jar/search-indexer-latest.jar

default: 
	$(MAKE) index TYPE=area
#	$(MAKE) index TYPE=artist
#	$(MAKE) index TYPE=releasegroup
#	$(MAKE) index TYPE=release
#	$(MAKE) index TYPE=label
#	$(MAKE) index TYPE=cdstub
#	$(MAKE) index TYPE=tag
#	$(MAKE) index TYPE=work
#	$(MAKE) index TYPE=annotation
#	$(MAKE) index TYPE=place
#	$(MAKE) index TYPE=url
#	$(MAKE) index TYPE=series
#	$(MAKE) index TYPE=editor
#	$(MAKE) index TYPE=instrument

recording:
	$(MAKE) index TYPE=recording

freedb:
	env JAR=$(JAR) builder --indexes-dir ./data/cur --freedb-dump freedb-data/freedb-complete-latest.tar.bz2 --indexes freedb

index:
	env JAR=$(JAR) builder --indexes-dir ./data/cur --indexes $(TYPE)
