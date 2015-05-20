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
_msys2_getpkg_init() {
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

_msys2_getpkg_checkArgsNum() {
	if [[ $# -lt 3 ]]; then
		log_error "We Are Checking arguments mismatch."
		# return 1
	fi
	return 0
}

_msys2_getpkg_checkArgsValidity() {
	if [[ $work_home == "" ]]; then
		log_error "We Are Checking work_home is NULL."
	fi
	if [[ $user_name == "" ]]; then
		log_error "We Are Checking user_name is NULL."
	fi
	if [[ $apps_name == "" ]]; then
		log_error "We Are Checking apps_name is NULL."
	fi
	
	if [[ $pkg_nam == "" ]]; then
		log_error "We Are Checking pkg_nam is NULL."
	fi
	if [[ $pkg_ver == "" ]]; then
		log_error "We Are Checking pkg_ver is NULL."
	fi
	if [[ $pkg_rel == "" ]]; then
		log_error "We Are Checking pkg_rel is NULL."
	fi
#	if [[ $pkg_url == "" ]]; then
#		log_error "We Are Checking pkg_url is NULL."
#	fi
	return 0
}

msys2_getpkg_setWork() {
	_msys2_getpkg_checkArgsNum $1 $2 $3
	work_home=$1
	user_name=$2
	apps_name=$3
	
	pkg_nam=$apps_name
	pkg_ver=
	pkg_rel=
	pkg_url=
	
	cd $work_home || die
	mkdir -p $user_name/$apps_name >/dev/null 2>&1
}

msys2_getpkg_setType() {
	if [[ $1 != "src" && $1 != "bin" ]]; then
    log_error "Usage: $FUNCNAME src or $FUNCNAME bin."
	fi
	
	if [[ $1 == "src" ]]; then
		pkg_typ=Sources
	else
		pkg_typ=$QDKe_VAR_ARCH
	fi
}

msys2_getpkg_getVer() {
	log_info "Searching from $PKG_LOOKUP_URL_1."
	
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
	pkg_file=$pkg_nam-$pkg_ver-$pkg_rel.src.tar.gz
	
	log_info "Found - $pkg_url/$pkg_file."
}

msys2_getpkg_getPkg() {
	msys2_getpkg_getVer
	
	_msys2_getpkg_checkArgsValidity
	
	cd $QDKE_TMP || die
	
	[ -d $QDKE_LOGDIR/$user_name ] || mkdir -p $QDKE_LOGDIR/$user_name
	
	wget -c -T 30 -t 3 -q $wget_quiet "$pkg_url/$pkg_file" \
		&>$QDKE_LOGDIR/$user_name/$apps_name-download
	
	cd $work_home/$user_name/$apps_name || die
	extract $QDKE_TMP/$pkg_file
}

#----------------------------------------
_msys2_getpkg_init
# 
# pkg_nam=?
# pkg_typ=?
# pkg_ver=?
# pkg_rel=?
# pkg_url=?
# msys2_getpkg_setWork
# msys2_getpkg_setType src/bin
# msys2_getpkg_getVer
# msys2_getpkg_getPkg
#----------------------------------------
