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
. $PROGDIR/../env-andr/andr-common.sh
#----------------------------------------

_njs_common_init() {
	:

}

# qdev_init() {

# qdev_set

qdev_setmore() {
	:
}

# qdev_get
# qdev_check
# qdev_try
# qdev_try_extra
qdev_tst() {
	:
	cd $qdev_build_src ||die
	andr_gradle_buildDbg ||die
}

#----------------------------------------
#
# Required and optional software
#
pkg=
pkg_ver=
pkg_file=$pkg-$pkg_ver
pkg_ffile=$pkg_file.zip
pkg_dir=$pkg-$pkg_ver
pkg_url=

pkg_deps_njs=''
#----------------------------------------
work_home=$QDEV_ANDR_WORK_HOME
user_name=SayCV
apps_name=StockArtifact
apps_more=bitbucket
# Standard Source Distribution
#----------------------------------------
qdev_init
qdev_set					$work_home $user_name $apps_name $apps_more
qdev_setmore
qdev_get
qdev_check
# qdev_try
# qdev_try_extra
qdev_tst
#----------------------------------------