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

_py_django_common_init() {
	utils_msys2_installByPacman sqlite3
	utils_msys2_installByPacman $PYTHON-pandas
	
	# utils_python_install django==1.8.1
	# utils_python_install django_crontab
	_utils_python_installByPip django==1.8.1
	_utils_python_installByPip django_crontab
}

# qdev_django_init

# qdev_set

qdev_django_setmore() {
	:
}

# qdev_django_get

qdev_django_check() {
	:
}

# qdev_build_config

# qdev_build_make

# qdev_install

# qdev_try

# qdev_tst

#----------------------------------------
# work_home=$QSTK_WORK_HOME
# user_name=?
# apps_name=?
# apps_more=?
#----------------------------------------
_py_django_common_init
# qdev_init
# qdev_set					$work_home $user_name $apps_name $apps_more
# qdev_setmore
# qdev_get
# qdev_check
# qdev_install
# qdev_try
# qdev_tst

