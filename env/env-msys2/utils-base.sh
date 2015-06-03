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
_PGMDIR_UTILS_BASE=`dirname $0`
_PGMDIR_UTILS_BASE=`cd $_PGMDIR_UTILS_BASE && pwd -P`
_FN_UTILS_BASE=`basename $0`
_FNTYPE_UTILS_BASE=${_FN_UTILS_BASE#*.}
_FNNAME_UTILS_BASE=${_FN_UTILS_BASE%.*}
#----------------------------------------

exe_cmd() {
	echo $1
	eval $1
}

_pause() {
	read -n 1 -p "$*" INP
	if [ $INP != '' ] ; then
		echo -ne '\b \n'
	fi
}

pause() {
	read -n1 -p "Press any key to continue..."
}

_utils_base_init() {
	# 查看当前操作系统内核信息
	#uname -a
	# 查看当前操作系统发行版信息
	#cat /etc/issue | grep Linux
	# 查看CPU信息
	_utils_base_cpuinfo=$(cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c)
	# echo $_utils_base_cpuinfo
	_utils_base_nprocs=$(echo $_utils_base_cpuinfo | cut -f1 -d' ')
	#echo $_utils_base_nprocs
	_utils_base_cpuhz=$(cat /proc/cpuinfo | grep 'cpu MHz' | cut -f2 -d: | uniq -c)
	#echo $_utils_base_cpuhz
	_utils_base_cpuhz=$(echo $_utils_base_cpuhz | cut -f2 -d' ' | cut -f1 -d'.')
	#echo $_utils_base_cpuhz
	# cat /proc/cpuinfo | grep physical | uniq -c
	# CPU运行在32/64bit模式
	#getconf LONG_BIT
	# lm指long mode, 支持lm则是64bit
	_utils_base_lm=$(cat /proc/cpuinfo | grep flags | grep ' lm ' | wc -l)
	# cpu完整物理信息
	#dmidecode | grep -A48 'Processor Information$'
	
	log_info "We Are Checking CPU Info Again."
	if [[ $_utils_base_lm -gt 0 ]]; then
		log_info "We Are Finding $_utils_base_nprocs CPU, $_utils_base_cpuhz MHz(support 64bit)."
	else
		log_info "We Are Finding $_utils_base_nprocs CPU, $_utils_base_cpuhz MHz(not support 64bit)."
	fi
	# [[ -n $QDKe_VAR_NPROCS ]]  || export QDKe_VAR_NPROCS=$_utils_base_nprocs
	[[ -n $QDKe_VAR_CPUMHZ ]]  || export QDKe_VAR_CPUMHZ=$_utils_base_cpuhz
	
	# [ x$QDKe_HOST_OS != "x" ] || export QDKe_HOST_OS=$(uname -s)
	[[ -n $QDKe_HOST_OS ]]     || export QDKe_HOST_OS=$(uname -s)
	[[ -n $QDKe_VAR_NPROCS ]]  || QDKe_VAR_NPROCS=$(nproc 2>/dev/null || echo 1)
	[[ -n $QDKe_VAR_ARCH ]]    || QDKe_VAR_ARCH=$(uname -m)

}

# $1 - pkg_file, $2 - pkg_url
# $3 - true - loop until sucessful
loop_curl() {
	if [ ! -f $1 ]; then
		exe_loop=1
		while [ $exe_loop = 1 ]; do
			curl -O $2
			if [ $? = 0 ]; then
				break;
			fi
			sleep 3
		done
	fi
}

loop_wget() {
	if [ ! -f $1 ]; then
		exe_loop=1
		while [ $exe_loop = 1 ]; do
			wget -c -T 30 -t 3 $wget_quiet "$2" \
				&>$QDKE_LOGDIR/$user_name/$FUNCNAME-download
			if [ $? = 0 ]; then
				break;
			fi
			sleep 3
		done
	fi
}
#----------------------------------------
_utils_base_init
# exe_cmd
# pause
