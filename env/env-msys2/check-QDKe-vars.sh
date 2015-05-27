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
if [[ x$INCLUDE_CHECK_QDKe_VARS_SCRIPT == "xtrue" ]]; then
	:
else
#----------------RUN-ONCE----------------

# Normally runme by source or '.',
# So '$0' will not mean the real script but mean father script.
# We will only check '$0' at here "entry-common.sh".
# Validity from env/../x.sh included this script
# echo [Debug] - '$0'=$0
_PGMDIR_CHECK_QDKe_VARS=`dirname $0`
_PGMDIR_CHECK_QDKe_VARS=`cd $_PGMDIR_CHECK_QDKe_VARS && pwd -P`
_FN_CHECK_QDKe_VARS=`basename $0`
_FNTYPE_CHECK_QDKe_VARS=${_FN_CHECK_QDKe_VARS#*.}
_FNNAME_CHECK_QDKe_VARS=${_FN_CHECK_QDKe_VARS%.*}
# echo [Debug] - The script is: $_PGMDIR_CHECK_QDKe_DIRS/$_FNNAME_CHECK_QDKe_VARS.$_FNTYPE_CHECK_QDKe_VARS
_PGMDIR_CHECK_QDKe_VARS=`dirname $_PGMDIR_CHECK_QDKe_VARS`
if [ ! -d $_PGMDIR_CHECK_QDKe_VARS/env-msys2 ]; then
	echo [QDKe] - We Are Running Error, Please Check Reference Path.
	exit 1
	return 0
fi

#----------------------------------------

[[ -z $(echo $QDKe_HOST_OS | grep -i "Linux") ]] || unset QDKe_VAR_IS_XP

echo "[Debug] - QDKe_HOST_OS    = $QDKe_HOST_OS"
echo "[Debug] - QDKe_VAR_NPROCS = $QDKe_VAR_NPROCS"
echo "[Debug] - QDKe_VAR_ARCH   = $QDKe_VAR_ARCH"


#----------------RUN-ONCE----------------
export INCLUDE_CHECK_QDKe_VARS_SCRIPT=true
fi
#----------------RUN-ONCE----------------
