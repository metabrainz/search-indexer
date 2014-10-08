JAR:= jar/search-indexer-latest.jar

default: 
	$(MAKE) index TYPE=area
	$(MAKE) index TYPE=artist
	$(MAKE) index TYPE=releasegroup
	$(MAKE) index TYPE=release
	$(MAKE) index TYPE=label
	$(MAKE) index TYPE=cdstub
	$(MAKE) index TYPE=tag
	$(MAKE) index TYPE=work
	$(MAKE) index TYPE=annotation
	$(MAKE) index TYPE=place
	$(MAKE) index TYPE=url
	$(MAKE) index TYPE=series
	$(MAKE) index TYPE=editor
	$(MAKE) index TYPE=instrument

recording:
	$(MAKE) index TYPE=recording

freedb:
	mkdir -p ./data/tmp
	rm -rf ./data/tmp/freedb_index
	env JAR=$(JAR) builder --indexes-dir ./data/tmp --freedb-dump freedb-data/freedb-complete-latest.tar.bz2 --indexes freedb
	$(MAKE) rotate INDEX=freedb_index

index:
	mkdir -p ./data/tmp
	rm -rf ./data/tmp/$(TYPE)_index
	env JAR=$(JAR) builder --indexes-dir ./data/tmp --indexes $(TYPE)
	$(MAKE) rotate INDEX=$(TYPE)_index

rotate:
	[ "$(INDEX)" ]
	chmod 755 ./data/tmp/$(INDEX)
	chmod 644 ./data/tmp/$(INDEX)/*
	mkdir -m 755 -p ./data/old ./data/cur
	rm -rf ./data/old/$(INDEX).1
	if [ -e ./data/old/$(INDEX).0 ] ; then mv ./data/old/$(INDEX).0 ./data/old/$(INDEX).1 ; fi
	if [ -e ./data/cur/$(INDEX) ]   ; then mv ./data/cur/$(INDEX)   ./data/old/$(INDEX).0 ; fi
	mv -v ./data/tmp/$(INDEX) ./data/cur/$(INDEX)
	rm -rf ./data/old/$(INDEX).1
