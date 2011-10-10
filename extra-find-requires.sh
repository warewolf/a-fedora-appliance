#!/bin/sh -
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

# Additional custom requires for the package.

original_find_requires="$1"
shift

# Get the list of files.
files=`sed "s/['\"]/\\\&/g"`

# Use ordinary find-requires first.
echo $files | tr [:blank:] '\n' | $original_find_requires

# Is supermin.d/hostfiles included in the list of files?
hostfiles=`echo $files | tr [:blank:] '\n' | grep 'supermin\.d/hostfiles$'`

if [ -z "$hostfiles" ]; then
    exit 0
fi

# Generate extra requires for libraries listed in hostfiles.
sofiles=`grep 'lib.*\.so\.' $hostfiles | fgrep -v '*' | sed 's|^\.||'`
for f in $sofiles; do
    if [ -f "$f" ]; then
        echo "$f"
    fi
done
