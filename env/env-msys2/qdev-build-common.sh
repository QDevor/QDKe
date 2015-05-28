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
if [[ x$INCLUDE_QDEV_BUILD_COMMON_SCRIPT == "xtrue" ]]; then
	:
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
#----------------------------------------

_qdev_build_lookup_gcc_predefined_macro() {
	if [ ! -f $QDKE_STAMP_DIR/${FUNCNAME}-stamp ]; then
		local src_file=lookup_gcc_predefined_macro.c
		echo "int main(void) {}" >$QDKE_TMP/$src_file
		$1gcc -dM -E $QDKE_TMP/$src_file \
			>$QDKE_ETC/current_gcc_predefined_macro || die
		touch $QDK_STAMP_DIR/$FUNCNAME-stamp
	fi
}

_qdev_build_common_init() {
	export QDEV_WORK_HOME=$WORK_HOME/qdev_home
	
	_qdev_build_lookup_gcc_predefined_macro
}

qdev_init() {
	:
}

qdev_set() {
	log_info "$FUNCNAME"
	
	work_home=$1
	user_name=$2
	apps_name=$3
	apps_more=$4
	# echo work_home=$work_home,user_name=$user_name,apps_name=$apps_name,apps_more=$apps_more
	
	if [[ -n $apps_more ]]; then
		qdev_build_top=$work_home/$user_name/$apps_name
		qdev_build_src=$qdev_build_top/$apps_more
		qdev_build_dir=$qdev_build_top/$apps_more.build
	else
		qdev_build_top=$work_home/$user_name
		qdev_build_src=$qdev_build_top/$apps_name
		qdev_build_dir=$qdev_build_top/$apps_name.build
	fi
	
	[ -d $qdev_build_dir ] || mkdir -p $qdev_build_dir >/dev/null 2>&1
	
	# echo $qdev_build_dir
}

qdev_get() {
	utils_github_cloneWithResume   $work_home $user_name $apps_name
	utils_github_updateWithResume  $work_home $user_name $apps_name
}

qdev_check() {
	:
}

qdev_build_config() {
	if [ ! -f $qdev_build_dir/${FUNCNAME}-stamp-config ]; then
		cd $qdev_build_dir
		$qdev_build_src/configure \
			--prefix=''$QDKe_BUILD_PREFIX'' \
			--host=''$QDKe_BUILD_TARGET'' \
			--build=''$QDKe_BUILD_TARGET'' \
			 $@ \
			|| die
		touch $qdev_build_dir/${FUNCNAME}-stamp-config
	fi
}

qdev_build_make() {
	if [ ! -f $qdev_build_dir/${FUNCNAME}-stamp-make$1 ]; then
		cd $qdev_build_dir
		make $@ \
			|| die
		touch $qdev_build_dir/${FUNCNAME}-stamp-make$1
	fi
}

qdev_try() {
	log_info "$FUNCNAME - $PROGNAME"
	
	cd $qdev_build_dir
	
	qdev_build_config
	qdev_build_make
	qdev_build_make install
	
	log_info "$FUNCNAME - $PROGNAME - Done - Sucessfull."
}

#----------------------------------------
# work_home=$QDEV_WORK_HOME
# user_name=?
# apps_name=?
#----------------------------------------
_qdev_build_common_init
# qdev_init
# qdev_set					$work_home $user_name $apps_name $apps_more
# qdev_get
# qdev_check
# qdev_try

#----------------RUN-ONCE----------------
export INCLUDE_QDEV_BUILD_COMMON_SCRIPT=true
fi
#----------------RUN-ONCE----------------