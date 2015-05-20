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

#----------------------------------------
if [[ x$INCLUDE_CHECK_DEPS_MSYS2_SCRIPT == "xtrue" ]]; then
	return 0
fi
#----------------------------------------
_PGMDIR_CHECK_DEPS_MSYS2=`dirname $0`
_PGMDIR_CHECK_DEPS_MSYS2=`cd $_PGMDIR_CHECK_DEPS_MSYS2 && pwd -P`
_FN_CHECK_DEPS_MSYS2=`basename $0`
_FNTYPE_CHECK_DEPS_MSYS2=${_FN_CHECK_DEPS_MSYS2#*.}
_FNNAME_CHECK_DEPS_MSYS2=${_FN_CHECK_DEPS_MSYS2%.*}
#----------------------------------------

#----------------------------------------
export INCLUDE_CHECK_DEPS_MSYS2_SCRIPT=true