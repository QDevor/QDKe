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
_PGMDIR_UTILS_GIT=`dirname $0`
_PGMDIR_UTILS_GIT=`cd $_PGMDIR_UTILS_GIT && pwd -P`
_FN_UTILS_GIT=`basename $0`
_FNTYPE_UTILS_GIT=${_FN_UTILS_GIT#*.}
_FNNAME_UTILS_GIT=${_FN_UTILS_GIT%.*}
#----------------------------------------

_utils_mysql_init_config() {
	:
	cd $MYSQL_ROOT || die
	if [ ! -f $MYSQL_ROOT/$FUNCNAME-stamp ]; then
		needed_patch_file=my-default.ini
		sed -i -e 's/# \(basedir = \)/basedir = $MYSQL_ROOT/g' \
			$needed_patch_file
		needed_patch_file=my-default.ini
		sed -i -e 's/# \(datadir = \)/datadir = $MYSQL_ROOT\/data/g' \
			$needed_patch_file
		touch $MYSQL_ROOT/$FUNCNAME-stamp
	fi
}

_utils_mysql_init_install() {
	:
	cd $MYSQL_ROOT || die
	if [ ! -f $MYSQL_ROOT/$FUNCNAME-stamp ]; then
		cd $MYSQL_ROOT/bin || die
		if [ x$QDKe_VAR_IS_XP = "xtrue" ]; then
			mysqld -install
		else
			log_warning "Please Run As Administrator: mysqld -install."
			pause && pause && pause
		fi
		
		net start mysql
		touch $MYSQL_ROOT/$FUNCNAME-stamp
	fi
}

_utils_mysql_init() {
	_old_pwd=$(pwd)
	_utils_mysql_init_config
	_utils_mysql_init_install
	cd $_old_pwd || die
}

#----------------------------------------
_utils_mysql_init

