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

qdev_init() {
	return 0
	if [ ! -f $QDK_STAMPDIR/$FUNCNAME-$PROGNAME-stamp ]; then
		# utils_msys2_installByPacman m4 bison
		utils_msys2_installByPacman boost
		touch $QDK_STAMPDIR/$FUNCNAME-$PROGNAME-stamp
	fi
}

# qdev_set

qdev_setmore() {
	:
}

qdev_get_ssd_src() {
	log_info "$FUNCNAME - $PROGNAME"
	
	_pkg=$1
	_pkg_ver=$2
	_pkg_file=$3
	_pkg_ffile=$4
	_pkg_dir=$_pkg-$_pkg_ver
	_pkg_url=$5
	cd $QDKE_TMP || die
	if [ -f $_pkg_ffile ]; then
		return 0
	fi
	curl -O $_pkg_url
	cd $qdev_build_top || die
	extract $QDKE_TMP/$_pkg_ffile || die
	mv $_pkg_dir $apps_more || die
}

qdev_get() {
	qdev_get_ssd_src $@
}

# qdev_check

qdev_build_prepare() {
	log_info "$FUNCNAME - $PROGNAME"
	
	cd $qdev_build_src
	
}

qdev_build_fix() {
	:
	# touch $qdev_build_dir/${FUNCNAME}-stamp-fix
}

# qdev_build_config

# qdev_build_cmake

qdev_build_make() {
	if [ ! -f $qdev_build_src/${FUNCNAME}-stamp-make$1 ]; then
		cd $qdev_build_src
		make $@ \
			|| die
		touch $qdev_build_src/${FUNCNAME}-stamp-make$1
	fi
}

qdev_build_make_install() {
	if [ ! -f $qdev_build_src/${FUNCNAME}-stamp-make$1 ]; then
		cd $qdev_build_src
		cp -rf build/libseh.a  libseh.a \
			|| die
		touch $qdev_build_src/${FUNCNAME}-stamp-make$1
	fi
}

qdev_try() {
	log_info "$FUNCNAME - $PROGNAME"
	
	cd $qdev_build_dir || die
	
	if [ x$apps_more != "xssd" ]; then
		:
		# qdev_build_prepare
	fi
	
	# qdev_build_config
	# qdev_build_cmake
	qdev_build_make -f GNUmakefile
	qdev_build_make_install
	
	log_info "$FUNCNAME - $PROGNAME - Done - Sucessfull."
}

# qdev_tst

#
# Required and optional software
#
pkg=libseh
pkg_ver=0.0.4
pkg_file=$pkg-$pkg_ver
pkg_ffile=$pkg_file.zip
pkg_dir=$pkg_file
# http://www.programmingunlimited.net/files/libseh-0.0.4.zip
pkg_url=http://www.programmingunlimited.net/files/$pkg_ffile

pkg_deps_gcc=''
pkg_deps_py=''
#----------------------------------------
work_home=$QDEV_WORK_HOME
user_name=libseh
apps_name=libseh
apps_more=ssd
# Standard Source Distribution
#----------------------------------------
qdev_init
qdev_set					$work_home $user_name $apps_name $apps_more
qdev_setmore
qdev_get					$pkg $pkg_ver $pkg_file $pkg_ffile $pkg_url
qdev_check
qdev_try
#qdev_tst
