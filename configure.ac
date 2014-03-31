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

AC_INIT([a-fedora-appliance],[1.0])
AM_INIT_AUTOMAKE([foreign])

dnl RPM release.
RELEASE=7
AC_SUBST([RELEASE])

dnl The list of packages included in the appliance.
dnl NOTES:
dnl  (1) These packages have to be installed on the host.
dnl  (2) After changing this do:
dnl        touch make.sh.in; make
PACKAGELIST="\
bash \
binutils \
coreutils \
dbus \
file \
findutils \
gawk \
grep \
gzip \
less \
NetworkManager \
openssh-clients \
openssh-server \
perl \
procps \
python \
rsyslog \
systemd \
udev \
yum \
"
AC_SUBST([PACKAGELIST])

dnl Check for supermin >= 5.
AC_CHECK_PROG([SUPERMIN],
              [supermin],[supermin],[no])
test "x$SUPERMIN" = "xno" &&
    AC_MSG_ERROR([supermin >= 5 must be installed])

dnl Pass a supermin --packager-config option.
AC_MSG_CHECKING([if user requested supermin --packager-config option])
AC_ARG_WITH([packager-config],
    [AS_HELP_STRING([--with-packager-config=FILE],
      [pass supermin --packager-config option @<:@default=no@:>@])],
    [PACKAGER_CONFIG="$withval"],
    [PACKAGER_CONFIG=no])
AC_MSG_RESULT([$PACKAGER_CONFIG])
AC_SUBST([PACKAGER_CONFIG])

dnl Produce output files.
AC_CONFIG_FILES([Makefile
                 a-fedora-appliance.spec
                ])
AC_CONFIG_FILES([build-a-fedora-appliance],
                [chmod 0555 build-a-fedora-appliance])
AC_CONFIG_FILES([boot-a-fedora-appliance],
                [chmod 0555 boot-a-fedora-appliance])
AC_OUTPUT
