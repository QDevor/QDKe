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
	:
}

# qdev_set

# qdev_setmore

qdev_get() {
	utils_github_cloneWithResume   $work_home $user_name $apps_name
	utils_github_updateWithResume  $work_home $user_name $apps_name
	
	_pkg_file=lapack-3.5.0.tgz
	_pkg_url=http://www.netlib.org/lapack/lapack-3.5.0.tgz
	cd $QDKE_TMP || die
	loop_curl $_pkg_file $_pkg_url
	export _NETLIB_LAPACK_TARFILE=$QDKE_TMP/lapack-3.5.0.tgz
}

qdev_check() {
	:
}

qdev_build_config() {
	if [ ! -f $qdev_build_dir/${FUNCNAME}-stamp-config ]; then
		cd $qdev_build_dir
		$qdev_build_src/configure \
			--cc=$QDKe_BUILD_TARGET-gcc \
			-v 10 \
			-b $QDKe_VAR_nCMD \
			-D c -DPentiumCPS=$QDKe_VAR_CPUMHZ \
			--prefix=''$QDKe_BUILD_PREFIX'/'$QDKe_BUILD_TARGET'' \
			--with-netlib-lapack-tarfile=''$_NETLIB_LAPACK_TARFILE'' \
			|| die
		touch $qdev_build_dir/${FUNCNAME}-stamp-config
	fi
}

# qdev_build_make

qdev_try() {
	log_info "$FUNCNAME - $PROGNAME"
	
	set ORIGIN_HOME=$HOME
	set HOME=$qdev_build_dir
	cd $qdev_build_dir
	
	qdev_build_config
	qdev_build_make build   || die # tune & build lib
	qdev_build_make check   || die # sanity check correct answer
	qdev_build_make ptcheck || die # sanity check parallel
	qdev_build_make time    || die # check if lib is fast
	qdev_build_make install || die # copy libs to install dir
	
	set $HOME=$ORIGIN_HOME
	log_info "$FUNCNAME - $PROGNAME - Done - Sucessfull."
}

#----------------------------------------
# work_home=$QSTK_WORK_HOME
# user_name=?
# apps_name=?
# apps_more=?
#----------------------------------------
# qdev_init
# qdev_set					$work_home $user_name $apps_name $apps_more
# qdev_get
# qdev_check
# qdev_try

