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
_FN_UTILS_GIT=`basename $0`
_FNTYPE_UTILS_GIT=${_FN_UTILS_GIT#*.}
_FNNAME_UTILS_GIT=${_FN_UTILS_GIT%.*}
#----------------------------------------

# git whatchanged
# git status

# git commit -a -m "commit info"

# git push --progress "origin" master:master
# git push --progress "origin" dev:dev

# git pull -v --progress  "origin"

_utils_git_init() {
	
	alias gc='git commit'
	alias gcv='git commit --no-verify'
	
	if [[ "$USERNAME" == "" || "$USEREMAIL" == "" ]]; then
		log_error "We Are Checking USERNAME and USEREMAIL - NULL."
		# return 1
	fi
	
	if [ x$QDKe_HOST_OS = "xLinux" ]; then
		_gitconfig=$HOME/.gitconfig
	else
		_gitconfig=$WORK_HOME/.gitconfig
	fi

	if [[ ! -f $_gitconfig ]]; then
		log_info "We Are Creating $WORK_HOME/.gitconfig."
		echo "[user]"                    >$_gitconfig
		echo "	name = $USERNAME"       >>$_gitconfig
		echo "	email = $USEREMAIL"     >>$_gitconfig
		echo "[core]"                   >>$_gitconfig
		echo "	autocrlf = false"       >>$_gitconfig
		
		cp -rf $_gitconfig $WORK_HOME/.gitconfig $ORIGIN_HOMEPATH/.gitconfig
	else
		log_info "We Are Finding $WORK_HOME/.gitconfig."	
	fi
}

utils_git_set() {
	template_prefix=$QDKE_ROOT/env/env-msys2/tpl-githooks
	dst_hooks_dir=$work_home/.git/hooks
	
	if [ ! -f $dst_hooks_dir/pre-commit.sh ]; then
		git config --global user.name  "QDevor"
		git config --global user.email "QDevor@163.com"
		
		# exe_cmd "mkdir -p $template_dir"
		exe_cmd "cp -rf $template_prefix-pre-commit.sh $dst_hooks_dir/pre-commit.sh"
		exe_cmd "chmod -R a+x $dst_hooks_dir/pre-commit.sh"
		# exe_cmd "git config --global init.templatedir $template_dir"
		# exe_cmd "git config --global core.fileMode false"
		git config --global alias.st 'status'
		git config --global alias.ci 'commit'
		git config --global alias.sb 'submodule'
		git config --global alias.co 'checkout'
		git config --global alias.pm 'push origin master'
		git config --global alias.pd 'push origin dev'
		git config --global alias.lg "log --all --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ci) %C(bold blue)<%an>%Creset' --abbrev-commit"
		git config --global alias.d difftool
		git config --global diff.tool vimdiff
		git config --global difftool.prompt false
	fi
}

utils_git_checkUser() {
	global_name=$(git config --global user.name)
	global_email=$(git config --global user.email)
	repository_name=$(git config user.name)
	repository_email=$(git config user.email)
	
	if [ -z "$repository_name" ] || [ -z "$repository_email" ] || [ -n "$global_name" ] || [ -n "$global_email" ]; then
	# user.email is empty
	echo "[ERROR] - [pre-commit hook] Aborting commit because user.name or user.email is missing. Configure them for this repository. Make sure not to configure globally."
	exit 1
	else
	# user.email is not empty
	exit 0
	fi 
}
#----------------------------------------
_utils_git_checkArgs() {
	if [[ $# -lt 4 ]]; then
		log_error "We Are Checking arguments mismatch."
		# return 1
	fi
	# echo $1 $2 $3 $4

	if [ $4 != "github" ] && \
	   [ $4 != "bitbucket" ] \
	   ; then
	   log_error "We Are Checking git host are not support."
	fi
	
	scm_host='https://'$4'.com'
	
	return 0
}
# $1 - work_home, $2 - user_name, $3 - apps_name $4 - apps_more
utils_git_cloneWithResume () {
	_utils_git_checkArgs $1 $2 $3 $4
	work_home=$1
	user_name=$2
	apps_name=$3
	apps_more=$4
	
	log_info "$FUNCNAME"
	cd $work_home || die
	
	if [ ! -d $user_name/$apps_name/$apps_more ]; then
		cd $work_home || die
		mkdir -p $user_name/$apps_name/$apps_more > /dev/null 2>&1
		cd $user_name/$apps_name/$apps_more || die
		#set HOME=`pwd`
		
		git init
		
		doloop=1
		while [ $doloop = 1 ]; do
			#  git fetch https://github.com/google/zopfli
			log_info "$scm_host/$user_name/$apps_name."
			git fetch $scm_host/$user_name/$apps_name
			
			if [ $? = 0 ]; then
				git remote add origin $scm_host/$user_name/$apps_name
				# git fetch -v "origin"
				# git checkout -b master remotes/origin/master --
				git checkout FETCH_HEAD
				# git fetch https://github.com/google/zopfli HEAD
				log_warning "$user_name/$apps_name/$apps_more - clone successful."
				break;
			fi
			log_warning "$user_name/$apps_name/$apps_more - clone failed - will run again."
			log_warning "$?"
			sleep 1
		done
	else
		log_warning "$user_name/$apps_name/$apps_more - cloned formerly."
	fi
	
	return 0
}

# $1 - work_home, $2 - user_name, $3 - apps_name $4 - apps_more
utils_git_updateWithResume() {
	_utils_git_checkArgs $1 $2 $3 $4
	work_home=$1
	user_name=$2
	apps_name=$3
	apps_more=$4
	
	check_file=$work_home/$user_name/$apps_name/$apps_more/.git/FETCH_HEAD
	if [ -f $check_file ]; then
  	current_datetime=`date +%d`
  	filedate=`stat $check_file | grep Modify | awk '{print $2}'`
  	filetime=`stat $check_file | grep Modify | awk '{split($3,var,".");print var[1]}'`
  	file_datetime=`date -d "$filedate $filetime" +%d`
  	timedelta=`expr $current_datetime - $file_datetime`
  	#if [ "$timedelta" -gt "180" ];then
  	if [ ! "$timedelta" -gt "30" ];then
  		log_warning "$user_name/$apps_name/$apps_more - update too frequently."
  		return 0
  	fi
	fi
	
	log_info "$FUNCNAME"
	cd $work_home || die
	cd $user_name/$apps_name/github || die
	
	#git pull -v --progress  "origin"
	git fetch $scm_host/$user_name/$apps_name HEAD
	git show-branch --list --reflog=1
	
	if [[ $? == "0" ]]; then
		log_warning "$user_name/$apps_name/$apps_more - update successful."
		return 0
	else
		log_warning "$user_name/$apps_name/$apps_more - update failed."
		log_warning "$?"
		return 1
	fi
}
#----------------------------------------
_utils_git_init
work_home=$QDKE_ROOT && utils_git_set
# utils_git_checkUser
#----------------------------------------
