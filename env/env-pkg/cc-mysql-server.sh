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
	if [ ! -f $QDK_STAMP_DIR/$FUNCNAME-$PROGNAME-stamp ]; then
		# utils_msys2_installByPacman m4 bison
		utils_msys2_installByPacman boost
		touch $QDK_STAMP_DIR/$FUNCNAME-$PROGNAME-stamp
	fi
}

# qdev_set

qdev_setmore() {
	:
}

qdev_get_rc_src() {
	_pkg=mysql-server-mysql
	_pkg_ver=5.7.7
	_pkg_file=$_pkg-$_pkg_ver
	_pkg_ffile=$_pkg_file.tar.gz
	_pkg_dir=$_pkg-$_pkg_ver
	# https://codeload.github.com/mysql/mysql-server/tar.gz/mysql-5.7.7
	_pkg_url=https://codeload.github.com/mysql/mysql-server/tar.gz/$_pkg_file
	cd $QDKE_TMP || die
	if [ -f $_pkg_ffile ]; then
		return 0
	fi
	curl -L -O $_pkg_ffile $_pkg_url
	cd $qdev_build_top || die
	extract $QDKE_TMP/$_pkg_ffile || die
	mv $_pkg_dir $apps_more || die
}

qdev_get() {
	qdev_get_rc_src
}

# qdev_check

