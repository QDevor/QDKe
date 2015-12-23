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
. $PROGDIR/../env-workbench/workbench-common.sh
#----------------------------------------
. $PROGDIR/../env-workbench/workbench-hw-common.sh
#----------------------------------------
workbench_hw_any_init() {
  workbench_hw_common_init
  return 0
}

workbench_hw_any_conf() {
  #workbench_hw_common_conf
  return 0
}

workbench_hw_any_make() {
  #workbench_hw_common_make
  return 0
}

workbench_hw_any_main() {
  workbench_hw_any_init
  workbench_hw_any_conf
  workbench_hw_any_make
  return 0
}

#----------------------------------------
workbench_hw_any_main
