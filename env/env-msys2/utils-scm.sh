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
_PGMDIR_UTILS_GIT=`dirname $0`
_PGMDIR_UTILS_GIT=`cd $_PGMDIR_UTILS_GIT && pwd -P`
_FN_UTILS_GIT=`basename $0`
_FNTYPE_UTILS_GIT=${_FN_UTILS_GIT#*.}
_FNNAME_UTILS_GIT=${_FN_UTILS_GIT%.*}
#----------------------------------------
. $_PGMDIR_ENTRY_COMMON/env-msys2/utils-git.sh
#. $_PGMDIR_ENTRY_COMMON/env-msys2/utils-github.sh
#. $_PGMDIR_ENTRY_COMMON/env-msys2/utils-github.sh
