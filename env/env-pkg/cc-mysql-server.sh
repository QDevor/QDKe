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
export PYTHON=python2
#----------------------------------------
. $PROGDIR/../env-msys2/entry-common.sh
. $PROGDIR/../env-msys2/qdev-build-common.sh
#----------------------------------------

#----------------------------------------

# qdev_init 

# qdev_set

qdev_setmore() {
	:
}

# qdev_get

# qdev_check

qdev_build_prepare() {
	log_info "$FUNCNAME - $PROGNAME"
	
	cd $qdev_build_dir
	log_info "Separately configure the InnoDB storage engine"
	if [ ! -f $qdev_build_dir/$FUNCNAME-stamp-1 ]; then
		cd storage/innobase; autoreconf --force --install || die
		touch $qdev_build_dir/$FUNCNAME-stamp-1
	fi
	log_info "Prepare the remainder of the source tree"
	if [ ! -f $qdev_build_dir/$FUNCNAME-stamp-2 ]; then
		autoreconf --force --install || die
		touch $qdev_build_dir/$FUNCNAME-stamp-2
	fi
	log_info "Prepare the source tree for configuration"
	if [ ! -f $qdev_build_dir/$FUNCNAME-stamp-3 ]; then
		aclocal; autoheader || die
		libtoolize --automake --force || die
		automake --force --add-missing; autoconf || die
		# BUILD/autorun.sh
		touch $qdev_build_dir/$FUNCNAME-stamp-3
	fi
}

# qdev_build_config

# qdev_build_make

# qdev_try

# qdev_tst

#
# Required and optional software
#
pkg=mysql
pkg_ver=5.6.24
pkg_file=$pkg-$pkg_ver.zip
pkg_dir=$pkg-$pkg_ver
# http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.24.zip
# http://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.7-rc.zip
pkg_url=http://dev.mysql.com/get/Downloads/MySQL-5.7/$pkg_file

pkg_deps_gcc=''
pkg_deps_py=''
#----------------------------------------
work_home=$QSTK_WORK_HOME
user_name=mysql
apps_name=mysql-server
apps_more=github
#----------------------------------------
qdev_init
qdev_set					$work_home $user_name $apps_name $apps_more
qdev_setmore
qdev_get
qdev_check
qdev_try
qdev_tst
