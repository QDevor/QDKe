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
_PGMDIR_UTILS_PYTHON=`dirname $0`
_PGMDIR_UTILS_PYTHON=`cd $_PGMDIR_UTILS_PYTHON && pwd -P`
_FN_UTILS_PYTHON=`basename $0`
_FNTYPE_UTILS_PYTHON=${_FN_UTILS_PYTHON#*.}
_FNNAME_UTILS_PYTHON=${_FN_UTILS_PYTHON%.*}
#----------------------------------------
# 
# Compiling Python 2.7 Modules on Windows 32 and 64 using 
# MSVC++ 2008 Express
# 
# http://blog.victorjabur.com/2011/06/05/compiling-python-2-7-modules-on-windows-32-and-64-using-msvc-2008-express/
# 
# Observation: 
# Don¡¯t use Microsoft Visual C++ Express Edition 2010 to 
# build python modules, because this will not work due to 
# Python 2.7 was built using the 2008 version. 
# This is an error that occurs when you try to build 
# PyCrypto and Paramiko using the 2010 version and 
# execute the import module:
#----------------------------------------

#----------------RUN-ONCE----------------
if [[ x$INCLUDE_PYTHON_MSVC_SCRIPT == "xtrue" ]]; then
	:
else
#----------------RUN-ONCE----------------

utils_python_msvc2008_patch_msvccompiler() {
	needed_patch_file=$QDKE_PYTHON_ROOT/lib/distutils/msvccompiler.py
	sed -i -e '#prefix = \"MSC v.\"#a\return 9.0/' \
			$needed_patch_file
}

utils_python_msvc2008_unpatch_msvccompiler() {
	:
}

utils_python_msvc2008_patch_msvc9compiler() {
	needed_patch_file=$QDKE_PYTHON_ROOT/lib/distutils/msvc9compiler.py
	sed -i -e '#ld_args.append('/MANIFESTFILE:' + temp_manifest)#i\ld_args.append('/MANIFEST')/' \
			$needed_patch_file
}

utils_python_msvc2008_unpatch_msvc9compiler() {
	:
}
#----------------------------------------
# utils_python_msvc2008_patch_msvccompiler
# utils_python_msvc2008_unpatch_msvccompiler
# utils_python_msvc2008_patch_msvc9compiler
# utils_python_msvc2008_unpatch_msvc9compiler
#----------------RUN-ONCE----------------
export INCLUDE_PYTHON_MSVC_SCRIPT=true
fi
#----------------RUN-ONCE----------------