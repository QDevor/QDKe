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
_PGMDIR_UTILS_MSYS2=`dirname $0`
_PGMDIR_UTILS_MSYS2=`cd $_PGMDIR_UTILS_MSYS2 && pwd -P`
_FN_UTILS_MSYS2=`basename $0`
_FNTYPE_UTILS_MSYS2=${_FN_UTILS_MSYS2#*.}
_FNNAME_UTILS_MSYS2=${_FN_UTILS_MSYS2%.*}
#----------------------------------------

. utils-pacman.sh

utils_msys2_installByPacman() {
	# log_info "$FUNCNAME"
	
	if [[ $# -lt 1 ]]; then
    log_error "Usage: $FUNCNAME deps1,deps2,..."
	fi
	
	is_xp=$QDKe_VAR_IS_XP
	arch=$QDKe_VAR_ARCH
	for dep in $@; do
		pkgname=`echo $dep | tr -s "=" | tr '[A-Z]' '[a-z]' | tr '_' '-' | tr '=' ' ' | cut -d ' ' -f1`
	 	 pkgver=`echo $dep | tr -s "=" | tr '[A-Z]' '[a-z]' | tr '_' '-' | grep "="   | cut -d '=' -f2`
		
		# return 0 - not found
		# return 1 - found any pkg
		_utils_msys2_checkLocal $pkgname
		if [[ $? == "1" ]]; then
			log_warning "$pkgname - Installed - Ignore."
			continue
		fi
		
		# return 0 - not found
		# return 1 - found arch pkg
		# return 2 - found msys2 pkg
		_utils_msys2_checkRemote $pkgname
		if [[ $? == "0" ]]; then
			continue
		fi
		log_warning "$pkgname - Installing."
		if [[ $? == "1" ]]; then
			#log_warning "mingw-w64-$arch-$pkgname - Found."
			pkgname=mingw-w64-$arch-$pkgname
		fi
		
		doloop=1
		while [ $doloop = 1 ]; do
			rm -rf /var/lib/pacman/db.lck > /dev/null 2>&1
			echo y | pacman -S $pkgname
			if [ $? = 0 ]; then
				break;
			fi
			log_warning "$pkgname - Install failed - auto try again."
			sleep 3
		done
		
	done
}

# utils_msys2_installByPacman