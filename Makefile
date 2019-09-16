.PHONY: all install uninstall

LIBDIR ?= /usr/lib

all:
	

install:
	install --directory $(DESTDIR)/$(LIBDIR)/systemd/system $(DESTDIR)/etc/default $(DESTDIR)/usr/bin $(DESTDIR)/usr/sbin
	install --owner=root --group=root --mode=644 services/netns@.service $(DESTDIR)/$(LIBDIR)/systemd/system/
	install --owner=root --group=root --mode=644 services/netns-bridge@.service $(DESTDIR)/$(LIBDIR)/systemd/system/
	install --owner=root --group=root --mode=644 services/netns-nat@.service $(DESTDIR)/$(LIBDIR)/systemd/system/
	install --owner=root --group=root --mode=644 services/netns-tunnel@.service $(DESTDIR)/$(LIBDIR)/systemd/system/
	install --owner=root --group=root --mode=644 services/netns-interface@.service $(DESTDIR)/$(LIBDIR)/systemd/system/
	install --owner=root --group=root --mode=644 configs/netns $(DESTDIR)/etc/default/
	install --owner=root --group=root --mode=755 scripts/chnetns $(DESTDIR)/usr/bin/
	install --owner=root --group=root --mode=755 scripts/netnsinit $(DESTDIR)/usr/sbin/
	install --owner=root --group=root --mode=755 scripts/netnsmoveif $(DESTDIR)/usr/sbin/
	systemctl daemon-reload || true

uninstall:
	systemctl disable --now "netns-interface@" || true
	systemctl disable --now "netns-tunnel@" || true
	systemctl disable --now "netns-bridge@" || true
	systemctl disable --now "netns-nat@" || true
	systemctl disable --now "netns@" || true

	rm -f $(DESTDIR)/$(LIBDIR)/systemd/system/netns@.service
	rm -f $(DESTDIR)/$(LIBDIR)/systemd/system/netns-bridge@.service
	rm -f $(DESTDIR)/$(LIBDIR)/systemd/system/netns-nat@.service
	rm -f $(DESTDIR)/$(LIBDIR)/systemd/system/netns-tunnel@.service
	rm -f $(DESTDIR)/$(LIBDIR)/systemd/system/netns-interface@.service
	rm -f $(DESTDIR)/usr/bin/chnetns
	rm -f $(DESTDIR)/usr/sbin/netnsinit
	rm -f $(DESTDIR)/usr/sbin/netnsmoveif
