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

qdev_init() {
	if [ ! -f $TMP/${PROGNAME}-stamp ]; then
		utils_msys2_installByPacman postgresql
		utils_python_install Django
		utils_python_install South
		utils_python_install dj-database-url
		utils_python_install dj-static
		utils_python_install django-extensions
		utils_python_install django-toolbelt
		utils_python_install djangorestframework
		utils_python_install gunicorn
		utils_python_install psycopg2
		utils_python_install six
		utils_python_install static
		utils_python_install wsgiref
		
		needed_patch_file=$QDKe_PYSP_PATH/south/db/postgresql_psycopg2.py
		sed -i -e 's/django.db.backends.util/django.db.backends.utils/g' \
			$needed_patch_file
		needed_patch_file=$QDKe_PYSP_PATH/south/db/generic.py
		sed -i -e 's/django.db.backends.util/django.db.backends.utils/g' \
			$needed_patch_file
		
		touch $TMP/${PROGNAME}-stamp
	fi
}

# qdev_set

qdev_setmore() {
	qdev_build_dir=$qdev_build_src
}

# qdev_get

# qdev_check

# qdev_build_config

# qdev_build_make

qdev_try() {
	log_info "$FUNCNAME - $PROGNAME"
	
	_django_work_home=$qdev_build_src
	#_django_projectname=mysite
	#_django_appname=myapp
	
}

qdev_tst() {
	cd $qdev_build_dir || die
	
	# $PYTHON manage.py makemigrations.
	$PYTHON manage.py migrate --fake-initial
	$PYTHON manage.py migrate --fake backend
	
	#qdev_django_runserver
	$PYTHON manage.py runserver
	
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
pkg_deps_py=''
#----------------------------------------
work_home=$QSTK_WORK_HOME
user_name=king2k23
apps_name=stock-exchange
apps_more=github
#----------------------------------------
qdev_init
qdev_set					$work_home $user_name $apps_name $apps_more
qdev_setmore
qdev_get
qdev_check
qdev_try
qdev_tst
