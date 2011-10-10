# a-fedora-appliance
# Copyright (C) 2011 Red Hat Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

EXTRA_DIST = \
	.gitignore \
	a-fedora-appliance.spec \
	extra-find-requires.sh \
	firstboot \
	init \
	make.sh.in \
	README

CLEANFILES = *~ make.sh stamp-supermin

clean-local:
	rm -rf supermin.d

bin_SCRIPTS = boot-a-fedora-appliance

libexec_SCRIPTS = build-a-fedora-appliance

fsdir = $(libdir)/a-fedora-appliance/supermin.d
fs_DATA = \
	supermin.d/base.img \
	supermin.d/init.img \
	supermin.d/hostfiles

supermin.d/base.img supermin.d/hostfiles: stamp-supermin
stamp-supermin: make.sh
	mkdir -p supermin.d
	rm -f $@ supermin.d/base.img supermin.d/hostfiles
	./make.sh
	touch $@

supermin.d/init.img: init firstboot
	mkdir -p supermin.d
	rm -f $@ $@-t
	echo -e "init\nfirstboot" | cpio --quiet -o -H newc > $@-t
	mv $@-t $@

# This used to be a configure-generated file.  However config.status
# always touches the destination file, which means the appliance got
# rebuilt too often.
make.sh: make.sh.in
	rm -f $@ $@-t
	./config.status --file=$@-t:$<
	chmod +x $@-t
	mv $@-t $@

# For local build/testing.
local-build:
	./build-a-fedora-appliance supermin.d kernel initrd root

local-boot:
	./boot-a-fedora-appliance --local

# To build an RPM in Koji.
koji-f17:
	rpmbuild -bs \
	  --define "_srcrpmdir $$(pwd)" \
	  --define "_sourcedir $$(pwd)" \
	  --define "dist .fc17" a-fedora-appliance.spec
	koji build --scratch f17 \
	  $(PACKAGE_NAME)-$(PACKAGE_VERSION)-$(RELEASE).fc17.src.rpm

koji-f16:
	rpmbuild -bs \
	  --define "_srcrpmdir $$(pwd)" \
	  --define "_sourcedir $$(pwd)" \
	  --define "dist .fc16" a-fedora-appliance.spec
	koji build --scratch f16 \
	  $(PACKAGE_NAME)-$(PACKAGE_VERSION)-$(RELEASE).fc16.src.rpm

koji-f15:
	rpmbuild -bs \
	  --define "_srcrpmdir $$(pwd)" \
	  --define "_sourcedir $$(pwd)" \
	  --define "dist .fc15" a-fedora-appliance.spec
	koji build --scratch dist-f15 \
	  $(PACKAGE_NAME)-$(PACKAGE_VERSION)-$(RELEASE).fc15.src.rpm
