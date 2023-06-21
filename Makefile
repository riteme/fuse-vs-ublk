.PHONY: disk ublk

disk:
	mkdir -p mount
	mkdir -p test
	dd if=/dev/zero of=test/disk bs=1M count=4096 status=progress
	sync
	echo 3 | sudo tee /proc/sys/vm/drop_caches

fuse: fuse.c fuse_helpers.h
	$(CC) -Wall $< `pkg-config fuse3 --cflags --libs` -o $@

ublk:
	cd ubdsrv; autoreconf -i; ./configure; make
	ln -sf ubdsrv/ublk .
