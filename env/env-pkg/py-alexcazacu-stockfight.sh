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
. $PROGDIR/../env-pkg/py-django-common.sh
. $PROGDIR/../env-pkg/py-qstk-common.sh
#----------------------------------------
[ x$QDKe_VAR_PYTHON_TYPE = "xMiniconda" ] && export PYTHON=python

qdev_init() {
	if [ ! -f $qdev_build_dir/$FUNCNAME-stamp ]; then
		:
		#utils_python_install pymongo
		touch $qdev_build_dir/$FUNCNAME-stamp
	fi
}

qdev_initmore() {
	:
	#_py_install_requirements
}

# qdev_set

qdev_setmore() {
	qdev_build_dir=$qdev_build_src
	
	#qdev_django_setmore mysite myapp
}

# qdev_get

_py_install_requirements() {
  if [ ! -f $qdev_build_dir/$FUNCNAME-stamp ]; then
		:
		#utils_python_install pymongo
		touch $qdev_build_dir/$FUNCNAME-stamp
	fi
}

qdev_check() {
  :
  _py_install_requirements
}

# qdev_build_config

# qdev_build_make

qdev_try() {
	log_info "$FUNCNAME - $PROGNAME"
	return 0
	
	_django_work_home=$qdev_build_src/src
	_django_projectname=mysite
	_django_appname=myapp
	
	# qdev_install
	qdev_django_newproject \
		$_django_work_home \
		$_django_projectname \
		$_django_appname
	
}

qdev_tst() {
	cd $qdev_build_dir || die
	
	$PYTHON manage.py runquotes & $PYTHON manage.py checkbets & $PYTHON manage.py check_fight & $PYTHON manage.py runserver
	
	# qdev_django_runserver
	
	if [ $? = 0 ]; then
		log_info "$FUNCNAME - $PROGNAME - installation was successful."
		return 0
	fi
	log_info "$FUNCNAME - $PROGNAME - installation was failed."
	return 1
}

#
# Required and optional software
#
pkg_deps_gcc=
pkg_deps_py=
#----------------------------------------
work_home=$QSTK_WORK_HOME
user_name=$(echo $PROGNAME | cut -f2 -d'-')
apps_name=$(echo $PROGNAME | cut -f3 -d'-')
apps_more=github
#----------------------------------------
qdev_init
qdev_initmore
qdev_set					$work_home $user_name $apps_name $apps_more
qdev_setmore
qdev_get
qdev_check
qdev_try
qdev_tst
