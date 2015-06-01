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

#MYSQL_VERSION_MAJOR=5
#MYSQL_VERSION_MINOR=6
#MYSQL_VERSION_PATCH=24
#MYSQL_VERSION_EXTRA=
utils_init() {
	cd $qdev_build_src || die
	_ver_major=$(cat VERSION | grep "MAJOR" | cut -d'=' -f2)
	_ver_minor=$(cat VERSION | grep "MINOR" | cut -d'=' -f2)
	_ver_patch=$(cat VERSION | grep "PATCH" | cut -d'=' -f2)
	_ver_extra=$(cat VERSION | grep "EXTRA" | cut -d'=' -f2)
	
#	echo major=$_ver_major, minor=$_ver_minor, patch=$_ver_patch, extra=$_ver_extra
	patch_extra_name=$user_name-$apps_name-$_ver_major.$_ver_minor.$_ver_patch
}

utils_diff_tar() {
	cd $QDKE_PATCHDIR || die
	
	# ���� /tmp Ŀ¼�� �������� 24 ���ӵ��ļ�
	# find /tmp -cmin +24 > tmp.list
	# tar -T tmp.list -czvf tmp.expire.tar.gz
	tar -czvf ${QDKe_VAR_DATE_DIFF}-$patch_extra_name-mingw-port-patch.tar.gz *$user_name-$apps_name*.patch
}

utils_diff() {
	cd $qdev_build_top || die
#	diff -crN $apps_more $apps_more.orig > $QDKE_PATCHDIR/$QDKe_VAR_DATE_DIFF-$user_name-$apps_name-patch.patch
	diff -upr \
		-x *.bak \
		-x *.orig \
		-x *.*.orig \
		-x *.rej \
		-x *.*.rej \
		-x default.release \
		-x default.release.done \
		-x libseh \
		-x source_downloads \
		$apps_more.orig $apps_more \
		>$QDKE_PATCHDIR/${QDKe_VAR_DATE_DIFF}0001-$patch_extra_name-before-cmake-mingw-port.patch
}

utils_diff2() {
	cd $qdev_build_dir/include || die
	diff -up \
		my_config.h.orig my_config.h \
		>$QDKE_PATCHDIR/${QDKe_VAR_DATE_DIFF}0002-$patch_extra_name-before-make-mingw-port.patch

	sed -i -e 's/my_config\.h\.orig/my_config_h/g' $QDKE_PATCHDIR/${QDKe_VAR_DATE_DIFF}0002-$patch_extra_name-before-make-mingw-port.patch
	sed -i -e 's/my_config\.h/my_config\.h\.new/g' $QDKE_PATCHDIR/${QDKe_VAR_DATE_DIFF}0002-$patch_extra_name-before-make-mingw-port.patch
	sed -i -e 's/my_config_h/my_config\.h/g' $QDKE_PATCHDIR/${QDKe_VAR_DATE_DIFF}0002-$patch_extra_name-before-make-mingw-port.patch
}

utils_patch() {
	if [ -f $qdev_build_dir/${FUNCNAME}-stamp ]; then
		return 0
	fi
	
	[ x$QDKe_VAR_IS_XP = "xtrue" ] && patch_extra_name=$user_name-$apps_name-5.7.7
	cd $qdev_build_src || die
	patch -f -p1 -u <$QDKE_PATCHDIR/${QDKe_VAR_DATE_DIFF}0001-$patch_extra_name-before-cmake-mingw-port.patch
	touch $qdev_build_dir/${FUNCNAME}-stamp
}

utils_patch2() {
	if [ -f $qdev_build_dir/${FUNCNAME}-stamp ]; then
		return 0
	fi
	
	[ x$QDKe_VAR_IS_XP = "xtrue" ] && patch_extra_name=$user_name-$apps_name-5.7.7
	cd $qdev_build_dir/include || die
	needed_patch_file=$qdev_build_dir/include/my_config.h
	if [ ! -f $needed_patch_file.orig ]; then
		cp -f $needed_patch_file $needed_patch_file.orig || die
	fi
	patch -f -p0 -u <$QDKE_PATCHDIR/${QDKe_VAR_DATE_DIFF}0002-$patch_extra_name-before-make-mingw-port.patch
	touch $qdev_build_dir/${FUNCNAME}-stamp
}

#----------------------------------------
work_home=$QDEV_WORK_HOME
user_name=mysql
apps_name=mysql-server
apps_more=github-rc
#----------------------------------------
if [ x$PROGNAME = "xdiff-mysql-server" ]; then
qdev_init
qdev_set								$work_home $user_name $apps_name $apps_more
utils_init
pause && pause
utils_diff
# utils_diff2
# utils_diff_tar
fi
#----------------------------------------