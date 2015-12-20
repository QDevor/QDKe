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

#----------------------------------------
qdev_init() {
  if [ ! -f $QDK_STAMPDIR/$FUNCNAME-$PROGNAME-stamp ]; then
		utils_msys2_installByPacman $msys2_deps
#		touch $QDK_STAMPDIR/$FUNCNAME-$PROGNAME-stamp
	fi
}

qdev_setmore() {
  qdev_build_dir=$qdev_build_src
	return 0
}
# qdev_get
#----------------------------------------
qdev_any_init() {
  qdev_init
  return 0
}

qdev_any_conf() {
  qdev_build_config
  return 0
}

qdev_any_make() {
  #qdev_build_make
  cd $qdev_build_dir/src
  make -f Makefile.mingw
  
  #cd $qdev_build_dir/tools
  #make -f Makefile.mingw
  
  return 0
}

qdev_any_install() {
  #qdev_build_make_install
  PREFIX=$MINGW_ROOT
  
  cd $qdev_build_dir/src
  #install -m644 libivy.a $PREFIX/lib
	#install -m644 libgivy.a $PREFIX/lib
	#install -m644 libxtivy.a $PREFIX/lib
	#install -m644 libtclivy.a $PREFIX/lib
	#install -m644 libgtkivy.a $PREFIX/lib
	for f in *.a
	do
	  install -m644 $f $PREFIX/lib
	done
	
	for f in *.pc
	do
	  sed -i 's,^prefix=,prefix='$PREFIX',' $f
	  install -m644 $f $PREFIX/lib/pkgconfig
	done
	
	[ -d $PREFIX/include/Ivy ] || mkdir -p $PREFIX/include/Ivy
	install -m644 *.h $PREFIX/include/Ivy
	
	cd $qdev_build_dir/tools
	install -m755 ivyprobe $PREFIX/bin
	#install -m755 ivyglutprobe $PREFIX/bin
  return 0
}

qdev_any_main() {
  #qdev_any_init
  #qdev_any_conf
  qdev_any_make
  qdev_any_install
  
  return 0
}

# qdev_try
# qdev_tst

#
# Required and optional software
#
pkg=xml-light
pkg_ver=2.2
pkg_file=$pkg-$pkg_ver
pkg_ffile=$pkg_file.zip
pkg_dir=$pkg
# http://tech.motion-twin.com/zip/xml-light-2.2.zip
pkg_url=http://tech.motion-twin.com/zip/$pkg_ffile

pkg_deps_gcc=''
pkg_deps_py=''
#----------------------------------------
work_home=$QDEV_WORK_HOME
user_name=flixr
apps_name=ivy-c
apps_more=github
# http://svn.tls.cena.fr/svn/ivy/ivy-c
# Standard Source Distribution
#----------------------------------------
#qdev_init
qdev_set					$work_home $user_name $apps_name $apps_more
qdev_setmore
qdev_get					$pkg $pkg_ver $pkg_file $pkg_ffile $pkg_url
qdev_check
#qdev_try
#qdev_tst
qdev_any_main
