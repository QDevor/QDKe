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
. $PROGDIR/../env-diff/diff-common.sh
#----------------------------------------

_diff_notes() {
	:
##-a 将所有的文件看作文本,既使文件看起来像是二进制的也不例外,并且进行逐行比较
##-b 忽略块中空白数目的改变
##-B 忽略插入或删除空行造成的改变
##-c 产生"上下文"(context)格式的输出
##-C[num] 产生"上下文"(context)格式的输出,显示块前后num行的内容,如果不指定num的值,则显示块前后3行的内容
##-H 修改diff处理大文件的方式
##-i 忽略大小写,同样对待大写和小写字母
##-I regexp 忽略插入或删除与正则表达式regexp匹配的行
##-l 将输出结果通过pr命令处理加上页码
##-N 补丁中包含整个新文件
##-p 显示出现块的C函数
##-q 只报告文件是否不同;不输出差别
##-r 比较目录时,进行递归比较
##-s 报告两个文件相同(默认的行为是不报告相同的文件)
##-t 输出时tab扩展为空白
##-u 产生"统一"(unified)格式的输出
##-U[num] 产生"统一"(unified)格式的输出,显示块前后num行的内容,如果不指定num的值,则显示块前后3行的内容
##-v 打印diff的版本号
##-w 逐行比较时忽略空白
##-W cols 如果产生并排格式的输出(参见-y) ,让输出的每一列有cols个字符宽
##-x pattern 当比较目录时,忽略匹配模式pattern的任何文件和子目录
##-X excludefile 忽略在excludefile中的文件类型，注意每种文件占一行
##-y 产生并排格式的输出
}

utils_init() {
	:
	export QDKe_VAR_DATE_DIFF=$(date +%Y%m%d)
}

utils_diff() {
	cd $qdev_build_top || die
#	diff -crN $apps_more $apps_more.orig > $QDKE_PATCHDIR/$QDKe_VAR_DATE_DIFF-$user_name-$apps_name-patch.patch
	diff -upr -x *.bak -x libseh \
		$apps_more $apps_more.orig \
		>$QDKE_PATCHDIR/$QDKe_VAR_DATE_DIFF-$user_name-$apps_name-mingw-port.patch
}

utils_diff2() {
	cd $qdev_build_top || die
	diff -upr $apps_more $apps_more.orig > $QDKE_PATCHDIR/$QDKe_VAR_DATE_DIFF-$user_name-$apps_name-mingw-port.patch
}

#----------------------------------------
work_home=$QDEV_WORK_HOME
user_name=mysql
apps_name=mysql-server
apps_more=github-rc
#----------------------------------------
qdev_init
qdev_set								$work_home $user_name $apps_name $apps_more
utils_init
utils_diff
# utils_diff2
#----------------------------------------