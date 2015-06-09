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
_PGMDIR_UTILS_GIT=`dirname $0`
_PGMDIR_UTILS_GIT=`cd $_PGMDIR_UTILS_GIT && pwd -P`
#----------------------------------------
FILENAME=`basename $0`
PROGTYPE=${FILENAME#*.}
PROGNAME=${FILENAME%.*}
#----------------------------------------
if [ x$scm_type = "x" ]; then
  scm_type=git
fi

if [ x$scm_type = "xgit" ]; then
:
#. $_PGMDIR_ENTRY_COMMON/env-msys2/utils-git.sh
#. $_PGMDIR_ENTRY_COMMON/env-msys2/utils-github.sh
#. $_PGMDIR_ENTRY_COMMON/env-msys2/utils-github.sh
elif [ x$scm_type = "xcvs" ]; then
:
elif [ x$scm_type = "xhg" ]; then
:
fi
#----------------------------------------
utils_scm_checkArgs() {
	if [[ $# -lt 4 ]]; then
		log_error "We Are Checking arguments mismatch."
		# return 1
	fi
	# echo $1 $2 $3 $4
	
	return 0
}
#----------------------------------------
scm_prepare() {
  scm_work_home=$work_home/$user_name/$apps_name/$apps_more
	[ -d $scm_work_home ] || mkdir -p $scm_work_home > /dev/null 2>&1
	#echo $scm_work_home
	
	utils_scm_checkArgs $1 $2 $3 $4
	
	case $apps_more in
		github)		    SCM_URL_0='https://github.com'
						      ;;
		bitbucket)		SCM_URL_0='https://bitbucket.com'
						      ;;
		*)			log_error "We Are Checking SCM HOST are not support."
		        return 1
							;;
	esac
	
	case $scm_type in
		cvs)		SCM_URL_0=cvs
						SCM_TAG=.$SCM_EXE;;
		svn)		SCM_EXE=svn
						SCM_TAG=.$SCM_EXE;;
		git)		SCM_EXE=git
						SCM_TAG=.$SCM_EXE;;
		hg)			SCM_EXE=hg
						SCM_TAG=.$SCM_EXE;;
		*)			log_error "We Are Checking SCM Type are not support."
		        return 1
							;;
	esac
	
	if [ -d "$scm_work_home/${SCM_TAG}" ]; then
		log_warning "${FUNCNAME} - ${apps_name} -> Has cloned."
		return 1
	fi
	
	if [ -n "${SCM_URL_0}" ]; then
    SCM_URL=${SCM_URL_0}
	elif [ -n "${SCM_URL_1}" ]; then
    SCM_URL=${SCM_URL_1}
  else
    log_warning "${FUNCNAME} - ${apps_name} -> Ignored."
    return 1
  fi
}
#----------------------------------------
scm_clone() {
	log_info "${FUNCNAME} - ${apps_name}"
	
	export MDK_CLONE_REPO_DONE_BEFORE=1
	scm_prepare $1 $2 $3 $4
	if [ $? == "1" ]; then
	  return 1
	fi
	
	log_warning "${FUNCNAME} - ${apps_name} -> Try clone source."
	cd $scm_work_home ||die
#	log_warning "${FUNCNAME} - ${apps_name} -> Cleaning directory to clone."
#	rm -rf *
	
	if [ x$scm_type = "xgit" ]; then
	  $SCM_EXE fetch ${SCM_URL}
	  $SCM_EXE remote add origin ${SCM_URL}
		# git fetch -v "origin"
		# git checkout -b master remotes/origin/master --
		$SCM_EXE checkout FETCH_HEAD
	else
	  $SCM_EXE clone ${SCM_URL} .
	fi
	
	log_warning "${FUNCNAME} - ${apps_name} -> Clone done."
	
	return 0
}
#----------------------------------------
scm_check_updateLast() {
  cd $scm_work_home ||die
  check_file=${scm_work_home}/${SCM_TAG}/HEAD
	if [ -f $check_file ]; then
  	current_datetime=`date +%d`
  	filedate=`stat $check_file | grep Modify | awk '{print $2}'`
  	filetime=`stat $check_file | grep Modify | awk '{split($3,var,".");print var[1]}'`
  	file_datetime=`date -d "$filedate $filetime" +%d`
  	timedelta=`expr $current_datetime - $file_datetime`
  	#if [ "$timedelta" -gt "180" ];then
  	if [ ! "$timedelta" -gt "30" ];then
  		log_warning "${FUNCNAME} - ${apps_name} -> update too frequently."
  		return 1
  	fi
	fi
	return 0
}
#----------------------------------------
scm_update() {
	log_info "${FUNCNAME} - ${apps_name}"
  
	scm_prepare $1 $2 $3 $4
	if [ $? == "1" ]; then
	  return 1
	fi
	
	scm_check_updateLast
	if [ $? == "1" ]; then
	  return 1
	fi
	
	log_warning "${FUNCNAME} - ${apps_name} -> Try Updating source."
	cd $scm_work_home ||die
	
	if [ x$scm_type = "xgit" ]; then
	  #git pull -v --progress  "origin"
	  $SCM_EXE fetch ${SCM_URL} HEAD
	  $SCM_EXE show-branch --list --reflog=1
		$SCM_EXE checkout FETCH_HEAD
	else
	  $SCM_EXE update ${SCM_URL} .
	fi
	
	log_warning "${FUNCNAME} - ${apps_name} -> Updating done."
	
	return 0
}
