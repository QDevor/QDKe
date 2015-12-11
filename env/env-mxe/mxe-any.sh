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
  export DONT_CHECK_REQUIREMENTS=1
	return 0
	
	if [ "dirty_do" == "dirty_undo" ]; then
	
	touch $QDKE_ROOT/home/mxe/usr/installed/check-requirements >/dev/null 2>&1
	touch $QDKE_ROOT/home/mxe/usr/x86_64-pc-mingw32/installed/lua >/dev/null 2>&1
	
	# mxe-conf pkgconf mingw-w64 binutils gcc
	touch $QDKE_ROOT/home/mxe/usr/i686-w64-mingw32.static/installed/mxe-conf >/dev/null 2>&1
	touch $QDKE_ROOT/home/mxe/usr/i686-w64-mingw32.static/installed/pkgconf >/dev/null 2>&1
	touch $QDKE_ROOT/home/mxe/usr/i686-w64-mingw32.static/installed/mingw-w64 >/dev/null 2>&1
	touch $QDKE_ROOT/home/mxe/usr/i686-w64-mingw32.static/installed/binutils >/dev/null 2>&1
	touch $QDKE_ROOT/home/mxe/usr/i686-w64-mingw32.static/installed/gcc >/dev/null 2>&1
	
	fi
	
	return 0
}

# qdev_set

qdev_setmore() {
	qdev_build_top=$work_home
	qdev_build_src=$qdev_build_top
	qdev_build_dir=$qdev_build_top
	
	[ -d $qdev_build_top ] || mkdir -p $qdev_build_top >/dev/null 2>&1
	rm -rf $qdev_build_top/mxe > /dev/null 2>&1
}

qdev_get() {
  SCM_URL='https://github.com/'$user_name'/'$apps_name''
  if [ ! -f $qdev_build_dir/${FUNCNAME}-stamp-init ]; then
	  cd $qdev_build_top
	  git init
	  git fetch ${SCM_URL}
	  git remote add origin ${SCM_URL}
	  git checkout FETCH_HEAD
	  
	  #scm_update  $work_home $user_name $apps_name $apps_more
	  touch $qdev_build_dir/${FUNCNAME}-stamp-init
	fi
}

# qdev_check

qdev_build_prepare() {
	log_info "$FUNCNAME - $PROGNAME"
	
	cd $qdev_build_src
	
}

qdev_build_fix() {
	:
	# touch $qdev_build_dir/${FUNCNAME}-stamp-fix
}

# qdev_build_config

# qdev_build_cmake

qdev_build_make() {
	if [ ! -f $qdev_build_src/${FUNCNAME}-stamp-make$1 ]; then
		cd $qdev_build_src
		#make MXE_TARGETS='x86_64-w64-mingw32.static i686-w64-mingw32.static'
		#BUILD='i686-w64-mingw32.static'
		
		doloop=1
		while [ $doloop = 1 ]; do
		  
		  echo [build] - [$@]
		  
		  # make $@
		  
		  # Do Not Loop ...
		  make EXCLUDE_PKGS='boost qt' --keep-going
		  break
		  
		  read -n1 -p "Press 'q' to continue and any other key to again..." _press_key
      echo -ne '\b \n'
      case $_press_key in
      Y | y) echo
        echo "fine ,continue on ..";;
      N | n) echo
        echo "fine ,continue on ..";;
      Q | q) echo
        echo "OK, goodbye...";
        break;;
      *) echo
        echo "fine ,continue on ..";;
      esac
      
			sleep 3
		done
		
		# touch $qdev_build_src/${FUNCNAME}-stamp-make$1
	fi
}

qdev_build_make_download() {
	if [ ! -f $qdev_build_src/${FUNCNAME}-stamp-make$1 ]; then
		cd $qdev_build_src
		
		doloop=1
		while [ $doloop = 1 ]; do
			#rm -rf /var/lib/pacman/db.lck > /dev/null 2>&1
			make download --keep-going
			if [ $? = 0 ]; then
				break;
			fi
			log_warning "${FUNCNAME} - download failed - auto try again."
			sleep 3
		done
    
		touch $qdev_build_src/${FUNCNAME}-stamp-make$1
	fi
}

