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

#----------------RUN-ONCE----------------
if [[ x$INCLUDE_READY_UBUNTU_SCRIPT == "xtrue" ]]; then
	:
else
#----------------RUN-ONCE----------------

# 更新apt-get版本
# gedit /etc/apt/sources.list
# 前面的“#”号，小心不要去掉注释前面的“#”号
apt-get update

# 安装 vsftpd 服务
apt-get install vsftpd

# gedit /etc/vsftpd.conf

# 以下两行前面的“#”去掉
#local_enable=YES

#write_enable=YES

# 输入命令重启 vsftpd：
/etc/init.d/vsftpd restart

#安装编译器 gcc、g++等
#依次在终端输入一下命令:

apt-get install build-essential
apt-get install bison flex
apt-get install manpages-dev

#----------------RUN-ONCE----------------
export INCLUDE_READY_UBUNTU_SCRIPT=true
fi
#----------------RUN-ONCE----------------

