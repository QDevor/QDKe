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
if [[ x$INCLUDE_WORKBENCH_HW_COMMON_SCRIPT == "xtrue" ]]; then
	echo [QDKe] - We Are Checking Included More Than Once - workbench-hw-common.sh.
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

workbench_hw_organ_init() {
  QDKE_HW_ORGAN_MAJOR=
  QDKE_HW_ORGAN_MINOR=
  QDKE_HW_ORGAN_HONOR=
}
workbench_hw_organ_set() {
  QDKE_HW_ORGAN_MAJOR=$1
  QDKE_HW_ORGAN_MINOR=$2
  QDKE_HW_ORGAN_HONOR=$3
  
  # awk '{for (i=1;i<=NF;i++)printf toupper(substr($i,0,1))substr($i,2,length($i))" ";printf "\n"}' test 
  QDKE_HW_ORGAN_MAJOR=$(echo $QDKE_HW_ORGAN_MAJOR | tr '[a-z]' '[A-Z]')
  QDKE_HW_ORGAN_MINOR=$(echo $QDKE_HW_ORGAN_MINOR | sed 's/\b[a-z]/\U&/g')
  QDKE_HW_ORGAN_HONOR=$(echo $QDKE_HW_ORGAN_HONOR | sed 's/\b[a-z]/\U&/g')
}

workbench_hw_despc_init() {
  QDKE_HW_DESPC_MAJOR=
  QDKE_HW_DESPC_MINOR=
  QDKE_HW_DESPC_HONOR=
}
workbench_hw_despc_set() {
  QDKE_HW_DESPC_MAJOR=$1
  QDKE_HW_DESPC_MINOR=$2
  QDKE_HW_DESPC_HONOR=$3
  
  QDKE_HW_DESPC_MAJOR=$(echo $QDKE_HW_DESPC_MAJOR | tr '[a-z]' '[A-Z]')
  QDKE_HW_DESPC_MINOR=$(echo $QDKE_HW_DESPC_MINOR | sed 's/\b[a-z]/\U&/g')
  QDKE_HW_DESPC_HONOR=$(echo $QDKE_HW_DESPC_HONOR | sed 's/\b[a-z]/\U&/g')
}

workbench_hw_brand_init() {
  QDKE_HW_BRAND_MAJOR=
  QDKE_HW_BRAND_MINOR=
  QDKE_HW_BRAND_HONOR=
}
workbench_hw_brand_set() {
  QDKE_HW_BRAND_MAJOR=$1
  QDKE_HW_BRAND_MINOR=$2
  QDKE_HW_BRAND_HONOR=$3
  
  QDKE_HW_BRAND_MAJOR=$(echo $QDKE_HW_BRAND_MAJOR | tr '[a-z]' '[A-Z]')
  QDKE_HW_BRAND_MINOR=$(echo $QDKE_HW_BRAND_MINOR | sed 's/\b[a-z]/\U&/g')
  QDKE_HW_BRAND_HONOR=$(echo $QDKE_HW_BRAND_HONOR | sed 's/\b[a-z]/\U&/g')
}
#----------------------------------------
workbench_hw_common_init() {
  workbench_hw_organ_init
  workbench_hw_despc_init
  workbench_hw_brand_init
}

#----------------RUN-ONCE----------------
export INCLUDE_WORKBENCH_HW_COMMON_SCRIPT=true
fi
#----------------RUN-ONCE----------------
