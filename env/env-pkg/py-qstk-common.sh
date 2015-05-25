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

_py_qstk_common_init() {
	export QSTK_WORK_HOME=$WORK_HOME/qstk_home
	
	export QSTK_HOME=$QDKe_PYSP_PATH/QSTK
	export QS=$QSTK_HOME
	#	export QS=$QSTK_WORK_HOME
	
	# Where is your data. To use the default data that comes with the
	# distribution, use the first line (default).  If you are using the 
	# machines at GT use the second line (with hzr71)
	export QSDATA=$QS/QSData
	# export QSDATA=$QSTK_WORK_HOME/QSData
	
	###########
	# You probably should not need to revise any of the lines below.
	# 
	
	# Which machine are we on?
	export HOSTNAME=`hostname`
	
	export QSDATAPROCESSED=$QSDATA/Processed
	export QSDATATMP=$QSDATA/Tmp
#	export QSBIN=$QS/Bin
	
#	export PYTHONPATH=$PYTHONPATH:$QS:$QSBIN
	export PYTHONPATH=$PYTHONPATH:$QS
	
	# expand the PATH
#	export PATH=$PATH:$QSBIN
	
	# location to store scratch files
	export QSSCRATCH=$QSDATA/Scratch
	export CACHESTALLTIME=12
	#Cachestalltime in hours
	
	# Info regarding remote hosting of the system.
	# This is where, for instance we might place a copy of
	# the system for remote execution, or for the website.
	
	export REMOTEUSER=tb34
	export REMOTEHOST=gekko.cc.gatech.edu
	export REMOTEHOME=/nethome/$REMOTEUSER
	
	# NAG Library Specific Defines.  Only needed
	# if you have a NAG library license.
#	export PYTHONPATH=$PYTHONPATH:/usr/local/lib/NAG/
#	export NAG_KUSARI_FILE=/usr/local/lib/NAG/nagkey.txt
}

# qdev_init

# qdev_set

qdev_setmore() {
	:
}

# qdev_get

qdev_check() {
	:
}

# qdev_build_config

# qdev_build_make

qdev_install() {
	exe_cmd "cd $qdev_build_dir" || die
	$PYTHON setup.py install
}

# qdev_try

qdev_tst() {
	cd $qdev_build_dir || die

	$PYTHON test.py
	if [ $? = 0 ]; then
		log_info "$FUNCNAME - $PROGNAME - installation was successful."
		return 0
	fi
	log_info "$FUNCNAME - $PROGNAME - installation was failed."
	return 1
}

#----------------------------------------
# work_home=$QSTK_WORK_HOME
# user_name=?
# apps_name=?
# apps_more=?
#----------------------------------------
_py_qstk_common_init
# qdev_init
# qdev_set					$work_home $user_name $apps_name $apps_more
# qdev_setmore
# qdev_get
# qdev_check
# qdev_install
# qdev_try
# qdev_tst

