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

if [[ x$INCLUDE_CHECK_DFLT_DIRS_SCRIPT == "xtrue" ]]; then
	return 0
fi
#----------------------------------------
_PGMDIR_CHECK_DFLT_DIRS=`dirname $0`
_PGMDIR_CHECK_DFLT_DIRS=`cd $_PGMDIR_CHECK_DFLT_DIRS && pwd -P`
_FN_CHECK_DFLT_DIRS=`basename $0`
_FNTYPE_CHECK_DFLT_DIRS=${_FN_CHECK_DFLT_DIRS#*.}
_FNNAME_CHECK_DFLT_DIRS=${_FN_CHECK_DFLT_DIRS%.*}
#----------------------------------------
if [[ $QDKE_ROOT == "" ]]; then
	export QDKE_ROOT=`cd $_PGMDIR_CHECK_DFLT_DIRS/../../ && pwd -P`
	export QDKE_USR=$QDKE_ROOT/usr
	export QDKE_HOME=$QDKE_ROOT/home
	export QDKE_ENV=$QDKE_ROOT/env
	export QDKE_TMP=$QDKE_ROOT/tmp
	export QDKE_VAR=$QDKE_ROOT/var
	export QDKE_ETC=$QDKE_ROOT/etc
else
	export QDKE_ROOT=`cygpath -u $QDKE_ROOT`
	export QDKE_USR=`cygpath -u $QDKE_USR`
	export QDKE_HOME=`cygpath -u $QDKE_HOME`
	export QDKE_ENV=`cygpath -u $QDKE_ENV`
	export QDKE_TMP=`cygpath -u $QDKE_TMP`
	export QDKE_VAR=`cygpath -u $QDKE_VAR`
	export QDKE_ETC=`cygpath -u $QDKE_ETC`
fi
#----------------------------------------
export QDK_ROOT=`cygpath -u $QDK_ROOT`
export QDK_OPT_DIR=$QDK_ROOT/opt

export QDK_STAMPDIR=/var/ready_qdk
export QDKE_STAMPDIR=$QDKE_VAR/ready_qdke
export QDKE_LOGDIR=$QDKE_VAR/log
export QDKE_PATCHDIR=$QDKE_ETC/patch

export WORK_HOME=$QDKE_HOME
export HOME=$WORK_HOME
export TEMP=$QDKE_TMP
export TMP=$TEMP
export TMPDIR=$TEMP
export APPDATA=$TEMP/appdata

export HOMEPATH=$QDKE_USR/$USERNAME
export USERPROFILE=$HOMEPATH
#----------------------------------------
[ -n "$MYSQL_SERVER_ROOT" ]  && export MYSQL_SERVER_ROOT=`cygpath -u $MYSQL_SERVER_ROOT`
[ -n "$PYTHON_ROOT" ]        && export PYTHON_ROOT=`cygpath -u $PYTHON_ROOT`
#----------------------------------------
export INCLUDE_CHECK_DFLT_DIRS_SCRIPT=true
