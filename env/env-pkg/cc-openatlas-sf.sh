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
. $PROGDIR/../env-pkg/tools-txt2man.sh
. $PROGDIR/../env-pkg/cc-mathatlas-common.sh
#----------------------------------------

qdev_init() {
	export OPENATLAS_ROOT=$QDK_OPT_DIR/$pkg_file
}

# qdev_set

# qdev_setmore 

qdev_get() {
	cd $QDKE_TMP || die

	_pkg_url=http://ncu.dl.sourceforge.net/project/openblas/v0.2.14/$pkg_ffile
	cd $QDKE_TMP || die
	loop_curl $_pkg_file $_pkg_url
	cd $QDK_OPT_DIR || die
	extract $pkg_ffile
}

# qdev_check

# qdev_build_config

# qdev_build_make

# qdev_try

# qdev_tst

#
# Required and optional software
#
pkg=OpenBLAS
pkg_ver=v0.2.14
if [ x$QDKe_VAR_IS_XP = "xtrue" ]; then
pkg_file=OpenBLAS-v0.2.14-Win32
else
#pkg_file=OpenBLAS-v0.2.14-Win64-int32
pkg_file=OpenBLAS-v0.2.14-Win64-int64
fi
pkg_ffile=$pkg_file.zip
pkg_dir=$pkg_file
pkg_url=http://sourceforge.net/projects/openblas/files/v0.2.14/

pkg_deps_gcc=''
pkg_deps_py=''
#----------------------------------------
work_home=$QSTK_WORK_HOME
user_name=math-atlas
apps_name=math-atlas
apps_more=sourceforge
#----------------------------------------
qdev_init
qdev_set					$work_home $user_name $apps_name $apps_more
qdev_setmore
qdev_get
#qdev_check
#qdev_try
#qdev_tst
