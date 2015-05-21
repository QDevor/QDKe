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
# 在这里添加你的首选服务器，它们将被优先使用
# Include = /etc/pacman.d/mirrorlist
# [extra]
# 在这里添加你的首选服务器，它们将被优先使用
# Include = /etc/pacman.d/mirrorlist
# [community]
# 在这里添加你的首选服务器，它们将被优先使用
# Include = /etc/pacman.d/mirrorlist
# [testing]
# Include = /etc/pacman.d/mirrorlist
# 自定义软件仓库的示例
# [custom]
# Server = file:///home/custompkgs  
# archlinuxfr 软件仓库
# [archlinuxfr]
# Server = http://repo.archlinux.fr/i686
# 
# 指定 Pacman 使用的下载工具
# 
# 默认(不指定的情况下)为 wget
# XferCommand = /usr/bin/wget --passive-ftp -c -O %o %u
# 使用 aria2 下载 ，删除下一行行首注释符 #
# XferCommand = aria2c -s 5 -m 5 -d / -o %o %u
# 使用 curl 下载
# XferCommand = /usr/bin/curl %u > %o
# 
# 更新系统
# 
# 在 Archlinux 中，使用一条命令即可对整个系统进行更新：
# pacman -Syu
# 如果你已经使用 pacman -Sy 将本地的包数据库与远程的仓库进行了同步，也可以只执行：
# pacman -Su
# 
# 安装软件包
# 
# pacman -S 软件包名称
# 如果同时安装多个包，用空格分隔包名
# 其它用法：
# 先同步包数据库再安装
# pacman -Sy 软件包名称
# 显示一些操作信息后执行安装
# pacman -Sv 软件包名称
# 安装本地软件包，其扩展名为 pkg.tar.gz
# pacman -U 软件包名称
# 
# 删除软件包
# 
# 只删除软件包，不删除该软件包的依赖
# pacman -R 软件包名称
# 删除软件包的同时，也将删除其依赖
# pacman -Rs 软件包名称
# 删除软件包、依赖关系、配置文件
# pacman -Rsn 软件包名称	
# 删除包时不检查依赖
# pacman -Rd 软件包名称
# 
# 搜索
# 
# 通过关键字搜索软件包
# pacman -Ss 关键字
# 搜索已安装的包
# 查看软件包信息
# pacman -Qi 软件包名称
# 列出软件包的文件
# pacman -Ql 软件包名称 
# 查看某一文件属于哪个软件包
# pacman -Qo 文件名
# 只下载软件包，不安装
# pacman -Sw 软件包名称
# Pacman 下载的软件包缓存于/var/cache/pacman/pkg/ 目录。清理未安装的包
# pacman -Sc
# 清理所有缓存的文件
# pacman -Scc
# 搜索孤立软件包
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
	
#	log_info "[pacman] try search remote - mingw-w64-$arch-$pkgname."
	pacman -Ss mingw-w64-$arch-$pkgname > /dev/null 2>&1
	if [[ $? == "0" ]]; then
		log_warning "[pacman] - found remote - mingw-w64-$arch-$pkgname."
		return 1
	fi
	
#	log_info "[pacman] try search remote - $pkgname."
	pacman -Ss $pkgname > /dev/null 2>&1
	if [[ $? == "0" ]]; then
#		log_warning "[pacman] - found remote - $pkgname."
		return 2
	fi
	
#	log_warning "[pacman] - not found remote - any $pkgname."
	return 0
}

# return 0 - not found
# return 1 - found  arch pkg
# return 2 - found msys2 pkg
_utils_msys2_checkLocal() {
	if [[ ! $# -eq 1 ]]; then
    log_error "Usage: $FUNCNAME deps."
	fi
	
	is_xp=$QDKe_VAR_IS_XP
	arch=$QDKe_VAR_ARCH
	pkgname=`echo $1 | tr -s "=" | tr '[A-Z]' '[a-z]' | tr '_' '-' | tr '=' ' ' | cut -d ' ' -f1`
	 pkgver=`echo $1 | tr -s "=" | tr '[A-Z]' '[a-z]' | tr '_' '-' | grep "="   | cut -d '=' -f2`
	
	log_info "[pacman] try search local - mingw-w64-$arch-$pkgname."
	pacman -Qi mingw-w64-$arch-$pkgname > /dev/null 2>&1
	if [[ $? == "0" ]]; then
#		log_warning "[pacman] - found local - mingw-w64-$arch-$pkgname."
		return 1
	fi
	
#	log_info "[pacman] try search local - $pkgname."
	pacman -Qi $pkgname > /dev/null 2>&1
	if [[ $? == "0" ]]; then
#		log_warning "[pacman] - found local - $pkgname."
		return 2
	fi
	
#	log_warning "[pacman] - not found local - any $pkgname."
	return 0
}

_utils_msys2_checkUpdate() {
	:
}

# _utils_msys2_checkRemote args1
# _utils_msys2_checkLocal  args1
# _utils_msys2_checkUpdate args1