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
. $PROGDIR/../env-msys2/utils-python-qstk.sh
#----------------------------------------
# . $PROGDIR/../env-pkg/tools-txt2man.sh
#----------------------------------------
QDKeDev_init() {
	:
}

QDKeDev_set() {
	log_info "$FUNCNAME"
	
	work_home=$1
	user_name=$2
	apps_name=$3
}

QDKeDev_check() {
	:
}

QDKeDev_get() {
	utils_github_cloneWithResume   $work_home $user_name $apps_name
	utils_github_updateWithResume  $work_home $user_name $apps_name
	
	_pkg_file=lapack-3.5.0.tgz
	_pkg_url=http://www.netlib.org/lapack/lapack-3.5.0.tgz
	cd $QDKE_TMP || die
	loop_curl $_pkg_file $_pkg_url
	export QDEV_NETLIB_LAPACK_TARFILE=$QDKE_TMP/lapack-3.5.0.tgz
}

QDKeDev_try() {
	:
}

#----------------------------------------
work_home=$QSTK_WORK_HOME
user_name=vtjnash
apps_name=atlas-3.10.0
#----------------------------------------
QDKeDev_init
QDKeDev_set					$work_home $user_name $apps_name
QDKeDev_check
QDKeDev_try

