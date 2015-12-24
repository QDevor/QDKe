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


# ������������Ѵ�����վ��

# freeproxylists.net��ȫ����ʮ�����ҵ���Ѵ���ÿ�ն����£�

# xroxy.com��ͨ�����ö˿����͡��������͡��������ƽ���ɸѡ��

# ��freeproxylists.net��վ��ѡ��һ̨�й�����Ѵ��������Ϊ����������proxy����ץȡ��ҳ��

# 218.107.21.252:8080��ipΪ218.107.21.252��portΪ8080���м���ð�š�:�����������һ���׽��֣�



# ��1��curl ͨ������ץȡ�ٶ���ҳ

# curl -x 218.107.21.252:8080 -o aaaaa http://www.baidu.com��port ������80��8080��8086��8888��3128�ȣ�Ĭ��Ϊ80��

# ע��-x��ʾ�����������ip:port������curl�����ӵ����������218.107.21.252:8080��Ȼ����ͨ��218.107.21.252:8080���ذٶ���ҳ��
# ���218.107.21.252:8080�����صİٶ���ҳ����curl�����أ�curl����ֱ�����Ӱٶȷ�����������ҳ�ģ�����ͨ��һ���н��������ɣ�



# ��2��wget ͨ������ץȡ�ٶ���ҳ

# wgetͨ���������أ���curl��̫һ������Ҫ�������ô����������http_proxy=ip:port

# ��ubuntuΪ�����ڵ�ǰ�û�Ŀ¼��cd ~�����½�һ��wget�����ļ���.wgetrc��������������ã�

# http_proxy=218.107.21.252:8080

workbench_hw_engine_search() {
  engine_search_try=$1
  engine_search_try=`echo $engine_search_try | tr ' ' '%20'`
  engine_search_url=$engine_search_brand_url/s?wd=inurl$engine_search_regex_colon$engine_search_try
  echo [debug] $engine_search_url
  
  #tmpfile=`mktemp`
  tmpfile=$QDKE_TMP/tmpcurl.html
  
  # -y��ʾ�������ٵ�ʱ�䣻 -Y��ʾ-y���ʱ�����ص��ֽ�����byteΪ��λ���� -m��ʾ�����������ӵ����ʱ�䣬�����������Զ��ϵ���������
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
