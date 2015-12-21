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
  #export OCAMLFIND_CONF=$QDKE_CFG_PATH/etc/findlib.conf
  OCAML_ROOT=`cygpath -w $QDK_ROOT/OCaml`
  export OCAMLFIND_CONF=`cygpath -w $OCAML_ROOT/etc/findlib.conf`
  export OCAMLLIB=`cygpath -w $OCAML_ROOT/lib`
  export PATH=$QDK_ROOT/OCaml/bin:$PATH
  return 0
  if [ ! -f $QDK_STAMPDIR/$FUNCNAME-$PROGNAME-stamp ]; then
		utils_msys2_installByPacman $msys2_deps
#		touch $QDK_STAMPDIR/$FUNCNAME-$PROGNAME-stamp
	fi
}

qdev_setmore() {
  #qdev_build_dir=$qdev_build_src
	return 0
}
# qdev_get

qdev_build_config() {
	[ -d $qdev_build_dir ] || mkdir -p $qdev_build_dir
	if [ ! -f $qdev_build_dir/${FUNCNAME}-stamp-config ]; then
		cd $qdev_build_dir
		$qdev_build_src/configure \
			 $@ \
			|| die
		touch $qdev_build_dir/${FUNCNAME}-stamp-config
	fi
}
#----------------------------------------
qdev_any_init() {
  qdev_init
  return 0
}

qdev_any_conf() {
  log_info "$FUNCNAME - $PROGNAME"
  qdev_build_config $@
  return 0
}

qdev_any_make() {
  log_info "$FUNCNAME - $PROGNAME"
  qdev_build_make $@
  return 0
}

qdev_any_install() {
  log_info "$FUNCNAME - $PROGNAME"
  #qdev_any_make install
  return 0
}

qdev_any_main() {
  #qdev_any_init
  
  qdev_build_dir_backup=$qdev_build_src
  qdev_build_src=$qdev_build_dir_backup.core
  qdev_build_dir=$qdev_build_src
  #[ -d $qdev_build_dir ] || mkdir -p $qdev_build_dir
  if [ ! -f $qdev_build_dir/${FUNCNAME}-stamp-copy-src ]; then
    var=`basename $qdev_build_dir_backup`
    cd $qdev_build_top
    cp -rf $var $var.core || die
    touch $qdev_build_dir/${FUNCNAME}-stamp-copy-src
  fi
  
  qdev_any_conf # CORE only
  qdev_any_make all
  qdev_any_make opt
  
  #qdev_any_make install
  [ -d $qdev_build_dir/install_destdir ] || mkdir -p $qdev_build_dir/install_destdir
  cd $qdev_build_dir
  env OCAMLFIND_DESTDIR="$qdev_build_dir/install_destdir" make install
  
  return 0
  
  qdev_build_src=$qdev_build_dir_backup.addon
  qdev_build_dir=$qdev_build_src
  #[ -d $qdev_build_dir ] || mkdir -p $qdev_build_dir
  if [ ! -f $qdev_build_dir/${FUNCNAME}-stamp-copy-src ]; then
    var=`basename $qdev_build_dir_backup`
    cd $qdev_build_top
    cp -rf $var $var.addon || die
    touch $qdev_build_dir/${FUNCNAME}-stamp-copy-src
  fi
  
  qdev_any_conf -disable-core
  
  qdev_any_make all \
    INC_NETSYS="-package netsys" \ 
    INC_NETSTRING="-package netstring" \ 
    INC_EQUEUE="-package equeue" \ 
    INC_NETCGI2="-package netcgi2" \ 
    INC_NETCGI2_APACHE="-package netcgi2-apache" \ 
    INC_NETPLEX="-package netplex" \ 
    INC_NETCAMLBOX="-package netcamlbox" \ 
    INC_RPC="-package rpc" \ 
    INC_SHELL="-package shell" \ 
    INC_NETGSSAPI="-package netgssapi"
  # qdev_any_make opt
  
  # env OCAMLFIND_DESTDIR="<dir>" make install
  # make uninstall
  # qdev_any_install
  
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
user_name=whitequark
apps_name=ocamlnet
apps_more=github
# https://godirepo.camlcity.org/svn/lib-ocamlnet2/trunk/code
# Standard Source Distribution
#----------------------------------------
#qdev_init
qdev_set					$work_home $user_name $apps_name $apps_more
qdev_setmore
qdev_get					$pkg $pkg_ver $pkg_file $pkg_ffile $pkg_url
qdev_check
#qdev_try
#qdev_tst
env > ocaml-netclient.env
qdev_any_main
