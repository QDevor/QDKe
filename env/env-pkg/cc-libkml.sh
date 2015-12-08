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
		
		touch $QDK_STAMPDIR/$FUNCNAME-$PROGNAME-stamp
	fi
}

# qdev_set

qdev_setmore() {
	:
	# qdev_build_dir=$qdev_build_src
}

qdev_get_ssd_src() {
	log_info "$FUNCNAME - $PROGNAME"
	
	_pkg=$1
	_pkg_ver=$2
	_pkg_file=$3
	_pkg_ffile=$4
	_pkg_dir=$pkg_dir
	_pkg_url=$5
	cd $QDKE_TMP || die
	if [ ! -f $_pkg_ffile ]; then
		curl -O $_pkg_url
	fi
	
	cd $qdev_build_top || die
	if [ ! -d $apps_more ]; then
	  extract $QDKE_TMP/$_pkg_ffile || die
	  mv $_pkg_dir $apps_more || die
	fi
}

qdev_get() {
	# qdev_get_ssd_src $@
	scm_clone   $work_home $user_name $apps_name $apps_more
	# scm_clone  $work_home $user_name $apps_name
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

qdev_build_config() {
	if [ ! -f $qdev_build_dir/${FUNCNAME}-stamp-autogen ]; then
	  cd $qdev_build_src ||die
		./autogen.sh ||die
	  touch $qdev_build_dir/${FUNCNAME}-stamp-autogen
	fi
	if [ ! -f $qdev_build_dir/${FUNCNAME}-stamp ]; then
		cd $qdev_build_dir ||die
		
		#  --with-expat-include-dir="$qdev_build_src/third_party/expat.win32"
	  #  --with-expat-lib-dir="$qdev_build_src/third_party/expat.win32"
		LIBKML_CC_PREFIX_QT=$QDKE_ROOT/home/uav_home/OpenPilot/OpenPilot/tools/qt-5.4.0/Tools/mingw491_32/bin/i686-w64-mingw32
		LIBKML_CC_PREFIX_MXE=$QDKE_ROOT/home/mxe/usr/bin/i686-w64-mingw32
		LIBKML_CC_PREFIX=$LIBKML_CC_PREFIX_MXE
		CC=$LIBKML_CC_PREFIX-gcc \
		CXX=$LIBKML_CC_PREFIX-g++ \
		../$apps_more/configure \
		  --prefix=''$qdev_install_dir'' \
			--enable-shared=no \
			--enable-static=yes \
			--with-expat-include-dir="$MINGW_ROOT/include" \
			--with-expat-lib-dir="$MINGW_ROOT/lib" \
		  LDFLAGS="-lm" \
		  ||die
		touch $qdev_build_dir/${FUNCNAME}-stamp
	fi
}

# qdev_build_cmake

qdev_build_make() {
	if [ ! -f $qdev_build_dir/${FUNCNAME}-stamp-make$1 ]; then
		cd $qdev_build_dir ||die
		make $@ \
			|| die
		touch $qdev_build_dir/${FUNCNAME}-stamp-make$1
	fi
}

qdev_build_make_install() {
	if [ ! -f $qdev_build_dir/${FUNCNAME}-stamp-make$1 ]; then
		cd $qdev_build_dir
		make install \
			|| die
		touch $qdev_build_dir/${FUNCNAME}-stamp-make$1
	fi
	
	if [ ! -f $qdev_build_dir/${FUNCNAME}-stamp-make-auxcopy ]; then
		:
		cd $qdev_build_src/third_party/boost_1_34_1
		cp -rf boost $qdev_install_dir/include \
			|| die
		touch $qdev_build_dir/${FUNCNAME}-stamp-make-auxcopy
	fi
	
	current_dir=$QDKE_ROOT/home/uav_home/OpenPilot/OpenPilot/tools
	cd $current_dir || die
	rm -rf $current_dir/libkml >/dev/null 2>&1
	mkdir -p $current_dir/libkml || die
	cp -rf $qdev_install_dir/* $current_dir/libkml || die
}

qdev_try() {
	log_info "$FUNCNAME - $PROGNAME"
	
	cd $qdev_build_dir || die
	
	if [ x$apps_more != "xssd" ]; then
		:
		# qdev_build_prepare
	fi
	
	qdev_build_config
	# qdev_build_cmake
	qdev_build_make
	qdev_build_make_install
	
	log_info "$FUNCNAME - $PROGNAME - Done - Sucessfull."
}

# qdev_tst

#
# Required and optional software
#
pkg=ta-lib
pkg_ver=0.4.0
pkg_file=$pkg-$pkg_ver-src
pkg_ffile=$pkg_file.tar.gz
pkg_dir=$pkg
# http://ncu.dl.sourceforge.net/project/ta-lib/ta-lib/0.4.0/ta-lib-0.4.0-src.tar.gz
pkg_url=http://ncu.dl.sourceforge.net/project/ta-lib/ta-lib/0.4.0/$pkg_ffile

pkg_deps_gcc=''
pkg_deps_py=''
#----------------------------------------
work_home=$QDEV_WORK_HOME
user_name=kubark42
apps_name=libkml
apps_more=github
# Standard Source Distribution
#----------------------------------------
qdev_init
qdev_set					$work_home $user_name $apps_name $apps_more
qdev_setmore
qdev_get					$work_home $user_name $apps_name $apps_more
qdev_check
qdev_try
#qdev_tst
