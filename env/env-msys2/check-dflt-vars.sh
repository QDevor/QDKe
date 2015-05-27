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
if [[ x$INCLUDE_CHECK_DFLT_VARS_SCRIPT == "xtrue" ]]; then
	:
else
#----------------RUN-ONCE----------------

_PGMDIR_CHECK_DFLT_VARS=`dirname $0`
_PGMDIR_CHECK_DFLT_VARS=`cd $_PGMDIR_CHECK_DFLT_VARS && pwd -P`
_FN_CHECK_DFLT_VARS=`basename $0`
_FNTYPE_CHECK_DFLT_VARS=${_FN_CHECK_DFLT_VARS#*.}
_FNNAME_CHECK_DFLT_VARS=${_FN_CHECK_DFLT_VARS%.*}
#----------------------------------------

#----------------RUN-ONCE----------------
export INCLUDE_CHECK_DFLT_VARS_SCRIPT=true
fi
#----------------RUN-ONCE----------------