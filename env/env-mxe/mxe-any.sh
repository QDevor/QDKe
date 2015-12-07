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
}

# qdev_set

qdev_setmore() {
	qdev_build_top=$work_home
	qdev_build_src=$qdev_build_top
	qdev_build_dir=$qdev_build_top
	
	[ -d $qdev_build_top ] || mkdir -p $qdev_build_top > /dev/null 2>&1
	rm -rf $qdev_build_top/mxe > /dev/null 2>&1
}

qdev_get() {
  SCM_URL='https://github.com/'$user_name'/'$apps_name''
  if [ ! -f $qdev_build_dir/${FUNCNAME}-stamp-init ]; then
	  cd $qdev_build_top
	  git init
	  git fetch ${SCM_URL}
	  git remote add origin ${SCM_URL}
	  git checkout FETCH_HEAD
	  
	  #scm_update  $work_home $user_name $apps_name $apps_more
	  touch $qdev_build_dir/${FUNCNAME}-stamp-init
	fi
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
		#make MXE_TARGETS='x86_64-w64-mingw32.static i686-w64-mingw32.static'
		make \
		  MXE_TARGETS='i686-w64-mingw32.static' \
		  $@ \
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
	
	# qdev_build_config
	# qdev_build_cmake
	qdev_build_make $@
	
	log_info "$FUNCNAME - $PROGNAME - Done - Sucessfull."
}

# qdev_tst

#
# Required and optional software
#
#----------------------------------------
work_home=$WORK_HOME/mxe
user_name=mxe
apps_name=mxe
apps_more=github
# Standard Source Distribution
#----------------------------------------
qdev_init
qdev_set					$work_home $user_name $apps_name $apps_more
qdev_setmore
qdev_get					$pkg $pkg_ver $pkg_file $pkg_ffile $pkg_url
qdev_check
qdev_try          $@
#qdev_tst
