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

#----------------------------------------
if [[ x$INCLUDE_READY_MSYS2_SCRIPT == "xtrue" ]]; then
	:
else
#----------------------------------------
_PGMDIR_READY_MSYS2=`dirname $0`
_PGMDIR_READY_MSYS2=`cd $_PGMDIR_READY_MSYS2 && pwd -P`
_FN_READY_MSYS2=`basename $0`
_FNTYPE_READY_MSYS2=${_FN_READY_MSYS2#*.}
_FNNAME_READY_MSYS2=${_FN_READY_MSYS2%.*}
#----------------------------------------

_ready_msys2_updating_localpkgs() {
	log_warning "$(echo $FUNCNAME | cut -f4-5 -d'_' | tr '_' ' ')."
	if [ ! -f $QDK_STAMP_DIR/$FUNCNAME-stamp ]; then
		doloop=1
		while [ $doloop = 1 ]; do
			rm -rf /var/lib/pacman/db.lck > /dev/null 2>&1
			echo y | pacman -Sy
			if [ $? = 0 ]; then
				break;
			fi
			log_warning "Updating local pkgs - failed - auto try again."
			sleep 3
		done
		touch $QDK_STAMP_DIR/$FUNCNAME-stamp
	fi
}

_ready_msys2_updating_corekgs() {
	log_warning "$(echo $FUNCNAME | cut -f4-5 -d'_' | tr '_' ' ')."
	if [ ! -f $QDK_STAMP_DIR/$FUNCNAME-stamp ]; then
		doloop=1
		while [ $doloop = 1 ]; do
			rm -rf /var/lib/pacman/db.lck > /dev/null 2>&1
			echo y | pacman -S --needed filesystem msys2-runtime bash libreadline libiconv libarchive libgpgme libcurl pacman ncurses libintl
			if [ $? = 0 ]; then
				break;
			fi
			log_warning "Updating core pkgs - failed - auto try again."
			sleep 3
		done
		touch $QDK_STAMP_DIR/$FUNCNAME-stamp
	fi
}

_ready_msys2_autorebase() {
	:
}

_ready_msys2_updating_otherpkgs() {
	log_warning "$(echo $FUNCNAME | cut -f4-5 -d'_' | tr '_' ' ')."
	if [ ! -f $QDK_STAMP_DIR/$FUNCNAME-stamp ]; then
		doloop=1
		while [ $doloop = 1 ]; do
			rm -rf /var/lib/pacman/db.lck > /dev/null 2>&1
			echo y | pacman -Su
			if [ $? = 0 ]; then
				break;
			fi
			log_warning "Updating other pkgs - failed - auto try again."
			sleep 3
		done
		touch $QDK_STAMP_DIR/$FUNCNAME-stamp
	fi
}

_ready_msys2_updating_basepkgs() {
	log_warning "$(echo $FUNCNAME | cut -f4-5 -d'_' | tr '_' ' ')."
	if [ ! -f $QDK_STAMP_DIR/$FUNCNAME-stamp ]; then
		doloop=1
		while [ $doloop = 1 ]; do
			rm -rf /var/lib/pacman/db.lck > /dev/null 2>&1
			echo y | pacman -S unzip wget make autoconf automake bison gperf intltool libtool patch nasm yasm mercurial git svn cvs rsync \
				perl python2 ruby scons
			
			if [ $? = 0 ]; then
				break;
			fi
			log_warning "Updating base pkgs - failed - auto try again."
			sleep 3
		done
		touch $QDK_STAMP_DIR/$FUNCNAME-stamp
	fi
}

_ready_msys2_updating_extrakgs() {
	log_warning "$(echo $FUNCNAME | cut -f4-5 -d'_' | tr '_' ' ')."
	if [ ! -f $QDK_STAMP_DIR/$FUNCNAME-stamp ]; then
		doloop=1
		while [ $doloop = 1 ]; do
			rm -rf /var/lib/pacman/db.lck > /dev/null 2>&1
			echo y | pacman -S mingw-w64-$QDKe_VAR_ARCH-cmake
			
			if [ $? = 0 ]; then
				break;
			fi
			log_warning "Updating extra pkgs - failed - auto try again."
			sleep 3
		done
		touch $QDK_STAMP_DIR/$FUNCNAME-stamp
	fi
}

_ready_msys2_init() {
	log_warning "$(echo $FUNCNAME | cut -f4-5 -d'_' | tr '_' ' ')."
	_ready_msys2_updating_init
	_ready_msys2_updating_localpkgs
	_ready_msys2_updating_corekgs
	_ready_msys2_autorebase
#	_ready_msys2_updating_otherpkgs
	_ready_msys2_updating_basepkgs
	_ready_msys2_updating_extrakgs
}

#----------------------------------------
_ready_msys2_init
#----------------------------------------

#----------------RUN-ONCE----------------
export INCLUDE_READY_MSYS2_SCRIPT=true
fi
#----------------RUN-ONCE----------------