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
. $PROGDIR/../env-msys2/utils-python-qstk.sh
#----------------------------------------
# . $PROGDIR/../env-pkg/tools-txt2man.sh
#----------------------------------------
QDKeDev_init() {
	:
}

QDKeDev_set() {
	log_info "$FUNCNAME"
	
	work_home=$QSTK_WORK_HOME
	user_name=vtjnash
	apps_name=atlas-3.10.0
}

QDKeDev_get() {
	utils_github_cloneWithResume   $work_home $user_name $apps_name
	utils_github_updateWithResume  $work_home $user_name $apps_name
}

qstk_mathatlas_getFromSourceforge() {
	log_info "$FUNCNAME"
	
	SOURCEFORGE_MIRROR=downloads.sourceforge.net
	pkg=math-atlas
	pkg_ver=3.10.2
	pkg_file=$pkg-$pkg_ver.tar.bz2
	pkg_dir=$pkg-$pkg_ver
	# http://downloads.sourceforge.net/project/math-atlas/Stable/3.10.2/atlas3.10.2.tar.bz2
	pkg_url=http://$SOURCEFORGE_MIRROR/project/math-atlas/Stable/$pkg_ver/atlas$pkg_ver.tar.bz2
	work_home=$QSTK_WORK_HOME
	user_name=math-atlas
	apps_name=math-atlas
}

qstk_mathatlas_getFromGithub() {
	log_info "$FUNCNAME"
	
	work_home=$QSTK_WORK_HOME
	user_name=math-atlas
	apps_name=math-atlas
}

qstk_mathatlas_getFromGithub2() {
	log_info "$FUNCNAME"
	
	work_home=$QSTK_WORK_HOME
	user_name=vtjnash
	apps_name=atlas-3.10.0
}

test_init() {
	log_info "$FUNCNAME"
	
	tmpdir=$work_home/$user_name/$apps_name
	[ -d $tmpdir ] || mkdir -p $tmpdir >/dev/null 2>&1
}

test_main() {
	log_info "$FUNCNAME"
	
	utils_github_cloneWithResume   $work_home $user_name $apps_name
	utils_github_updateWithResume  $work_home $user_name $apps_name
}

test_mainExtra() {
	tmpdir=$work_home/$user_name/$apps_name
	
	BUILD_SRC_DIR=$work_home/$user_name/$apps_name/github
	BUILD_DST_DIR=$work_home/$user_name/$apps_name/github.build
	
	#[ -d $BUILD_DST_DIR ] || mkdir -p $BUILD_DST_DIR >/dev/null 2>&1
	#[ -d $BUILD_DST_DIR ] && rm -rf $BUILD_DST_DIR >/dev/null 2>&1
	cd $BUILD_SRC_DIR || die
	#gitwash || die
	make srcdir=../github.build
	cd $BUILD_DST_DIR || die
	sed -i -e 's/.*ATLAS\/doc.*[^\\]$/#&/g' Makefile | grep "ATLAS\/doc"
	sed -i -e 's/.*mkdir ATLAS\/doc$/#&/g' Makefile | grep "ATLAS\/doc"
	
	doloop_1st=1
	while [ $doloop_1st = 1 ]; do
		cd $BUILD_DST_DIR || die
		log_info "$FUNCNAME - make doing."
		make >$QDKE_LOGDIR/$user_name-$apps_name-$FUNCNAME-1.log 2>&1
		do_ok=$?
		echo "make1 return - $do_ok"
		if [ $do_ok != 0 ]; then
			doloop_2nd=1
			while [ $doloop_2nd = 1 ]; do
				cd $BUILD_DST_DIR/ATLAS || die
				make -f Make.ext >/dev/null 2>&1
				do_ok=$?
				echo "make1-ATLAS return - $do_ok"
				if [ $do_ok = 0 ]; then
					break;
				fi
				log_warning "ATLAS - make failed - auto try again inner."
				sleep 3
			done
			log_warning "ATLAS - make failed - auto try again outer."
		else
			break;
		fi
	done
	
	log_info "$FUNCNAME - make done."
	log_info "$FUNCNAME - shell doing."
	./atltar.sh >$QDKE_LOGDIR/$user_name-$apps_name-$FUNCNAME-atltar.log 2>&1
	log_info "$FUNCNAME - ATLS SOURCE PLACED AT:"
	log_info "$FUNCNAME - $BUILD_DST_DIR/ATLAS."
	#extract || die
}

test_mainExtra2() {
	
}

test_example() {
	log_info "$FUNCNAME"
	
	qstk_mathatlas_getFromGithub
	
	test_init
	test_main
	test_mainExtra
}

test_example2() {
	log_info "$FUNCNAME"
	

	qstk_mathatlas_getFromGithub2
	
	test_init
	test_main
	test_mainExtra2
}

#----------------------------------------
work_home=$QSTK_WORK_HOME
user_name=vtjnash
apps_name=atlas-3.10.0
#----------------------------------------
QDKeDev_init
QDKeDev_set

# math-atlas/math-atlas
# vtjnash/atlas-3.10.0
test_example2
# test_example2

