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
. $PROGDIR/../env-pkg/py-qstk-common.sh
#----------------------------------------

qdev_init() {
	if [ ! -f $TMP/${PROGNAME}-stamp ]; then
		:
		$PIP install cython
	fi
}

# qdev_set

qdev_setmore() {
	qdev_build_dir=$qdev_build_src
}

qdev_get() {
	cd $QDKE_TMP || die
	loop_curl $pkg_file $pkg_url
	cd $QDK_OPT_DIR || die
	$pkg_ffile
}

# qdev_check

# qdev_build_config

# qdev_build_make

qdev_try() {
	log_info "$FUNCNAME - $PROGNAME"
	
	exe_cmd "cd $qdev_build_dir" || die
	$PYTHON setup.py install
}

qdev_tst() {
	cd $qdev_build_dir || die
	cd test || die
	$PYTHON test.py
	if [ $? = 0 ]; then
		log_info "$FUNCNAME - $PROGNAME - installation was successful."
		return 0
	fi
	log_info "$FUNCNAME - $PROGNAME - installation was failed."
	return 1
}

#
# Required and optional software
#
#----------------------------------------
pkg=numpy
pkg_ver=1.9.2
#numpy-1.9.2-win32-superpack-python3.4.exe
#numpy-1.9.2-win32-superpack-python3.3.exe
if [ x$QDKe_VAR_IS_XP = "xtrue" ]; then
pkg_file=$pkg-$pkg_ver-win32-superpack-python${PYVER2}
else
pkg_file=$pkg-$pkg_ver-win32-superpack-python${PYVER2}
fi
pkg_ffile=$pkg_file.exe
pkg_dir=$pkg_file
pkg_url=http://jaist.dl.sourceforge.net/project/numpy/NumPy/1.9.2/$pkg_ffile
#----------------------------------------
pkg_deps_gcc=
pkg_deps_py=
#----------------------------------------
work_home=$QSTK_WORK_HOME
user_name=numpy
apps_name=numpy
apps_more=sourceforge
#----------------------------------------
qdev_init
qdev_set					$work_home $user_name $apps_name $apps_more
qdev_setmore
qdev_get
qdev_check
qdev_try
qdev_tst
