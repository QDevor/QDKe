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
# http://matthew-brett.github.io/pydagogue/python_msvc.html
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

#----------------------------------------
# Python 2.7
# http://repo.continuum.io/miniconda/Miniconda-latest-Windows-x86.exe
# https://repo.continuum.io/miniconda/Miniconda-latest-Windows-x86_64.exe
# Python 3.4
# https://repo.continuum.io/miniconda/Miniconda3-latest-Windows-x86.exe
# https://repo.continuum.io/miniconda/Miniconda3-latest-Windows-x86_64.exe
#----------------------------------------

_utils_python_initVer() {
	export PYTHON=python
	
	export  PYVER=`$PYTHON --version 2>&1 | cut -d ' ' -f2 | cut -d '.' -f1-1`
	export PYVER2=`$PYTHON --version 2>&1 | cut -d ' ' -f2 | cut -d '.' -f1-2`
	export PYVER3=`$PYTHON --version 2>&1 | cut -d ' ' -f2 | cut -d '.' -f1-3`
	#echo v1=$PYVER, v2=$PYVER2, v3=$PYVER3
	
	export PYINSTALL=conda
	
	export PYINSTALL1=pip
	export PYINSTALL2=easy_install
	
	export QDKE_PYTHON_ROOT=$PYTHON_ROOT
	export QDKe_PYSP_PATH=$QDKE_PYTHON_ROOT/Lib/site-packages
#	export PYTHONPATH=$PYTHONPATH:$QDKe_PYSP_PATH
	
	log_warning "We Are Running ON Miniconda Python $PYVER3."
}

_utils_python_initDeps() {
	:
	if [ ! -f $TMP/$FUNCNAME-stamp ]; then
		echo 'y' | conda install \
			numpy scipy matplotlib pandas numba \
			scikit-learn ipython ipython-notebook PIL || die
		touch $TMP/$FUNCNAME-stamp
	fi
}

utils_python_checkPkgExist() {
	pkgname=`echo $1 | tr -s "=" | tr '[A-Z]' '[a-z]' | tr '-' '_' | tr '=' ' ' | cut -d ' ' -f1`
	# pkgver=`echo $1 | tr -s "=" | tr '[A-Z]' '[a-z]' | tr '-' '_' | grep "="   | cut -d '=' -f2`
	
	check_pkg_exist=`cd $QDKe_PYSP_PATH && ls -F | grep "/" | sed 's/.$//' | grep "^$pkgname" | head -1`
	if test "$check_pkg_exist" == ""; then
		pkgname=`echo $1 | tr -s "=" | tr '[a-z]' '[A-Z]' | tr '-' '_' | tr '=' ' ' | cut -d ' ' -f1`
		check_pkg_exist=`cd $QDKe_PYSP_PATH && ls -F | grep "/" | sed 's/.$//' | grep "^$pkgname" | head -1`
	fi
	if test "$check_pkg_exist" != ""; then
		return 1
	fi
	
	check_pkg_exist_file=$QDKe_PYSP_PATH/easy-install.pth
	if [ ! -f $check_pkg_exist_file ]; then
		return 0
	fi
	
	check_pkg_exist=`cat $check_pkg_exist_file | grep "\./$pkgname-.*"`
	if test "$check_pkg_exist" == ""; then
		pkgname=`echo $1 | tr -s "=" | tr '[a-z]' '[A-Z]' | tr '-' '_' | tr '=' ' ' | cut -d ' ' -f1`
		check_pkg_exist=`cd $check_pkg_exist_file >/dev/null 2>&1 && ls -F | grep "/" | sed 's/.$//' | grep "^$pkgname" | head -1`
	fi
	if test "$check_pkg_exist" != ""; then
		return 1
	fi
	
	return 0
}

utils_python_install() {
	if [[ $# -lt 1 ]]; then
    log_error "Usage: $FUNCNAME deps1,deps2,..."
	fi
	
	for dep in $@; do
		check_pkg_exist=`utils_python_checkPkgExist $dep`
		if [ x$check_pkg_exist = "x1" ];then
			log_info "Python Installed - $dep."
			continue
		else
			log_info "Python Installing - $dep."
		fi
		
		doloop=1
		while [ $doloop = 1 ]; do
			conda clean --lock
			echo 'y' | conda install $@
			
			if [ $? = 0 ]; then
				break;
			fi
			log_warning "$pkgname - Install failed - auto try again."
			sleep 3
		done	# while [ $doloop = 1 ]
	done		# for dep in $@
}

_utils_python_initVer
_utils_python_initDeps

# utils_python_install