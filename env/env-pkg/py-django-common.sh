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
	:
	# utils_msys2_installByPacman sqlite3
	# utils_msys2_installByPacman $PYTHON-pandas
	
	# utils_python_install django==1.8.1
	# utils_python_install django_crontab
	# _utils_python_installByPip django==1.8.1
	# _utils_python_installByPip django_crontab
}

# qdev_django_init

# qdev_set

qdev_django_setmore() {
	log_info "$FUNCNAME"
	
	django_work_home=$1
	django_projectname=$2
	django_appname=$3
	
	django_work_dir=$django_work_home
}

# qdev_django_get


qdev_django_check() {
	:
}

qdev_django_startproject() {
	log_info "$FUNCNAME"
	
	#django_projectname=$1
	#django_appname=$2
	
	cd $django_work_dir || die
	
	if [ ! -d $django_projectname ]; then
		log_warning "[Django] - Creating Project - $django_projectname."
		django-admin startproject $django_projectname
		return $?
	fi
	return 0
}

qdev_django_startapp() {
	log_info "$FUNCNAME"
	
	#django_projectname=$1
	#django_appname=$2
	
	cd $django_work_dir/$django_projectname || die
	
	if [ ! -d $django_appname ]; then
		log_warning "[Django] - Creating Application - $django_appname."
		$PYTHON manage.py startapp $django_appname
		$PYTHON manage.py migrate
		return $?
	fi
	return 0
}

qdev_django_validatemodel() {
	log_info "$FUNCNAME"
	
	#django_projectname=$1
	#django_appname=$2
	
	log_warning "[Django] - Validating Model - $django_projectname."
	
	cd $django_work_dir/$django_projectname || die
	
	$PYTHON manage.py validate
	
	$PYTHON manage.py sqlall $django_appname
	
	return $?
}

qdev_django_createmodeldb() {
	log_info "$FUNCNAME"
	
	#django_projectname=$1
	#django_appname=$2
	
	log_warning "[Django] - Creating ModelDB - $django_projectname."
	
	cd $django_work_dir/$django_projectname || die
	
	if [ ! -f db.sqlite3 ]; then
		# 建立Model数据库表
		$PYTHON manage.py syncdb
	fi
	
	return $?
}

qdev_django_modeldbutils() {
	log_info "$FUNCNAME"
	
	#django_projectname=$1
	#django_appname=$2

	cd $django_work_dir/$django_projectname || die
	
	# 创建站点管理员用户
	# 如果 settings.py 的 INSTALLED_APPS 中有 django.contrib.auth，当第一次运行 syncdb 时会询问是否创建站点管理员用户
	# 如果当时不创建管理员的话，后来可以运行 createsuperuser 来创建
	# 使用 django-admin.py 管理站点时，需要 django.contrib.auth
	$PYTHON manage.py createsuperuser
	
	# 启动 DBMS 客户端管理程序，如 MySQL 的 mysql.exe
	$PYTHON manage.py dbshell
	
	return $?
}

qdev_django_startshell() {
	log_info "$FUNCNAME"
	
	#django_projectname=$1
	#django_appname=$2

	cd $django_work_dir/$django_projectname || die
	
	# 启动 DBMS 客户端管理程序，如 MySQL 的 mysql.exe
	$PYTHON manage.py dbshell
	
	# 启动 Django 站点的 Python 交互解释器
	$PYTHON manage.py shell
	
	return $?
}

qdev_django_runserver() {
	log_info "$FUNCNAME"
	
	#django_projectname=$1
	#django_appname=$2

	cd $django_work_dir/$django_projectname || die
	
	$PYTHON manage.py runserver
}

qdev_django_newproject() {
	log_info "$FUNCNAME"
	
	django_work_home=$1
	django_projectname=$2
	django_appname=$3

	cd $django_work_dir || die
	qdev_django_setmore       $django_work_home $django_projectname $django_appname || die
	
	qdev_django_startproject      || die
	qdev_django_startapp          || die
	
#	qdev_django_validatemodel     || die
#	qdev_django_createmodeldb     || die
#	qdev_django_modeldbutils      || die
#	qdev_django_startshell        || die
	
#	qdev_django_runserver         || die
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
# qdev_django_setmore
# qdev_get
# qdev_check
# qdev_django_startproject
# qdev_django_startapp
# qdev_django_validatemodel
#	qdev_django_createmodeldb
#	qdev_django_modeldbutils
#	qdev_django_startshell
# qdev_django_newproject
# qdev_install
# qdev_try
# qdev_tst

