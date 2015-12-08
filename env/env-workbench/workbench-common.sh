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

#----------------RUN-ONCE----------------
if [[ x$INCLUDE_WORKBENCH_COMMON_SCRIPT == "xtrue" ]]; then
	echo [QDKe] - We Are Checking Included More Than Once - workbench-common.sh.
else
#----------------RUN-ONCE----------------

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

#----------------------------------------
workbench_common_init() {
  if [ -z $WORKBENCH_COMMON_COMP_NAME ]; then
    local_suffix=$(date +%Y-%m-%d)
    WORKBENCH_COMMON_COMP_NAME="nullcomp-$local_suffix"
  fi
	
	if [ -z $WORKBENCH_COMMON_PROJ_NAME ]; then
    local_suffix=$(date +%m-%d)
    WORKBENCH_COMMON_PROJ_NAME="nullproj-$local_suffix"
  fi
  
  WORKBENCH_COMMON_HW_VER_NAME="beta production"
	WORKBENCH_COMMON_HW_BRD_NAME="test"
	
	return 0
}

workbench_common_conf_dirs() {
	export WORKBENCH_COMMON_ROOT_DIR=$WORK_HOME/workbench	
	export WORKBENCH_COMMON_COMP_DIR=$WORKBENCH_COMMON_ROOT_DIR/$WORKBENCH_COMMON_COMP_NAME
	export WORKBENCH_COMMON_PROJ_DIR=$WORKBENCH_COMMON_COMP_DIR/$WORKBENCH_COMMON_PROJ_NAME
	
	export WORKBENCH_COMMON_HARDWARE_DIR=$WORKBENCH_COMMON_PROJ_DIR/hardware
	export WORKBENCH_COMMON_SOFTWARE_DIR=$WORKBENCH_COMMON_PROJ_DIR/software
	
	return 0
}

workbench_common_conf_contents() {
	WORKBENCH_COMMON_SW_CONTENTS="tools third_party src examples tests"
	WORKBENCH_COMMON_HW_CONTENTS="Assembly BOM Gerbers"
	return 0
}

workbench_common_conf() {
	workbench_common_conf_dirs
	workbench_common_conf_contents
	
	return 0
}

workbench_common_check_dirs() {
	[ -d $WORKBENCH_COMMON_ROOT_DIR ]     || mkdir -p $WORKBENCH_COMMON_ROOT_DIR
	[ -d $WORKBENCH_COMMON_COMP_DIR ]     || mkdir -p $WORKBENCH_COMMON_COMP_DIR
	[ -d $WORKBENCH_COMMON_PROJ_DIR ]     || mkdir -p $WORKBENCH_COMMON_PROJ_DIR
	[ -d $WORKBENCH_COMMON_HARDWARE_DIR ] || mkdir -p $WORKBENCH_COMMON_HARDWARE_DIR
	[ -d $WORKBENCH_COMMON_SOFTWARE_DIR ] || mkdir -p $WORKBENCH_COMMON_SOFTWARE_DIR
	
#	[ -d $WORKBENCH_COMMON_HARDWARE_DIR/beta ]       || mkdir -p $WORKBENCH_COMMON_HARDWARE_DIR/beta
#	[ -d $WORKBENCH_COMMON_HARDWARE_DIR/production ] || mkdir -p $WORKBENCH_COMMON_HARDWARE_DIR/production
  
	return 0
}

workbench_common_check_contents() {
	for dirname in $WORKBENCH_COMMON_SW_CONTENTS
	do
	  [ -d $WORKBENCH_COMMON_SOFTWARE_DIR/$dirname ]     || mkdir -p $WORKBENCH_COMMON_SOFTWARE_DIR/$dirname
	done
	
	for vername in $WORKBENCH_COMMON_HW_VER_NAME
  do
  	for brdname in $WORKBENCH_COMMON_HW_BRD_NAME
  	do
    	for dirname in $WORKBENCH_COMMON_HW_CONTENTS
    	do
    	  [ -d $WORKBENCH_COMMON_HARDWARE_DIR/$vername/$brdname/$dirname ]     || mkdir -p $WORKBENCH_COMMON_HARDWARE_DIR/$vername/$brdname/$dirname
    	done
    done
  done
	
	return 0
}

workbench_common_make() {
	workbench_common_check_dirs
	workbench_common_check_contents
	return 0
}
#----------------------------------------
# workbench_common_init
# workbench_common_conf
# workbench_common_make
#----------------RUN-ONCE----------------
export INCLUDE_WORKBENCH_COMMON_SCRIPT=true
fi
#----------------RUN-ONCE----------------
