# a-fedora-appliance
# Copyright (C) 2011-2014 Red Hat Inc.
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
	firstboot \
	init \
	make.sh.in \
	README

CLEANFILES = *~ make.sh stamp-supermin

clean-local:
	rm -rf supermin.d appliance.d

bin_SCRIPTS = boot-a-fedora-appliance

libexec_SCRIPTS = build-a-fedora-appliance

fsdir = $(libdir)/a-fedora-appliance/supermin.d
fs_DATA = \
	supermin.d/base.tar.gz \
	supermin.d/init.tar.gz \
	supermin.d/packages

supermin.d/base.tar.gz supermin.d/packages: stamp-supermin
stamp-supermin: make.sh
	mkdir -p supermin.d
	rm -f $@ supermin.d/base.tar.gz supermin.d/packages
	./make.sh
	touch $@

supermin.d/init.tar.gz: init firstboot
	mkdir -p supermin.d
	tar zcf $@ $^

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
	./build-a-fedora-appliance supermin.d appliance.d

local-boot:
	./boot-a-fedora-appliance --local

# To build an RPM in Koji.
koji-f18:
	rpmbuild -bs \
	  --define "_srcrpmdir $$(pwd)" \
	  --define "_sourcedir $$(pwd)" \
	  --define "dist .fc18" a-fedora-appliance.spec
	koji build --scratch f18 \
	  $(PACKAGE_NAME)-$(PACKAGE_VERSION)-$(RELEASE).fc18.src.rpm

koji-f17:
	rpmbuild -bs \
	  --define "_srcrpmdir $$(pwd)" \
	  --define "_sourcedir $$(pwd)" \
	  --define "dist .fc17" a-fedora-appliance.spec
	koji build --scratch f17 \
	  $(PACKAGE_NAME)-$(PACKAGE_VERSION)-$(RELEASE).fc17.src.rpm
