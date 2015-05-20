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
. $PROGDIR/../env-msys2/msys2-get-pkg.sh
#----------------------------------------
test_init() {
	cd $work_home || die
	rm -rf $work_home/$user_name/$apps_name
}

test_main() {
	msys2_getpkg_setWork           $work_home $user_name $apps_name
	msys2_getpkg_setType           $apps_type
	
	# msys2_getpkg_getVer
	msys2_getpkg_getPkg
}

test_example() {
	work_home=$WORK_HOME/test
	user_name=msys2
	apps_name=$1
	apps_type=$2
	
	test_init
	test_main
}
#----------------------------------------
test_example flex src
pause
test_example grep bin
#----------------------------------------
