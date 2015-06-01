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
export PYTHON=python
#----------------------------------------
. $PROGDIR/../env-msys2/entry-common.sh
. $PROGDIR/../env-msys2/qdev-build-common.sh
. $PROGDIR/../env-pkg/py-qstk-common.sh
#----------------------------------------

qdev_init() {
	:
	echo $PATH
}

qdev_get() {
	utils_github_cloneWithResume   $work_home $user_name $apps_name
	utils_github_updateWithResume  $work_home $user_name $apps_name
}

qdev_setmore() {
	qdev_build_dir=$qdev_build_src
	
#	if [ x$QDKe_VAR_IS_XP = "xtrue" ]; then
		needed_patch_file=$qdev_build_src/site.cfg
		tmp_mysql_root=`cygpath -w $QDK_ROOT/mysql-connector-c | sed -e 's#\\\#\\\\\\\#g'`
		sed -i -e "s/\(.*\)MySQL Server .*/\1MySQL Server 5.7/" \
			$needed_patch_file
#	fi
		# [build]
		# compiler = mingw32
		needed_patch_file=$qdev_build_src/setup_windows.py
#		sed -i -e 's/\(extra_compile_args = \)\(\[.*\]\)/\1\[\]/g' \
#			$needed_patch_file
		
		sed -i -e 's/\(.*\)lib\\\opt\(.*\)/\1lib\2/g' \
			$needed_patch_file
		
		needed_patch_file=$qdev_build_src/setup_windows.py
#		sed -i -e "s/\(libraries = \[.*'wsock32'\), client\(.*\]\)/\1, 'mysql', client\2/g" \
#			$needed_patch_file
}

qdev_try() {
	log_info "$FUNCNAME - $PROGNAME"

	exe_cmd "cd $qdev_build_dir" || die
	# $PYTHON setup.py build --compiler="mingw32"  install
	$PYTHON -v setup.py build --compiler="msvc"  install
	# $PYTHON setup.py install > $QDKE_LOGDIR/$PROGNAME-$FUNCNAME.log 2>&1
	# $PIP install cvxopt
}

qdev_tst() {
	cd $qdev_build_dir || die
	cd tests || die
	$PYTHON test_MySQLdb_capabilities.py
	if [ $? = 0 ]; then
		log_info "$FUNCNAME - $PROGNAME - installation was successful."
		return 0
	fi
	log_info "$FUNCNAME - $PROGNAME - installation was failed."
	return 1
}

#
# http://cvxopt.org/install/index.html
#
# Required and optional software
# ATLAS or BLAS + LAPACK
# The GNU Scientific Library GSL.
# FFTW is a C library for discrete Fourier transforms.
# GLPK is a linear programming package.
# MOSEK version 7 is a commercial library of convex optimization solvers.
# DSDP5.8 is a semidefinite programming solver.
pkg_deps_gcc=
pkg_deps_py=
#----------------------------------------
work_home=$QSTK_WORK_HOME
user_name=farcepest
apps_name=moist
apps_more=github
#----------------------------------------
qdev_init
qdev_set					$work_home $user_name $apps_name $apps_more
qdev_setmore
qdev_get
qdev_check
qdev_try
qdev_tst
