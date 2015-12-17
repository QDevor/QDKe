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
. $PROGDIR/../env-uav/uav-common.sh
#----------------------------------------
# qdev_init
qdev_setmore() {
  
	return 0
}
# qdev_get
#----------------------------------------
uav_any_init() {
  uav_common_init
  return 0
}

uav_any_conf() {
  uav_common_conf
  return 0
}

uav_any_make() {
  uav_common_make
  return 0
}

uav_any_main() {
  uav_any_init
  uav_any_conf
  uav_any_make
  return 0
}

#----------------------------------------
work_home=$QUAV_WORK_HOME
user_name=paparazzi
apps_name=paparazzi
apps_more=github
#----------------------------------------
qdev_init
qdev_set					$work_home $user_name $apps_name $apps_more
qdev_setmore
qdev_get					$work_home $user_name $apps_name $apps_more

uav_any_main