qdev_build_prepare() {
	log_info "$FUNCNAME - $PROGNAME"
	
	cd $qdev_build_src
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

qdev_build_fix() {
	:
	if [ -f $qdev_build_dir/${FUNCNAME}-stamp-fix ]; then
		return 0
	fi
	#----------------------------------------
	needed_patch_file=$qdev_build_src/include/my_global.h
	if [ ! -f $needed_patch_file.orig ]; then
		cp -f $needed_patch_file $needed_patch_file.orig
	fi
	# line637 - #ifdef _WIN32 -> #if (defined(_WIN32) && !defined(__MINGW32__))
	# #ifndef _WIN32
	sed -i -e 's/#ifdef _WIN32/#if (defined(_WIN32) \&\& !defined(__MINGW32__))/g' \
		$needed_patch_file
	sed -i -e '28s/.*/#ifdef _WIN32/' \
		$needed_patch_file
	
	sed -i -e 's/#ifndef _WIN32/#if (!defined(_WIN32) \|\| defined(__MINGW32__))/g' \
		$needed_patch_file
	#----------------------------------------
	needed_patch_file=$qdev_build_src/include/thr_cond.h
	if [ ! -f $needed_patch_file.orig ]; then
		cp -f $needed_patch_file $needed_patch_file.orig
	fi
	sed -i -e 's/#ifdef _WIN32/#if (defined(_WIN32) \&\& !defined(__MINGW32__))/g' \
		$needed_patch_file
	#----------------------------------------
	# touch $qdev_build_dir/${FUNCNAME}-stamp-fix
}

qdev_build_fix2() {
	:
	if [ -f $qdev_build_dir/${FUNCNAME}-stamp-fix2 ]; then
		return 0
	fi
	#----------------------------------------
	needed_patch_file=$qdev_build_src/CMakeLists.txt
	if [ ! -f $needed_patch_file.orig ]; then
		cp -f $needed_patch_file $needed_patch_file.orig
	fi
	sed -i -e 's/IF(WITH_UNIT_TESTS)/IF(0) #WITH_UNIT_TESTS)/g' \
		$needed_patch_file || die
	#----------------------------------------
	needed_patch_file=$qdev_build_src/include/my_global.h
	if [ ! -f $needed_patch_file.orig ]; then
		cp -f $needed_patch_file $needed_patch_file.orig
	fi
#if defined(__MINGW32__)
#define _TIMESPEC_DEFINED
#define _MODE_T_
#define _SSIZE_T_DEFINED
#endif
	sed -i -e '19s/.*/\n/' $needed_patch_file || die
	sed -i -e '20s/.*/#if defined(__MINGW32__)\n/' $needed_patch_file
	sed -i -e '21s/.*/#define _TIMESPEC_DEFINED\n/' $needed_patch_file
	sed -i -e '22s/.*/#define _MODE_T_\n/' $needed_patch_file
	sed -i -e '23s/.*/#define _SSIZE_T_DEFINED\n/' $needed_patch_file
	sed -i -e '24s/.*/#endif\n/' $needed_patch_file
	
	sed -i -e '347s/.*/#if (_MSC_VER)/' $needed_patch_file || die
	#----------------------------------------
	needed_patch_file=$qdev_build_dir/include/my_config.h
	if [ ! -f $needed_patch_file.orig ]; then
		cp -f $needed_patch_file $needed_patch_file.orig
	fi
	
	sed -i -e 's/.*undef HAVE_BUILTIN_STPCPY.*/#define HAVE_GCC_ATOMIC_BUILTINS 1/g' \
		$needed_patch_file || die
	
	sed -i -e '19s/.*/\n/' $needed_patch_file
	sed -i -e '20s/.*/#if defined(__MINGW32__)\n/' $needed_patch_file
	sed -i -e '21s/.*/#define _TIMESPEC_DEFINED\n/' $needed_patch_file
	sed -i -e '22s/.*/#define _MODE_T_\n/' $needed_patch_file
	sed -i -e '23s/.*/#define _SSIZE_T_DEFINED\n/' $needed_patch_file
	sed -i -e '24s/.*/#endif\n/' $needed_patch_file
	#----------------------------------------
	touch $qdev_build_dir/${FUNCNAME}-stamp-fix2
}

qdev_build_config() {
	mysql_build_prefix=$QDKE_USR/mysql-gpl
	if [ ! -f $qdev_build_dir/${FUNCNAME}-stamp-config ]; then
		cd $qdev_build_dir
		CFLAGS="-O3" CXX=gcc CXXFLAGS="-O3 -felide-constructors -fno-exceptions -fno-rtti" \
		$qdev_build_src/configure \
			--prefix=''$mysql_build_prefix'' \
			--host=''$QDKe_BUILD_TARGET'' \
			--build=''$QDKe_BUILD_TARGET'' \
			--enable-assembler \
			--with-client-ldflags=-all-static \
			--with-mysqld-ldflags=-all-static \
			--with-embedded-server \
			|| die
		touch $qdev_build_dir/${FUNCNAME}-stamp-config
	fi
}

# -DWITH_UNIT_TESTS=0 avoid 
# ADD_DEFINITIONS( /D _VARIADIC_MAX=10 )
qdev_build_cmake() {
	mysql_build_prefix=$QDKE_USR/mysql-gpl
	if [ ! -f $qdev_build_dir/${FUNCNAME}-stamp-cmake ]; then
		# -DWITH_SSL=yes -DWITH_ZLIB=yes
		cd $qdev_build_dir
		cmake ../$apps_more \
			-G "MSYS Makefiles" \
			-DBUILD_CONFIG=mysql_release \
			-DCMAKE_INSTALL_PREFIX=''$mysql_build_prefix'' \
			-DMYSQL_DATADIR=''$mysql_build_prefix'/data' \
			-DWITH_EMBEDDED_SERVER=1 \
			-DWITH_UNIT_TESTS=0 \
			> $QDKE_LOGDIR/$PROGNAME-$FUNCNAME-cmake.log 2>&1 \
			|| die
		touch $qdev_build_dir/${FUNCNAME}-stamp-cmake
	fi
}

# qdev_build_make

qdev_try() {
	log_info "$FUNCNAME - $PROGNAME"
	
	cd $qdev_build_dir || die
	
	if [ x$apps_more != "xssd" ]; then
		:
		# qdev_build_prepare
	fi
	
	# qdev_build_config
	qdev_build_cmake
	qdev_build_fix2
	qdev_build_make VERBOSE=1 \
		> $QDKE_LOGDIR/$PROGNAME-$FUNCNAME-make.log 2>&1
	# qdev_build_make install
	
	log_info "$FUNCNAME - $PROGNAME - Done - Sucessfull."
}

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
work_home=$QDEV_WORK_HOME
user_name=mysql
apps_name=mysql-server
apps_more=github-rc
# Standard Source Distribution
#----------------------------------------
qdev_init
qdev_set					$work_home $user_name $apps_name $apps_more
qdev_setmore
qdev_get
qdev_check
qdev_try
qdev_tst
