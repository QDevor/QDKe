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
. $PROGDIR/../env-pkg/py-extpkgs-UnofficialWindowsBinaries.sh
#----------------------------------------
qdev_try() {
	apps_name=numpy && extpkgs_uwb_installPkg || die
	apps_name=scipy && extpkgs_uwb_installPkg || die
	apps_name=pandas && extpkgs_uwb_installPkg || die
}

#
# Required and optional software
#
#----------------------------------------
#extpkgs_uwb_url=http://www.lfd.uci.edu/~gohlke/pythonlibs
#extpkgs_uwb_dnl=$extpkgs_uwb_url/68tmfkay
#extpkgs_uwb_pkg=
#----------------------------------------
work_home=$QSTK_WORK_HOME
user_name=extpkgs_uwb
#apps_name=
#apps_more=
#----------------------------------------
# pkg_nam=?
# pkg_typ=?
# pkg_ver=?
# pkg_rel=?
# pkg_url=?
#----------------------------------------
qdev_init
#qdev_set					$work_home $user_name $apps_name $apps_more
#qdev_setmore
#qdev_get
#qdev_check
qdev_try
#qdev_tst
