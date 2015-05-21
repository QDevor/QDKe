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
_PGMDIR_UTILS_PACMAN=`dirname $0`
_PGMDIR_UTILS_PACMAN=`cd $_PGMDIR_UTILS_PACMAN && pwd -P`
_FN_UTILS_PACMAN=`basename $0`
_FNTYPE_UTILS_PACMAN=${_FN_UTILS_PACMAN#*.}
_FNNAME_UTILS_PACMAN=${_FN_UTILS_PACMAN%.*}
#----------------------------------------

#----------------------------------------
# The pacman package manager is one of the major distinguishing features of Arch Linux. 
# It combines a simple binary package format with an easy-to-use build system. 
# The goal of pacman is to make it possible to easily manage packages, 
# whether they are from the official repositories or the user's own builds.
#
# pacman is written in the C programming language and uses the .pkg.tar.xz package format.
#
# 
# pacman's settings are located in /etc/pacman.conf.
# [core]
# ��������������ѡ�����������ǽ�������ʹ��
# Include = /etc/pacman.d/mirrorlist
# [extra]
# ��������������ѡ�����������ǽ�������ʹ��
# Include = /etc/pacman.d/mirrorlist
# [community]
# ��������������ѡ�����������ǽ�������ʹ��
# Include = /etc/pacman.d/mirrorlist
# [testing]
# Include = /etc/pacman.d/mirrorlist
# �Զ�������ֿ��ʾ��
# [custom]
# Server = file:///home/custompkgs  
# archlinuxfr ����ֿ�
# [archlinuxfr]
# Server = http://repo.archlinux.fr/i686
# 
# ָ�� Pacman ʹ�õ����ع���
# 
# Ĭ��(��ָ���������)Ϊ wget
# XferCommand = /usr/bin/wget --passive-ftp -c -O %o %u
# ʹ�� aria2 ���� ��ɾ����һ������ע�ͷ� #
# XferCommand = aria2c -s 5 -m 5 -d / -o %o %u
# ʹ�� curl ����
# XferCommand = /usr/bin/curl %u > %o
# 
# ����ϵͳ
# 
# �� Archlinux �У�ʹ��һ������ɶ�����ϵͳ���и��£�
# pacman -Syu
# ������Ѿ�ʹ�� pacman -Sy �����صİ����ݿ���Զ�̵Ĳֿ������ͬ����Ҳ����ִֻ�У�
# pacman -Su
# 
# ��װ�����
# 
# pacman -S ���������
# ���ͬʱ��װ��������ÿո�ָ�����
# �����÷���
# ��ͬ�������ݿ��ٰ�װ
# pacman -Sy ���������
# ��ʾһЩ������Ϣ��ִ�а�װ
# pacman -Sv ���������
# ��װ���������������չ��Ϊ pkg.tar.gz
# pacman -U ���������
# 
# ɾ�������
# 
# ֻɾ�����������ɾ���������������
# pacman -R ���������
# ɾ���������ͬʱ��Ҳ��ɾ��������
# pacman -Rs ���������
# ɾ���������������ϵ�������ļ�
# pacman -Rsn ���������	
# ɾ����ʱ���������
# pacman -Rd ���������
# 
# ����
# 
# ͨ���ؼ������������
# pacman -Ss �ؼ���
# �����Ѱ�װ�İ�
# �鿴�������Ϣ
# pacman -Qi ���������
# �г���������ļ�
# pacman -Ql ��������� 
# �鿴ĳһ�ļ������ĸ������
# pacman -Qo �ļ���
# ֻ���������������װ
# pacman -Sw ���������
# Pacman ���ص������������/var/cache/pacman/pkg/ Ŀ¼������δ��װ�İ�
# pacman -Sc
# �������л�����ļ�
# pacman -Scc
# �������������
# pacman -Qdt
# 
# pacman ships with a number of other utilities that can make interacting with 
# your system much simpler. To see the full list, run:
# pacman -Ql pacman | awk -F"[/ ]" '/\/usr\/bin/ {print $5}'
#

# return 0 - not found
# return 1 - found  arch pkg
# return 2 - found msys2 pkg
_utils_msys2_checkRemote() {
	if [[ ! $# -eq 1 ]]; then
    log_error "Usage: $FUNCNAME deps."
	fi
	
	is_xp=$QDKe_VAR_IS_XP
	arch=$QDKe_VAR_ARCH
	pkgname=`echo $1 | tr -s "=" | tr '[A-Z]' '[a-z]' | tr '_' '-' | tr '=' ' ' | cut -d ' ' -f1`
	 pkgver=`echo $1 | tr -s "=" | tr '[A-Z]' '[a-z]' | tr '_' '-' | grep "="   | cut -d '=' -f2`
	
	log_info "[pacman] try search remote - mingw-w64-$arch-$pkgname."
	pacman -Ss mingw-w64-$arch-$pkgname > /dev/null 2>&1
	if [[ $? == "0" ]]; then
		log_warning "[pacman] - found - mingw-w64-$arch-$pkgname."
		return 1
	fi
	
	log_info "[pacman] try search remote - $pkgname."
	pacman -Ss $pkgname > /dev/null 2>&1
	if [[ $? == "0" ]]; then
		log_warning "[pacman] - found - $pkgname."
		return 2
	fi
	
	log_warning "[pacman] - not found - $pkgname."
	return 0
}

# return 0 - not found
# return 1 - found any pkg
_utils_msys2_checkLocal() {
	if [[ ! $# -eq 1 ]]; then
    log_error "Usage: $FUNCNAME deps."
	fi
	
	is_xp=$QDKe_VAR_IS_XP
	arch=$QDKe_VAR_ARCH
	pkgname=`echo $1 | tr -s "=" | tr '[A-Z]' '[a-z]' | tr '_' '-' | tr '=' ' ' | cut -d ' ' -f1`
	 pkgver=`echo $1 | tr -s "=" | tr '[A-Z]' '[a-z]' | tr '_' '-' | grep "="   | cut -d '=' -f2`
	
	log_info "[pacman] try search local - $pkgname."
	pacman -Qi $pkgname > /dev/null 2>&1
	if [[ $? == "0" ]]; then
		log_warning "[pacman] - found - $pkgname."
		return 1
	fi
	
	log_warning "[pacman] - not found - $pkgname."
	return 0
}

_utils_msys2_checkUpdate() {
	:
}

# _utils_msys2_checkRemote args1
# _utils_msys2_checkLocal  args1
# _utils_msys2_checkUpdate args1