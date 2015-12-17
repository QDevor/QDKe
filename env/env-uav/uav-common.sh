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
if [[ x$INCLUDE_UAV_COMMON_SCRIPT == "xtrue" ]]; then
	echo [QDKe] - We Are Checking Included More Than Once - uav-common.sh.
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
for filename in `ls $QDKE_ROOT/env/env-uav/`
do
    if [ -f $PROGDIR/../env-uav/$filename ]; then
      case $filename in
        uav-fn-*.sh)
          echo [debug] Will included $PROGDIR/../env-uav/$filename
          . $PROGDIR/../env-uav/$filename
          ;;
        *) 
          continue;;
      esac
    fi
done
#----------------------------------------


uav_common_init() {
  
	return 0
}

uav_common_conf() {
	qdev_build_config $@
	return 0
}

uav_common_make() {
	qdev_build_make $@
	return 0
}
#----------------------------------------
# uav_common_init
# uav_common_conf
# uav_common_make
export QUAV_WORK_HOME=$WORK_HOME/uav_home
#----------------RUN-ONCE----------------
export INCLUDE_UAV_COMMON_SCRIPT=true
fi
#----------------RUN-ONCE----------------
