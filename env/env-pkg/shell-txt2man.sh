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
test_init() {
	log_info "$FUNCNAME"
	
	tmpdir=$work_home/$user_name/$apps_name
	# [ -d $tmpdir ] || mkdir -p $tmpdir >/dev/null 2>&1
	# [ -d $tmpdir ] && rm -rf $tmpdir >/dev/null 2>&1
}

test_main() {
	utils_github_cloneWithResume   $work_home $user_name $apps_name
	utils_github_updateWithResume  $work_home $user_name $apps_name
}

test_mainExtra() {
	log_info "$FUNCNAME"
	
	tmpdir=$work_home/$user_name/$apps_name/github
	cd $tmpdir || die
	# to install under /usr/local
	make install || die
	#make install prefix=path
}

test_example() {
	work_home=$WORK_HOME/tools
	user_name=$1
	apps_name=$2
	
	test_init
	test_main
	test_mainExtra
}
#----------------------------------------
txt2man -h >/dev/null 2>&1
[[ $? == "0" ]] || test_example mvertes txt2man
#----------------------------------------
