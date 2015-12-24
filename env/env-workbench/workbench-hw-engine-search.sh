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
if [[ x$INCLUDE_WORKBENCH_HW_ENGINE_SEARCH_SCRIPT == "xtrue" ]]; then
	echo [QDKe] - We Are Checking Included More Than Once - workbench-hw-engine-search.sh.
else
#----------------RUN-ONCE----------------
PROGDIR=`dirname $0`
PROGDIR=`cd $PROGDIR && pwd -P`

# echo [Debug] - '$0'=$0
FILENAME=`basename $0`
PROGTYPE=${FILENAME#*.}
PROGNAME=${FILENAME%.*}
# echo [Debug] - The script is: $PROGDIR/$PROGNAME.$PROGTYPE
#----------------------------------------
. $PROGDIR/../env-msys2/entry-common.sh
. $PROGDIR/../env-workbench/workbench-common.sh
#----------------------------------------
. $PROGDIR/../env-workbench/workbench-hw-common.sh
#----------------------------------------

#----------------------------------------
# s?wd=inurl%3Alm2831
# ':'
engine_search_regex_colon=%3A
engine_search_regex_space=%20
engine_search_regex_append=' '
engine_search_regex_remove=' -'

engine_search_baidu_url=http://www.baidu.com

engine_search_brand_url=$engine_search_baidu_url


# 两个著名的免费代理网站：

# freeproxylists.net（全球数十个国家的免费代理，每日都更新）

# xroxy.com（通过设置端口类型、代理类型、国家名称进行筛选）

# 在freeproxylists.net网站，选择一台中国的免费代理服务器为例，来介绍proxy代理抓取网页：

# 218.107.21.252:8080（ip为218.107.21.252；port为8080，中间以冒号“:”隔开，组成一个套接字）



# （1）curl 通过代理抓取百度首页

# curl -x 218.107.21.252:8080 -o aaaaa http://www.baidu.com（port 常见有80，8080，8086，8888，3128等，默认为80）

# 注：-x表示代理服务器（ip:port），即curl先连接到代理服务器218.107.21.252:8080，然后再通过218.107.21.252:8080下载百度首页，
# 最后218.107.21.252:8080把下载的百度首页传给curl至本地（curl不是直接连接百度服务器下载首页的，而是通过一个中介代理来完成）



# （2）wget 通过代理抓取百度首页

# wget通过代理下载，跟curl不太一样，需要首先设置代理服务器的http_proxy=ip:port

# 以ubuntu为例，在当前用户目录（cd ~），新建一个wget配置文件（.wgetrc），输入代理配置：

# http_proxy=218.107.21.252:8080

workbench_hw_engine_search() {
  engine_search_try=$1
  engine_search_try=`echo $engine_search_try | tr ' ' '%20'`
  engine_search_url=$engine_search_brand_url/s?wd=inurl$engine_search_regex_colon$engine_search_try
  echo [debug] $engine_search_url
  
  #tmpfile=`mktemp`
  tmpfile=$QDKE_TMP/tmpcurl.html
  
  # -y表示测试网速的时间； -Y表示-y这段时间下载的字节量（byte为单位）； -m表示容许请求连接的最大时间，超过则连接自动断掉放弃连接
  curl -y 60 -Y 1 -m 60 $engine_search_url -o $tmpfile
  cat $tmpfile | sed "s/\"url\"/\r\n/g" | grep "\"title\":.*" | sed "s/.*title/\"title/g" | grep "\"title\":\".*\"" > $QDKE_TMP/outcome_title.txt
  cat $tmpfile | sed "s/\"url\"/\r\n/g" | grep "href = .*" | sed "s/.*href = /\"link\":/g" | grep "\"link\":\".*\"" > $QDKE_TMP/outcome_link.txt
  
  tmplink=`cat $QDKE_TMP/outcome_link.txt | head -1 | sed "s/\"link\":\"\(.*\)\"/\1/g"`
  curl -y 60 -Y 1 -m 60 -L $tmplink -o $tmpfile
  
  #pause
  #rm -rf tmpfile
}
#----------------------------------------
workbench_hw_engine_search $@
#----------------RUN-ONCE----------------
export INCLUDE_WORKBENCH_HW_ENGINE_SEARCH_SCRIPT=true
fi
#----------------RUN-ONCE----------------
