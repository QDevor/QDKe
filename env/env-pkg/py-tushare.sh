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
. $PROGDIR/../env-pkg/cc-mathatlas-common.sh
#----------------------------------------

qdev_init() {
	if [ ! -f $TMP/${PROGNAME}-stamp ]; then
		utils_msys2_installByPacman $PYTHON-pandas
		utils_msys2_installByPacman $PYTHON-lxml
		# utils_msys2_installByPacman $PYTHON-scipy
		# utils_msys2_installByPacman $PYTHON-matplotlib
		touch $TMP/${PROGNAME}-stamp
	fi
}

qdev_get() {
	utils_github_cloneWithResume   $work_home $user_name $apps_name
	utils_github_updateWithResume  $work_home $user_name $apps_name
}

qdev_setmore() {
	qdev_build_dir=$qdev_build_src
	
	export CVXOPT_BLAS_LIB='blas','gfortran','quadmath'
	export CVXOPT_LAPACK_LIB='lapack'
}

qdev_try() {
	log_info "$FUNCNAME - $PROGNAME"
	
	exe_cmd "cd $qdev_build_dir" || die
	$PYTHON setup.py install
	# $PIP install cvxopt
}

qdev_tst() {
	cd $qdev_build_dir || die
	cd test || die
	$PYTHON trading_test.py
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
pkg_deps_gcc=''
# pkg_deps_py='scipy matplotlib cvxopt'
pkg_deps_py='python2 python3 pandas lxml'
#----------------------------------------
work_home=$QSTK_WORK_HOME
user_name=waditu
apps_name=tushare
apps_more=github
#----------------------------------------
qdev_init
qdev_set					$work_home $user_name $apps_name $apps_more
qdev_setmore
qdev_get
qdev_check
qdev_try
qdev_tst
