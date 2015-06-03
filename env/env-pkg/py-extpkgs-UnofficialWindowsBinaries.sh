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

#numpy-1.9.2+mkl-cp27-none-win32.whl
#wget -q -O- 'http://www.lfd.uci.edu/~gohlke/pythonlibs/' | grep -i '\>numpy&#8209*.whl\<\/a\>'
extpkgs_uwb_findPkgByName() {
	pkg_nam=$1
	pkgverrel=`wget -q -O- ''$extpkgs_uwb_url'/' | \
			grep -i '>'$pkg_nam'&#8209;.*whl' | \
			sed 's/&#8209;/-/g' | \
			sed -n 's,.*'$pkg_nam'-\([0-9\.]*-.*\)\.whl.*,\1,p' | \
			head -1`
	[ -n $pkgverrel] || log_error "$FUNCNAME - Not Found pkg version."
	pkg_ffile=$pkg_nam-$pkgverrel.whl
	echo $pkg_ffile
}

extpkgs_uwb_getPkg() {
	pkg_url=$extpkgs_uwb_dnl/$pkg_ffile
	cd $qdev_build_top || die
	loop_wget $pkg_ffile $pkg_url
}

extpkgs_uwb_installPkg() {
	qdev_set					$work_home $user_name $apps_name $apps_more
	cd $qdev_build_top || die
	extpkgs_uwb_findPkgByName $apps_name
	extpkgs_uwb_getPkg
	
	$PIP install $pkg_ffile || die
}

#
# Required and optional software
#
#----------------------------------------
extpkgs_uwb_url=http://www.lfd.uci.edu/~gohlke/pythonlibs
extpkgs_uwb_dnl=$extpkgs_uwb_url/68tmfkay
extpkgs_uwb_pkg=
#----------------------------------------
work_home=$QSTK_WORK_HOME
user_name=extpkgs_uwb
apps_name=
apps_more=
#----------------------------------------
# pkg_nam=?
# pkg_typ=?
# pkg_ver=?
# pkg_rel=?
# pkg_url=?
#----------------------------------------
qdev_init
qdev_set					$work_home $user_name $apps_name $apps_more
#qdev_setmore
#qdev_get
#qdev_check
#qdev_try
#qdev_tst
