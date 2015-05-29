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
##-a �����е��ļ������ı�,��ʹ�ļ����������Ƕ����Ƶ�Ҳ������,���ҽ������бȽ�
##-b ���Կ��пհ���Ŀ�ĸı�
##-B ���Բ����ɾ��������ɵĸı�
##-c ����"������"(context)��ʽ�����
##-C[num] ����"������"(context)��ʽ�����,��ʾ��ǰ��num�е�����,�����ָ��num��ֵ,����ʾ��ǰ��3�е�����
##-H �޸�diff������ļ��ķ�ʽ
##-i ���Դ�Сд,ͬ���Դ���д��Сд��ĸ
##-I regexp ���Բ����ɾ����������ʽregexpƥ�����
##-l ��������ͨ��pr��������ҳ��
##-N �����а����������ļ�
##-p ��ʾ���ֿ��C����
##-q ֻ�����ļ��Ƿ�ͬ;��������
##-r �Ƚ�Ŀ¼ʱ,���еݹ�Ƚ�
##-s ���������ļ���ͬ(Ĭ�ϵ���Ϊ�ǲ�������ͬ���ļ�)
##-t ���ʱtab��չΪ�հ�
##-u ����"ͳһ"(unified)��ʽ�����
##-U[num] ����"ͳһ"(unified)��ʽ�����,��ʾ��ǰ��num�е�����,�����ָ��num��ֵ,����ʾ��ǰ��3�е�����
##-v ��ӡdiff�İ汾��
##-w ���бȽ�ʱ���Կհ�
##-W cols ����������Ÿ�ʽ�����(�μ�-y) ,�������ÿһ����cols���ַ���
##-x pattern ���Ƚ�Ŀ¼ʱ,����ƥ��ģʽpattern���κ��ļ�����Ŀ¼
##-X excludefile ������excludefile�е��ļ����ͣ�ע��ÿ���ļ�ռһ��
##-y �������Ÿ�ʽ�����
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