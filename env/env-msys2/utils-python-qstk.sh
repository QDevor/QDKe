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
_PGMDIR_UTILS_PYTHON_QSTK=`dirname $0`
_PGMDIR_UTILS_PYTHON_QSTK=`cd $_PGMDIR_UTILS_PYTHON_QSTK && pwd -P`
_FN_UTILS_PYTHON_QSTK=`basename $0`
_FNTYPE_UTILS_PYTHON_QSTK=${_FN_UTILS_PYTHON_QSTK#*.}
_FNNAME_UTILS_PYTHON_QSTK=${_FN_UTILS_PYTHON_QSTK%.*}
#----------------------------------------
# . $PROGDIR/../env-msys2/entry-common.sh
#----------------------------------------

_utils_pyqstk_initDeps() {
	# log_info "$FUNCNAME"
	
	utils_msys2_installByPacman $PYTHON-pandas
	utils_python_install qstk
	utils_python_install tushare
}

_utils_pyqstk_initDfltEnv() {
	:
}

_utils_pyqstk_init() {
	export QSTK_WORK_HOME=$WORK_HOME/qstk_home
	_utils_pyqstk_initDeps
#	work_home=$QDKE_HOME && _utils_pyqstk_initDfltEnv
}

_utils_pyqstk_checkArgsNum() {
	if [[ $# -lt 3 ]]; then
		log_error "We Are Checking arguments mismatch."
		# return 1
	fi
	return 0
}

utils_pyqstk_set() {
	_msys2_getpkg_checkArgsNum $@
	work_home=$1
	user_name=$2
	apps_name=$3
	
	tmpdir=$work_home/$user_name/$apps_name
	[ -d $tmpdir ] || mkdir -p $tmpdir >/dev/null 2>&1
	
	work_home=$QDKE_HOME && _utils_pyqstk_initDfltEnv
}

_utils_pyqstk_setExtra() {
	:
}
#----------------------------------------
_utils_pyqstk_init
# utils_pyqstk_set
# utils_pyqstk_setExtra