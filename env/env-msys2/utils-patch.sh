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
if [[ x$INCLUDE_UTILS_PATCH_SCRIPT == "xtrue" ]]; then
	:
else
#----------------RUN-ONCE----------------

_PGMDIR_UTILS_PATCH=`dirname $0`
_PGMDIR_UTILS_PATCH=`cd $_PGMDIR_UTILS_PATCH && pwd -P`
_FN_UTILS_PATCH=`basename $0`
_FNTYPE_UTILS_PATCH=${_FN_UTILS_PATCH#*.}
_FNNAME_UTILS_PATCH=${_FN_UTILS_PATCH%.*}
#----------------------------------------

# Patch file name rule:
# 0000-name-info.patch
_utils_patch_init() {
	:
	export QDKE_PATCHDIR=$QDKE_ETC/patch
}

utils_patch_set() {
	_utils_patch_work_home=$1
	_utils_patch_apps_name=$2
}

utils_patch() {
	:
	cd $_utils_patch_work_home || die
	foreach pkg_patch,$(sort $(wildcard $QDKE_PATCHDIR/.*-$_utils_patch_apps_name-*.patch)),
		(cd '$_utils_patch_work_home' && patch -p1 -u < $pkg_patch)
}

utils_unpatch() {
	:
}

#----------------------------------------
_utils_patch_init
#----------------------------------------

#----------------RUN-ONCE----------------
export INCLUDE_UTILS_PATCH_SCRIPT=true
fi
#----------------RUN-ONCE----------------



