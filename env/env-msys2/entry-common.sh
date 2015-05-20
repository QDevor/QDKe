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
if [[ x$INCLUDE_ENTRY_COMMON_SCRIPT == "xtrue" ]]; then
	echo [QDKe] - We Are Checking Included More Than Once - entry-common.sh.
else
#----------------RUN-ONCE----------------

# Normally runme by source or '.',
# So '$0' will not mean the real script but mean father script.
# We will only check '$0' at here "entry-common.sh".
# Validity from env/../x.sh included this script
# echo [Debug] - '$0'=$0
_PGMDIR_ENTRY_COMMON=`dirname $0`
_PGMDIR_ENTRY_COMMON=`cd $_PGMDIR_ENTRY_COMMON && pwd -P`
_FN_ENTRY_COMMON=`basename $0`
_FNTYPE_ENTRY_COMMON=${_FN_ENTRY_COMMON#*.}
_FNNAME_ENTRY_COMMON=${_FN_ENTRY_COMMON%.*}
# echo [Debug] - The script is: $_PGMDIR_ENTRY_COMMON/$_FNNAME_ENTRY_COMMON.$_FNTYPE_ENTRY_COMMON
_PGMDIR_ENTRY_COMMON=`dirname $_PGMDIR_ENTRY_COMMON`
if [ ! -d $_PGMDIR_ENTRY_COMMON/env-msys2 ]; then
	echo [QDKe] - We Are Running Error, Please Check Reference Path.
	exit 1
	return 0
fi

#----------------------------------------

. $_PGMDIR_ENTRY_COMMON/env-msys2/utils-console.sh
. $_PGMDIR_ENTRY_COMMON/env-msys2/utils-base.sh

. $_PGMDIR_ENTRY_COMMON/env-msys2/check-dflt-vars.sh
. $_PGMDIR_ENTRY_COMMON/env-msys2/check-dflt-dirs.sh
. $_PGMDIR_ENTRY_COMMON/env-msys2/check-QDKe-vars.sh
. $_PGMDIR_ENTRY_COMMON/env-msys2/check-QDKe-dirs.sh

. $_PGMDIR_ENTRY_COMMON/env-msys2/check-deps-msys2.sh

. $_PGMDIR_ENTRY_COMMON/env-msys2/utils-extract.sh
. $_PGMDIR_ENTRY_COMMON/env-msys2/utils-git.sh
. $_PGMDIR_ENTRY_COMMON/env-msys2/utils-github.sh

#----------------RUN-ONCE----------------
export INCLUDE_ENTRY_COMMON_SCRIPT=true
fi
#----------------RUN-ONCE----------------
