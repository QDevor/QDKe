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

# qdev_init 

# qdev_set

# qdev_setmore 

qdev_get() {
	cd $QDKE_TMP || die
	loop_curl $pkg_file $pkg_url
	export _NETLIB_LAPACK_TARFILE=$QDKE_TMP/lapack-3.5.0.tgz
	
	_pkg_file=lapack-3.5.0.tgz
	_pkg_url=http://www.netlib.org/lapack/lapack-3.5.0.tgz
	cd $QDKE_TMP || die
	loop_curl $_pkg_file $_pkg_url
	export _NETLIB_LAPACK_TARFILE=$QDKE_TMP/lapack-3.5.0.tgz
}

# qdev_check

# qdev_build_config

# qdev_build_make

# qdev_try

# qdev_tst

#
# Required and optional software
#
pkg=math-atlas
pkg_ver=3.10.2
pkg_file=$pkg-$pkg_ver.tar.bz2
pkg_dir=$pkg-$pkg_ver
#pkg_url=http://liquidtelecom.dl.sourceforge.net/project/math-atlas/Stable/3.10.2/atlas3.10.2.tar.bz2
pkg_url=http://liquidtelecom.dl.sourceforge.net/project/math-atlas/Stable/$pkg_ver/atlas$pkg_ver.tar.bz2

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
qdev_check
qdev_try
qdev_tst
