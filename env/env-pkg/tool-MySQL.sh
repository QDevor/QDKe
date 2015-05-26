#!/bin/bash
#
#            Copyright (C) 2015 QDevor
#
#  Licensed under the GNU General Public License, Version 3.0 (the License);
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#            http://www.gnu.org/licenses/gpl-3.0.html
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

PROGDIR=`dirname $0`
PROGDIR=`cd $PROGDIR && pwd -P`

# echo [Debug] - '$0'=$0
FILENAME=`basename $0`
PROGTYPE=${FILENAME#*.}
PROGNAME=${FILENAME%.*}
# echo [Debug] - The script is: $PROGDIR/$PROGNAME.$PROGTYPE
#----------------------------------------
. $PROGDIR/../env-msys2/entry-common.sh
#----------------------------------------
_tool_MySQL_init() {
	PKG_MIRROR=http://dev.mysql.com/downloads/mysql
	CDN_MIRROR=http://cdn.mysql.com/Downloads
# Windows (x86, 32-bit), ZIP Archive
# mysql-5.6.24-win32.zip
# http://cdn.mysql.com/Downloads/MySQL-5.6/mysql-5.6.24-win32.zip
# Windows (x86, 64-bit), ZIP Archive
# mysql-5.6.24-winx64.zip
# 
}

_tool_MySQL_getMore() {
	_pkg=MySQL
	_pkg_ver=`wget -q -O- ''$PKG_MIRROR'/' | \
			grep -i '(mysql-.*\.zip)' | \
			sed -n 's,.*/mysql-\([0-9\.]*-.*\)\.zip.*/.*,\1,p' | \
			head -1`
	_pkg_ver2=$(echo $_pkg_ver | cut -f1-2 -d'.')
}

_tool_MySQL_get() {
	_tool_MySQL_getMore
	
	if [ x$QDKe_VAR_IS_XP = "xtrue" ]; then
		_pkg_file=$_pkg-$_pkg_ver-win32.zip
	else
		_pkg_file=$_pkg-$_pkg_ver-winx64.zip
	fi
	# http://cdn.mysql.com/Downloads/MySQL-5.6/mysql-5.6.24-win32.zip
	_pkg_url=$CDN_MIRROR/$_pkg-$_pkg_ver2/$_pkg_file
	cd $QDKE_TMP || die
	loop_curl $_pkg_file $_pkg_url
	
	cd $QDK_ROOT || die
	extract $QDKE_TMP/$pkg_file
}

#----------------------------------------
_tool_MySQL_init
_tool_MySQL_get
#----------------------------------------
