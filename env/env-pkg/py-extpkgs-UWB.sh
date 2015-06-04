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
extpkgs_uwb_saveHomeHtml() {
	current_datetime=`date +%m`
	filedate=`stat $TMP/py-extpkgs_home.html | grep Modify | awk '{print $2}'`
	filetime=`stat $TMP/py-extpkgs_home.html | grep Modify | awk '{split($3,var,".");print var[1]}'`
	file_datetime=`date -d "$filedate $filetime" +%m`
	timedelta=`expr $current_datetime - $file_datetime`
	#if [ "$timedelta" -gt "180" ];then
	if [ "$timedelta" -gt "5" ];then
		rm -rf $TMP/${PROGNAME}-stamp
	fi
	if [ -f $TMP/${PROGNAME}-stamp ] && [ -f $TMP/py-extpkgs_home.html ]; then
		return 0
	fi
	wget -q -O- ''$extpkgs_uwb_url'/' >$QDKE_TMP/py-extpkgs_home.html
	touch $TMP/${PROGNAME}-stamp
}

extpkgs_uwb_findPkgByName() {
	extpkgs_uwb_saveHomeHtml
	
	_pkg_pyver=cp`echo $PYVER2 | tr -d '.'`
	_pkg_typ=win_amd64
	[ x$QDKe_VAR_IS_XP = "xtrue" ] && _pkg_typ=win32
	#echo _pkg_pyver=$_pkg_pyver, _pkg_typ=$_pkg_typ
	
	pkg_nam=$1
	pkgverrel=`cat $QDKE_TMP/py-extpkgs_home.html | \
			grep -i '>'$pkg_nam'&#8209;.*whl' | \
			sed 's/&#8209;/-/g' | \
			sed -n 's,.*'$pkg_nam'-\([0-9\.+a-z]*-.*\)\.whl.*,\1,p' | \
			head -1`
	
	#molmod-1.1-cp27-none-win_amd64.whl
	#moviepy-0.2.2.11-py2.py3-none-any.whl
	_pkg_rver=`echo $pkgverrel | cut -f1 -d'-'`
	_pkg_rpyver=`echo $pkgverrel | cut -f2 -d'-'`
	_pkg_rtyp=`echo $pkgverrel | cut -f4 -d'-'`
	
	[ x$_pkg_rtyp = "xany" ] && _pkg_typ=$_pkg_rtyp
	[ x$_pkg_rpyver = "xpy2.py3" ] && _pkg_pyver=$_pkg_rpyver
	
	#echo pkgverrel=$pkgverrel
	#echo _pkg_rver=$_pkg_rver, _pkg_rpyver=$_pkg_rpyver, _pkg_rtyp=$_pkg_rtyp
	#echo _pkg_pyver=$_pkg_pyver, _pkg_typ=$_pkg_typ
	
	_pkg_ffile=$pkg_nam-$_pkg_rver-$_pkg_pyver-none-$_pkg_typ.whl
	#echo _pkg_ffile=$_pkg_ffile
	
	[ x$pkgverrel = "x" ] && log_error "$FUNCNAME - Not Found pkg($pkg_nam) version."
}

#http://www.lfd.uci.edu/~gohlke/pythonlibs/68tmfkay/numpy-1.9.2+mkl-cp27-none-win_amd64.whl
extpkgs_uwb_getPkg() {
	_pkg_url=$extpkgs_uwb_dnl/$_pkg_ffile
	cd $qdev_build_top || die
	loop_wget $_pkg_ffile $_pkg_url
}

extpkgs_uwb_installPkg() {
	qdev_set					$work_home $user_name $apps_name $apps_more
	cd $qdev_build_top || die
	extpkgs_uwb_findPkgByName $apps_name
	extpkgs_uwb_getPkg
	
	check_pkg_exist=utils_python_checkPkgExist
	
	if [ x$check_pkg_exist = x"1" ]; then
		log_info "Python Installed - $pkg_nam."
		return 1
	else
		log_info "Python Installing - $pkg_nam."
	fi
	
	if [ ! -f $qdev_build_top/$FUNCNAME-$pkg_nam-stamp ]; then
		$PIP install $_pkg_ffile || die
		touch $qdev_build_top/$FUNCNAME-$pkg_nam-stamp
	else
		log_info "Python Installing Ignore - $pkg_nam."
	fi
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
#qdev_set					$work_home $user_name $apps_name $apps_more
#qdev_setmore
#qdev_get
#qdev_check
#qdev_try
#qdev_tst
