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
. $PROGDIR/../env-pkg/py-qstk-common.sh
#----------------------------------------

_py_qstk_3rd_init_getsrc() {
	pkgurl=$1
	user_name=$(echo $pkgurl | cut -f2 -d'/')
	apps_name=$(echo $pkgurl | cut -f3 -d'/')
	[ -d $work_home/$user_name/$apps_name ] || mkdir -p $work_home/$user_name/$apps_name >/dev/null 2>&1
	cd $work_home/$user_name/$apps_name
	if [ ! -d github ]; then
		git clone https://$pkgurl github
	fi
}

_py_qstk_3rd_init() {
	log_info "$FUNCNAME"
	cd $work_home
	
	_py_qstk_3rd_init_getsrc github.com/DengZuoheng/bull
	_py_qstk_3rd_init_getsrc github.com/jasti/Stock-Predictor
	_py_qstk_3rd_init_getsrc github.com/yjclegend/stockAnalyze
	_py_qstk_3rd_init_getsrc github.com/tangguangyao/stock
	_py_qstk_3rd_init_getsrc github.com/cforth/stock
	_py_qstk_3rd_init_getsrc github.com/blactangeri/stocks
	_py_qstk_3rd_init_getsrc github.com/narasimhaprasad/StockPy
	_py_qstk_3rd_init_getsrc github.com/maihde/quant
#	_py_qstk_3rd_init_getsrc github.com/jesseh/django-stockandflow
#	_py_qstk_3rd_init_getsrc github.com/StockSharp/StockSharp
}

qdev_init() {
	if [ ! -f $TMP/${PROGNAME}-stamp ]; then
		utils_msys2_installByPacman $PYTHON-pandas
		utils_msys2_installByPacman $PYTHON-lxml
		# utils_msys2_installByPacman $PYTHON-scipy
		# utils_msys2_installByPacman $PYTHON-matplotlib
		touch $TMP/${PROGNAME}-stamp
	fi
}

# qdev_set

qdev_setmore() {
	qdev_build_dir=$qdev_build_src
	
	export CVXOPT_BLAS_LIB='blas','gfortran','quadmath'
	export CVXOPT_LAPACK_LIB='lapack'
}

# qdev_get

# qdev_check

# qdev_build_config

# qdev_build_make

qdev_try() {
	log_info "$FUNCNAME - $PROGNAME"
	
	exe_cmd "cd $qdev_build_dir" || die
	$PYTHON setup.py install
	# $PIP install cvxopt
}

qdev_tst() {
	cd $qdev_build_dir || die
	
#	cd 'Examples/Event Analysis/Stock Details'
#	$PYTHON NSE_India.py
#	cd 'Examples/Event Analysis/Event Analysis Generalised Code'
#	$PYTHON Event_Analysis_Generalized_Code.py
	cd 'Examples/EventProfiler'
	$PYTHON tutorial.py
	
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
user_name=
apps_name=
apps_more=
#----------------------------------------
_py_qstk_3rd_init
# qdev_init
# qdev_set					$work_home $user_name $apps_name $apps_more
# qdev_setmore
# qdev_get
# qdev_check
# qdev_try
# qdev_tst
