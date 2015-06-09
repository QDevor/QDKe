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

_andr_common_init() {
	:
	export QDEV_ANDR_WORK_HOME=$WORK_HOME/andr_home
}

andr_common_patch_local_properties() {
	:
	if [ -f $qdev_build_src/${FUNCNAME}-stamp ]; then
		return 0
	fi
	
	cd $qdev_build_src ||die
	
	# sdk.dir=?
	needed_patch_file=$qdev_build_src/local.properties
	if [ ! -f $needed_patch_file ]; then
		return 0
	fi
	
	_andr_sdk_root=$( \
		cygpath -w $ANDROID_SDK_ROOT | \
		sed -e "s,\\\,\\\\\\\,g" | \
		sed -e "s,\\\,\\\\\\\,g" \
	)
	#echo $_andr_sdk_root
	sed -i -e 's,\(sdk.dir=\).*,\1'$_andr_sdk_root',' \
		$needed_patch_file
	
	touch $qdev_build_src/${FUNCNAME}-stamp
}

andr_gradle_buildDbg() {
	:
	andr_common_patch_local_properties ||die
	
	doloop=1
	while [ $doloop = 1 ]; do
		./gradlew assembleDebug 2>&1 | \
			tee $QDKE_LOGDIR/${PROGNAME}_${FUNCNAME}.log
		if [ $? = 0 ]; then
			break;
		fi
		log_warning "${PROGNAME}_${FUNCNAME} - Build failed - auto try again."
		sleep 3	
	done
}

#----------------------------------------
_andr_common_init
# andr_common_patch_local_properties
#----------------------------------------