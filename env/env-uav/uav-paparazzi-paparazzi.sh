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
. $PROGDIR/../env-uav/uav-common.sh
#----------------------------------------
qdev_init() {
  if [ ! -f $QDK_STAMPDIR/$FUNCNAME-$PROGNAME-stamp ]; then
		utils_msys2_installByPacman $msys2_deps
#		touch $QDK_STAMPDIR/$FUNCNAME-$PROGNAME-stamp
	fi
}

qdev_setmore() {
  qdev_build_dir=$qdev_build_src
  
  export PAPARAZZI_HOME=$QDKE_USR/paparazzi
  export PAPARAZZI_SRC=$qdev_build_src
  
  export PPZ_ORIGIN_HOME=$HOME
  export HOME=$qdev_build_src
  
  export PATH="$QDKE_ROOT/home/uav_home/OpenPilot/OpenPilot/tools/gcc-arm-none-eabi-4_9-2014q4/bin:$PATH"
  export PREFIX=arm-none-eabi
	return 0
}
# qdev_get
#----------------------------------------
uav_any_fix() {
  fix_file=$OCAMLFIND_CONF
  if [ ! -f $fix_file ]; then
    return 0
  fi
  
  xlib_pprz_ocaml_path=$( \
		cygpath -w $qdev_build_dir/sw/lib/ocaml | \
		sed -e "s,\\\,\\\\\\\,g" | \
		sed -e "s,\\\,\\\\\\\,g" \
	)
	xlib_pprz_ocaml_path_1=$( \
		cygpath -w $qdev_build_dir/sw/lib/ocaml | \
		sed -e "s,\\\,\\\\\\\,g" \
	)
  echo [debug] xlib_pprz_ocaml_path=$xlib_pprz_ocaml_path
  fix_val=`cat $fix_file | grep "path=" | grep "$xlib_pprz_ocaml_path"`
  echo [debug] fix_val=$fix_val
  fix_val_exists=true
  if [ x"$fix_val" == x ]; then
    fix_val_exists=false
  fi
  if [ x"$fix_val_exists" == xfalse ]; then
    sed -i -e "s,path=\"\(.*\)\",path=\"\1;$xlib_pprz_ocaml_path\",g" \
      $fix_file
  fi
  return 0
}

uav_any_unfix() {
  export HOME=$PPZ_ORIGIN_HOME
  
  fix_file=$OCAMLFIND_CONF
  if [ ! -f $fix_file ]; then
    return 0
  fi
  xlib_pprz_ocaml_path=$qdev_build_dir/sw/lib/ocaml
  return 0
}

uav_any_init() {
  uav_common_init
  return 0
}

uav_any_conf() {
#  uav_common_conf
  
  echo [debug] PAPARAZZI_HOME=$PAPARAZZI_HOME
  echo [debug] PAPARAZZI_SRC=$PAPARAZZI_SRC
  if [ ! -f $qdev_build_dir/${FUNCNAME}-stamp-config ]; then
    uav_common_make clean
    touch $qdev_build_dir/${FUNCNAME}-stamp-config
	fi
  return 0
}

uav_any_make() {
  cd $qdev_build_dir
  uav_common_make Q=''
  return 0
}

uav_any_make_aircraft() {
  cd $qdev_build_dir
  
	make -C /mnt/hgfs/vmwareShares/paparazzi -f Makefile.ac AIRCRAFT=krooz_quad clean_ac
	make -C /mnt/hgfs/vmwareShares/paparazzi -f Makefile.ac AIRCRAFT=krooz_quad ap.compile
	make -C /mnt/hgfs/vmwareShares/paparazzi -f Makefile.ac AIRCRAFT=krooz_quad FLASH_MODE=DFU-UTIL ap.upload
	
  return 0
}

uav_any_main() {
  uav_any_init
  uav_any_fix
  uav_any_conf
  uav_any_make
  uav_any_unfix
  return 0
}

#----------------------------------------
# https://forge.ocamlcore.org
work_home=$QUAV_WORK_HOME
user_name=paparazzi
apps_name=paparazzi
apps_more=github
msys2_deps='pkg-config gtk2 gnome-common gxml xml-light ocaml ocaml-camlp4 ocaml-findlib'
#----------------------------------------
qdev_init
qdev_set					$work_home $user_name $apps_name $apps_more
qdev_setmore
qdev_get					$work_home $user_name $apps_name $apps_more

uav_any_main
