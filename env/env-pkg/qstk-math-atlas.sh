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
. $PROGDIR/../env-msys2/utils-python-qstk.sh
#----------------------------------------

qstk_mathatlas_init() {

}

qstk_mathatlas_checkArgsNum() {
	if [[ $# -lt 3 ]]; then
		log_error "We Are Checking arguments mismatch."
		# return 1
	fi
	return 0
}

qstk_mathatlas_set() {
	qstk_mathatlas_checkArgsNum $@
	work_home=$1
	user_name=$2
	apps_name=$3
}

qstk_mathatlas_getFromSourceforge() {
	SOURCEFORGE_MIRROR=downloads.sourceforge.net
	pkg=math-atlas
	pkg_ver=3.10.2
	pkg_file=$pkg-$pkg_ver.tar.bz2
	pkg_dir=$pkg-$pkg_ver
	# http://downloads.sourceforge.net/project/math-atlas/Stable/3.10.2/atlas3.10.2.tar.bz2
	pkg_url=http://$SOURCEFORGE_MIRROR/project/math-atlas/Stable/$pkg_ver/atlas$pkg_ver.tar.bz2
	work_home=$QSTK_WORK_HOME
	user_name=math-atlas
	apps_name=sourceforge
	
}

qstk_mathatlas_getFromGithub() {
	
	work_home=$QSTK_WORK_HOME
	user_name=$2
	apps_name=$3
}



#----------------------------------------
