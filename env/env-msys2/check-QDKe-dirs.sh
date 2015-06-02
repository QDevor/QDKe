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
if [[ x$INCLUDE_CHECK_QDKe_DIRS_SCRIPT == "xtrue" ]]; then
	echo [QDKe] - We Are Checking Included More Than Once - check-QDKe-dirs.sh.
else
#----------------RUN-ONCE----------------

# Normally runme by source or '.',
# So '$0' will not mean the real script but mean father script.
# We will only check '$0' at here "entry-common.sh".
# Validity from env/../x.sh included this script
# echo [Debug] - '$0'=$0
_PGMDIR_CHECK_QDKe_DIRS=`dirname $0`
_PGMDIR_CHECK_QDKe_DIRS=`cd $_PGMDIR_CHECK_QDKe_DIRS && pwd -P`
_FN_CHECK_QDKe_DIRS=`basename $0`
_FNTYPE_CHECK_QDKe_DIRS=${_FN_CHECK_QDKe_DIRS#*.}
_FNNAME_CHECK_QDKe_DIRS=${_FN_CHECK_QDKe_DIRS%.*}
# echo [Debug] - The script is: $_PGMDIR_CHECK_QDKe_DIRS/$_FNNAME_CHECK_QDKe_DIRS.$_FNTYPE_CHECK_QDKe_DIRS
_PGMDIR_CHECK_QDKe_DIRS=`dirname $_PGMDIR_CHECK_QDKe_DIRS`
if [ ! -d $_PGMDIR_CHECK_QDKe_DIRS/env-msys2 ]; then
	echo [QDKe] - We Are Running Error, Please Check Reference Path.
	exit 1
	return 0
fi

#----------------------------------------
[ -d $QDK_OPT_DIR ]         || mkdir -p $QDK_OPT_DIR  >/dev/null 2>&1
[ -d $QDK_OPT_DIR/bin ]     || mkdir -p $QDK_OPT_DIR/bin  >/dev/null 2>&1
[ -d $QDK_OPT_DIR/lib ]     || mkdir -p $QDK_OPT_DIR/lib  >/dev/null 2>&1
[ -d $QDK_OPT_DIR/include ] || mkdir -p $QDK_OPT_DIR/include  >/dev/null 2>&1

[ -d $QDKE_ROOT ] || mkdir -p $QDKE_ROOT >/dev/null 2>&1
[ -d $QDKE_USR  ] || mkdir -p $QDKE_USR  >/dev/null 2>&1
[ -d $QDKE_HOME ] || mkdir -p $QDKE_HOME >/dev/null 2>&1
[ -d $QDKE_ENV  ] || mkdir -p $QDKE_ENV  >/dev/null 2>&1
[ -d $QDKE_TMP  ] || mkdir -p $QDKE_TMP  >/dev/null 2>&1
[ -d $QDKE_VAR  ] || mkdir -p $QDKE_VAR  >/dev/null 2>&1
[ -d $QDKE_ETC  ] || mkdir -p $QDKE_ETC  >/dev/null 2>&1

[ -d $QDK_STAMP_DIR ]  || mkdir -p $QDK_STAMP_DIR  >/dev/null 2>&1
[ -d $QDKE_STAMP_DIR ] || mkdir -p $QDKE_STAMP_DIR >/dev/null 2>&1
[ -d $QDKE_LOGDIR  ] || mkdir -p  $QDKE_LOGDIR >/dev/null 2>&1

[ -d $APPDATA      ] || mkdir -p  $HOMEPATH >/dev/null 2>&1
[ -d $HOMEPATH     ] || mkdir -p  $HOMEPATH >/dev/null 2>&1


#----------------RUN-ONCE----------------
export INCLUDE_CHECK_QDKe_DIRS_SCRIPT=true
fi
#----------------RUN-ONCE----------------
