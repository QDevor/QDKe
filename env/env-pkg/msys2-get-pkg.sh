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
. $PROGDIR/../env-msys2/entry-common.sh
#----------------------------------------
_msys2_getPkgInit() {
	PKG_MIRROR=http://jaist.dl.sourceforge.net/project
# lookup source code
# http://sourceforge.net/projects/msys2/files/Base/MSYS2/Sources/
# http://sourceforge.net/projects/msys2/files/REPOS/MSYS2/Sources/
# http://sourceforge.net/projects/msys2/files/Base/MINGW/Sources/
# http://sourceforge.net/projects/msys2/files/REPOS/MINGW/Sources/
# lookup install pkg
# http://sourceforge.net/projects/msys2/files/Base/MSYS2/i686/
# http://sourceforge.net/projects/msys2/files/Base/MSYS2/x86_64/
	PKG_LOOKUP_URL_0=http://sourceforge.net/projects/msys2/files/Base/MSYS2/
	PKG_LOOKUP_URL_1=http://sourceforge.net/projects/msys2/files/REPOS/MSYS2/
	PKG_LOOKUP_URL_2=http://sourceforge.net/projects/msys2/files/Base/MINGW/
	PKG_LOOKUP_URL_3=http://sourceforge.net/projects/msys2/files/REPOS/MINGW/
}

msys2_getPkgConf() {
	if [[ $1 != "src" || $1 != "bin" ]]; then
    log_error "Usage: $FUNCNAME src or $FUNCNAME bin."
	fi
	
	if [[ $1 == "src" ]]; then
		pkg_typ=Sources
	else
		pkg_typ=$QDKe_VAR_ARCH
	fi
}

msys2_getPkgVer() {
	if [[ ! $# -eq 1 ]]; then
    log_error "Usage: $FUNCNAME pkg."
	fi
	
	pkg_ver=
	pkg_rel=
	pkg_url=
	
	pkgverrel=`wget -q -O- ''$PKG_LOOKUP_URL_1'/'$pkg_typ'/' | \
		grep -i 'msys2/files/REPOS/MSYS2/'$pkg_typ'/' | \
		sed -n 's,.*/'$pkg_nam'-\([0-9\.]*-.*\)\.src.tar.*/.*,\1,p' | \
		head -1`
	
	pkg_ver=`echo $pkgverrel | cut -d '-' -f1`
	pkg_rel=`echo $pkgverrel | cut -d '-' -f2`
	
	#	pkgurl=$PKG_MIRROR/msys2/Base/MSYS2/Sources/
	#	pkgurl=$PKG_MIRROR/msys2/Base/MINGW/Sources/
	#	pkgurl=$PKG_MIRROR/msys2/REPOS/MINGW/Sources/
	pkg_url=$PKG_MIRROR/msys2/REPOS/MSYS2/$pkg_typ
	echo "$FUNCNAME - $pkg_url."
}

msys2_getPkg() {
	cd $QDKe_TMP
	
	pkg_file=$pkg_nam-$pkg_ver-$pkg_rel.src.tar.gz

	wget -c -T 30 -t 3 -q ''$pkg_url'/'$pkg_file''
	
	mkdir -p $WORK_HOME/msys2 >/dev/null 2>&1
	cd $WORK_HOME/msys2
	extract $QDKe_TMP/$pkgfile
}

#----------------------------------------
_msys2_getPkgInit
# 
# pkg_nam=flex
# pkg_typ=src
# pkg_ver=?
# pkg_rel=?
# pkg_url=?
# msys2_getPkgConf src
# msys2_getPkgConf bin
# msys2_getPkgVer
# msys2_getPkg
#----------------------------------------