qdev_build_make_install() {
	if [ ! -f $qdev_build_src/${FUNCNAME}-stamp-make$1 ]; then
		cd $qdev_build_src
		cp -rf build/libseh.a  libseh.a \
			|| die
		touch $qdev_build_src/${FUNCNAME}-stamp-make$1
	fi
}

qdev_dirty_do() {
  :
  return 0
  log_info "$FUNCNAME - $PROGNAME"
  
  missing_dll=zlib1.dll libiconv-2.dll libgcc_s_dw2-1.dll libwinpthread-1.dll
  
  i686_w64_mingw32_missing_dll_srcdir=$QDK_ROOT/mingw32/bin
  x86_64_w64_mingw32_missing_dll_srcdir=$QDK_ROOT/mingw64/bin
  
  i686_w64_mingw32_missing_dll_destdir=$QDKE_ROOT/home/mxe/i686-w64-mingw32.static/bin
  x86_64_w64_mingw32_missing_dll_destdir=$QDKE_ROOT/home/mxe/x86_64-w64-mingw32.static/bin
  mxe_missing_dll_destdir=$QDKE_ROOT/home/mxe/usr/bin
  
  missing_dll_srcdir=$i686_w64_mingw32_missing_dll_srcdir 
  missing_dll_destdir=&mxe_missing_dll_destdir
  
    for dll in $missing_dll; do
      dll=`echo $dep | tr '=' ' '`
      cp -rf 
    done
  log_info "$FUNCNAME - $PROGNAME - Done - Sucessfull."
}

qdev_dirty_undo() {
  :
  return 0
  log_info "$FUNCNAME - $PROGNAME"
  log_info "$FUNCNAME - $PROGNAME - Done - Sucessfull."
}

qdev_dirty_copy_missing_dlls() {
  if [ ! -f $qdev_build_src/usr/installed/${FUNCNAME}-stamp ]; then
  
    log_info "$FUNCNAME - $PROGNAME"
    
    missing_dll="zlib1.dll libiconv-2.dll libgcc_s_dw2-1.dll libwinpthread-1.dll"
    
    i686_w64_mingw32_missing_dll_srcdir=$MSYS_ROOT/mingw32/bin
    x86_64_w64_mingw32_missing_dll_srcdir=$MSYS_ROOT/mingw64/bin
    
    i686_w64_mingw32_missing_dll_destdir=$QDKE_ROOT/home/mxe/i686-w64-mingw32.static/bin
    x86_64_w64_mingw32_missing_dll_destdir=$QDKE_ROOT/home/mxe/x86_64-w64-mingw32.static/bin
    mxe_missing_dll_destdir=$QDKE_ROOT/home/mxe/usr/bin
    
    missing_dll_srcdir=$i686_w64_mingw32_missing_dll_srcdir 
    missing_dll_destdir=$mxe_missing_dll_destdir
  
    cd $qdev_build_src
    
    cd $missing_dll_srcdir
    cp -rf $missing_dll $missing_dll_destdir
    
    #for dll in $missing_dll; do
    #  dll=`echo $dep | tr ' ' ''`
    #  cp -rf 
    #done
    
    touch $qdev_build_src/usr/installed/${FUNCNAME}-stamp
    
    log_info "$FUNCNAME - $PROGNAME - Done - Sucessfull."
  fi
  return 0
}

qdev_try() {
	log_info "$FUNCNAME - $PROGNAME"
	
	cd $qdev_build_dir || die
	
	qdev_dirty_do
	
	# qdev_build_config
	# qdev_build_cmake
	# qdev_build_make_download
	qdev_build_make $@
	
	qdev_dirty_undo
	qdev_dirty_copy_missing_dlls
	
	log_info "$FUNCNAME - $PROGNAME - Done - Sucessfull."
}

# qdev_tst

#
# Required and optional software
#
#----------------------------------------
work_home=$WORK_HOME/mxe
user_name=mxe
apps_name=mxe
apps_more=github
# Standard Source Distribution
#----------------------------------------
qdev_init
qdev_set					$work_home $user_name $apps_name $apps_more
qdev_setmore
qdev_get					$pkg $pkg_ver $pkg_file $pkg_ffile $pkg_url
qdev_check
qdev_try          $@
#qdev_tst
