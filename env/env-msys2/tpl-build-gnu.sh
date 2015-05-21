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
if [[ x$INCLUDE_TPL_BUILD_GNU_SCRIPT == "xtrue" ]]; then
	echo [QDKe] - We Are Checking Included More Than Once - entry-common.sh.
else
#----------------RUN-ONCE----------------
_PGMDIR_TPL_BUILD_GNU=`dirname $0`
_PGMDIR_TPL_BUILD_GNU=`cd $_PGMDIR_TPL_BUILD_GNU && pwd -P`
_FN_TPL_BUILD_GNU=`basename $0`
_FNTYPE_TPL_BUILD_GNU=${_FN_TPL_BUILD_GNU#*.}
_FNNAME_TPL_BUILD_GNU=${_FN_TPL_BUILD_GNU%.*}
#----------------------------------------
_tpl_buildgnu_init() {
	export QDKe_BUILD_PREFIX=$QDKE_USR
	export QDKe_BUILD_TARGET=$QDKe_VAR_ARCH-w64-mingw32
	
	if [ $QDKe_VAR_IS_XP = "true" ]; then
		export QDKe_JOBS=1
	else
		export QDKe_JOBS=$(printf "$QDKe_VAR_DFLT_MAX_JOBS\n$QDKe_VAR_NPROCS" | \
			sort -n | head -1)
	fi
	export QDKe_CC=$QDKe_BUILD_TARGET-cc
}

_tpl_buildgnu_checkArgsNum() {
	if [[ $# -lt 3 ]]; then
		log_error "We Are Checking arguments mismatch."
		# return 1
	fi
	return 0
}

tpl_buildgnu_set() {
	_tpl_buildgnu_checkArgsNum $@
	work_home=$1
	user_name=$2
	apps_name=$3
	
	BUILD_SRC_DIR=$work_home/$user_name/$apps_name
	BUILD_DST_DIR=$work_home/$user_name/$apps_name.build
}

tpl_buildgnu_setExtra() {
	:
}

tpl_buildgnu_config() {
	if [ ! -f $BUILD_DST_DIR/$FUNCNAME-stamp ]; then	
		cd ''$BUILD_DST_DIR'' &&  \
		''${BUILD_SRC_DIR}'/configure' \
			--prefix=''$QDKe_BUILD_PREFIX'' \
			  --host=''$QDKe_BUILD_TARGET'' \
			 --build=''$QDKe_BUILD_TARGET'' \
			 $@ \
			|| die
		touch $BUILD_DST_DIR/$FUNCNAME-stamp
	fi
}

tpl_buildgnu_make() {
	if [ ! -f $BUILD_DST_DIR/$FUNCNAME-stamp ]; then
		cd ''$BUILD_DST_DIR'' &&  \
		make $@
		touch $BUILD_DST_DIR/$FUNCNAME-stamp
	fi
}

tpl_buildgnu_makeExtra() {
	if [ ! -f $BUILD_DST_DIR/$FUNCNAME-stamp ]; then
		cd ''$BUILD_DST_DIR'' &&  \
		make html $@ && \
		make docs $@ && \
		make pdf $@
		touch $BUILD_DST_DIR/$FUNCNAME-stamp
	fi
}

tpl_buildgnu_makeInstall() {
	if [ ! -f $BUILD_DST_DIR/$FUNCNAME-stamp ]; then
		cd ''$BUILD_DST_DIR'' &&  \
		make install $@
		touch $BUILD_DST_DIR/$FUNCNAME-stamp
	fi
}
#----------------------------------------
_tpl_buildgnu_init
# tpl_buildgnu_set
# tpl_buildgnu_setExtra
# tpl_buildgnu_conf
# tpl_buildgnu_make
# tpl_buildgnu_makeExtra
# tpl_buildgnu_makeInstall
#----------------RUN-ONCE----------------
export INCLUDE_TPL_BUILD_GNU_SCRIPT=true
fi
#----------------RUN-ONCE----------------
