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

#----------------------------------------
_PGMDIR_UTILS_GIT=`dirname $0`
_PGMDIR_UTILS_GIT=`cd $_PGMDIR_UTILS_GIT && pwd -P`
_FN_UTILS_GIT=`basename $0`
_FNTYPE_UTILS_GIT=${_FN_UTILS_GIT#*.}
_FNNAME_UTILS_GIT=${_FN_UTILS_GIT%.*}
#----------------------------------------

_utils_install_mysql_init() {
	:
	PKG_MIRROR=http://dev.mysql.com/downloads/mysql
	CDN_MIRROR=http://cdn.mysql.com/Downloads
# Windows (x86, 32-bit), ZIP Archive
# mysql-5.6.24-win32.zip
# http://cdn.mysql.com/Downloads/MySQL-5.6/mysql-5.6.24-win32.zip
# Windows (x86, 64-bit), ZIP Archive
# mysql-5.6.24-winx64.zip
}

_utils_install_mysql_getMore() {
	_pkg=mysql
	
	doloop=1
	while [ $doloop = 1 ]; do
		_pkg_ver=`wget -q -O- ''$PKG_MIRROR'/' | \
			grep -i '(mysql-.*\.zip)' | \
			sed -n 's,.*mysql-\([0-9\.].*\)*-.*.zip.*,\1,p' | \
			head -1`
		
		if [ $? = 0 ]; then
			break;
		fi
		sleep 3
	done
	_pkg_ver2=$(echo $_pkg_ver | cut -f1-2 -d'.')
}

_utils_install_mysql_get() {
	if [ ! -d $MYSQL_ROOT ]; then
		_utils_install_mysql_getMore
		
		if [ x$QDKe_VAR_IS_XP = "xtrue" ]; then
			_pkg_file=$_pkg-$_pkg_ver-win32.zip
		else
			_pkg_file=$_pkg-$_pkg_ver-winx64.zip
		fi
		# http://cdn.mysql.com/Downloads/MySQL-5.6/mysql-5.6.24-win32.zip
		_pkg_url=$CDN_MIRROR/MySQL-$_pkg_ver2/$_pkg_file
		echo "_pkg_url=$_pkg_url."
		cd $QDKE_TMP || die
		loop_curl $_pkg_file $_pkg_url
		
		cd $QDK_ROOT || die
		extract $QDKE_TMP/$pkg_file
		mv mysql-5.6.24-win32 mysql
	fi
}

_utils_install_mysql() {
	_utils_install_mysql_init
	_utils_install_mysql_get
}

_utils_mysql_init_config() {
	:
	cd $MYSQL_ROOT || die
	if [ ! -f $QDK_STAMP_DIR/$FUNCNAME-stamp ]; then
		needed_patch_file=my-default.ini
		sed -i -e 's/# \(basedir = \)/basedir = $MYSQL_ROOT/g' \
			$needed_patch_file
		needed_patch_file=my-default.ini
		sed -i -e 's/# \(datadir = \)/datadir = $MYSQL_ROOT\/data/g' \
			$needed_patch_file
		touch $QDK_STAMP_DIR/$FUNCNAME-stamp
	fi
}

_utils_mysql_init_install() {
	:
	cd $MYSQL_ROOT || die
	if [ ! -f $QDK_STAMP_DIR/$FUNCNAME-stamp ]; then
		cd $MYSQL_ROOT/bin || die
		if [ x$QDKe_VAR_IS_XP = "xtrue" ]; then
			mysqld -install
		else
			log_warning "Please Run As Administrator: mysqld -install."
			pause && pause && pause
		fi
		
		net start mysql
		touch $QDK_STAMP_DIR/$FUNCNAME-stamp
	fi
}

_utils_mysql_init() {
	_old_pwd=$(pwd)
	_utils_mysql_init_config
	_utils_mysql_init_install
	cd $_old_pwd || die
}

#----------------------------------------
_utils_install_mysql
_utils_mysql_init

