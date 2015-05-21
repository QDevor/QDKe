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

# ANSI控制码输出有颜色文本
# \e[背景色;前景色;高亮m
# \033[背景色;前景色;高亮m
# 背景色: 0 透明（使用终端颜色）,1 高亮 40 黑, 41 红, 42 绿, 43 黄, 44 蓝 45 紫, 46 青
# 前景色: 30 黑 31 红, 32 绿, 33 黄, 34 蓝, 35 紫, 36 青绿, 37 白（灰）
# 高亮: 高亮是1，不高亮是0
# m后面紧跟字符串
# 

UTILS_PROMPT="-purple [ -white sayMXE -purple ]"

cfont() {
while (($#!=0))
do
	case $1 in
		-b)     echo -ne " ";
		;;
		-t)     echo -ne "\t";
		;;
		-n)     echo -ne "\n";
		;;
 		-black) echo -ne "\033[1;30m";
		;;
		-red)   echo -ne "\033[1;31m";
		;;
		-green)		echo -ne "\033[1;32m";
		;;
		-yellow)	echo -ne "\033[1;33m";
		;;
		-blue)		echo -ne "\033[1;34m";
		;;
		-purple)	echo -ne "\033[1;35m";
		;;
		-cyan)		echo -ne "\033[1;36m";
		;;
		-white|-gray)	echo -ne "\033[1;37m";
		;;
		-reset)				echo -ne "\033[0;0m";
		;;
		-h|-help|--help)	echo "Usage: cfont -color1 message1 -color2 message2 ...";
											echo "eg:    cfont -red [ -blue message1 message2 -red ]";
		;;
		*)				echo -ne "$1"
		;;
	esac
	shift
done
}

clogi() {
	cfont ${UTILS_PROMPT} -green "Info: "
	cfont "${@}"
}

clog() {
	cfont "${@}"
}

# INFO		Green
# WARNING	Yellow
# ERROR		Purple
# FATAL		Red
# displays information message
log_info() {
	cfont ${UTILS_PROMPT} -green " - Info - "
	cfont -reset "$1"
	cfont -n
	#echo -e "\e[1;32m ${UTILS_PROMPT} Info:\e[0;0m ${1}";
}

# displays warning message only
log_warning() {
	cfont ${UTILS_PROMPT} -yellow " - Warning - "
	cfont -reset "$1"
	cfont -n
	#echo -e "\e[1;33m*** Warning:\e[0;0m ${1}";
}

# displays error message and exits
log_error() {
	case $? in
		0) local errorcode=1 ;;
		*) local errorcode=$? ;;
	esac
	cfont ${UTILS_PROMPT} -red " - Error - "
	cfont -reset "${1:-no error message provided}"
	cfont -n
	#echo -e "\e[1;31m*** ERROR:\e[0;0m ${1:-no error message provided}";
	exit ${errorcode};
}

# displays command to stdout before execution
log_verbose() {
	echo "${@}"
	"${@}"
	return $?
}

# Helper functions
function log_headline {
	#log "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
	#log "$1"
	log_info "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
	cfont -n
	log_info "$1"
}

function log_done {
	#log ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	cfont -n
	if ! [ -z "$1" ]; then
		log_info "$1 -> Done"
	fi
	log_info ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
}

function die() {
	log_error "$?"
}

