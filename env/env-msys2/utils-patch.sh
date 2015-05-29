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
# 20150529-name-info.patch
_utils_patch_init() {
	:
	export QDKE_PATCHDIR=$QDKE_ETC/patch
	
	[ -d $QDKE_PATCHDIR ] || mkdir -p $QDKE_PATCHDIR >/dev/null 2>&1
}

utils_patch_set() {
	work_home=$1 
	user_name=$2
	apps_name=$3
	apps_more=$4
}

utils_patch() {
	cd $qdev_build_dir || die
	foreach pkg_patch,$(sort $(wildcard $QDKE_PATCHDIR/.*-$user_name-$apps_name-*.patch)),
		(cd '$_utils_patch_work_home' && patch -p1 -u < $pkg_patch)
}

utils_patch() {
	cd $qdev_build_dir || die
	foreach pkg_patch,$(sort $(wildcard $QDKE_PATCHDIR/.*-$_utils_patch_apps_name-*.patch)),
		(cd '$_utils_patch_work_home' && patch -p1 -u < $pkg_patch)
}

utils_diff() {
	cd $qdev_build_top || die
	diff -crN $apps_more $apps_more.orig > $mydate-$user_name-$apps_name-patch.diff
	diff -upr $apps_more $apps_more.orig > $mydate-$user_name-$apps_name-patch.diff
}

utils_diff2() {
	cd $qdev_build_top || die
	diff -crN $apps_more $apps_more.orig > $mydate-$user_name-$apps_name-patch.diff
}

#----------------------------------------
_utils_patch_init
#----------------------------------------

#----------------RUN-ONCE----------------
export INCLUDE_UTILS_PATCH_SCRIPT=true
fi
#----------------RUN-ONCE----------------



