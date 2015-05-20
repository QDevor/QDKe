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

_PGMDIR_UTILS_GITHUB=`dirname $0`
_PGMDIR_UTILS_GITHUB=`cd $_PGMDIR_UTILS_GITHUB && pwd -P`
_FN_UTILS_GITHUB=`basename $0`
_FNTYPE_UTILS_GITHUB=${_FN_UTILS_GITHUB#*.}
_FNNAME_UTILS_GITHUB=${_FN_UTILS_GITHUB%.*}

_utils_github_init() {
	if [[ "$USERNAME" == "" || "$USEREMAIL" == "" ]]; then
		log_error "We Are Checking USERNAME and USEREMAIL - NULL."
		# return 1
	fi
	
	_gitconfig=$WORK_HOME/.gitconfig
	if [ ! -f $_gitconfig ]; then
		log_info "We Are Creating $WORK_HOME/.gitconfig." 
		echo "[user]"                    >$_gitconfig
		echo "	name = $USERNAME"       >>$_gitconfig
		echo "	email = $USEREMAIL"     >>$_gitconfig
		echo "[core]"                   >>$_gitconfig
		echo "	autocrlf = false"       >>$_gitconfig
	fi
	
	return 0
}

_utils_github_check() {
	if [[ $# -lt 3 ]]; then
		log_error "We Are Checking arguments mismatch."
		# return 1
	fi
	return 0
}

# $1 - work_home, $2 - user_name, $3 - apps_name
utils_github_cloneWithResume () {
	_utils_github_check $1 $2 $3
	work_home=$1
	user_name=$2
	apps_name=$3
	
	log_info "$FUNCNAME"
	cd $work_home || die
	
	if [ ! -d $user_name/$apps_name/github ]; then
		cd $work_home || die
		mkdir -p $user_name/$apps_name/github > /dev/null 2>&1
		cd $user_name/$apps_name/github || die
		set HOME=`pwd`
		
		git init
		
		doloop=1
		while [ $doloop = 1 ]; do
			#  git fetch https://github.com/google/zopfli
			log_info "https://github.com/$user_name/$apps_name."
			git fetch https://github.com/$user_name/$apps_name
			
			if [ $? = 0 ]; then
				git remote add origin https://github.com/$user_name/$apps_name
				git fetch -v "origin"
				git checkout -b master remotes/origin/master --
				# git checkout FETCH_HEAD
				# git fetch https://github.com/google/zopfli HEAD
				log_warning "$user_name/$apps_name/github - clone successful."
				break;
			fi
			log_warning "$user_name/$apps_name/github - clone failed - will run again."
			log_warning "$?"
			sleep 1
		done
	else
		log_warning "$user_name/$apps_name/github - cloned formerly."
	fi
	
	return 0
}

# $1 - work_home, $2 - user_name, $3 - apps_name
utils_github_updateWithResume() {
	_utils_github_check $1 $2 $3
	work_home=$1
	user_name=$2
	apps_name=$3
	
	log_info "$FUNCNAME"
	cd $work_home || die
	cd $user_name/$apps_name/github || die
	
	#git pull -v --progress  "origin"
	git fetch https://github.com/$user_name/$apps_name HEAD
	git show-branch --list --reflog=1
	
	if [[ $? == "0" ]]; then
		log_warning "$user_name/$apps_name/github - update successful."
		return 0
	else
		log_warning "$user_name/$apps_name/github - update failed."
		log_warning "$?"
		return 1
	fi
}

# $1 - work_home, $2 - user_name, $3 - apps_name
utils_github_clone() {
	_utils_github_check $1 $2 $3
	work_home=$1
	user_name=$2
	apps_name=$3
	
	log_info "$FUNCNAME"
	cd $work_home || die
	
	if [ ! -d $user_name/$apps_name ]; then
		cd $work_home || die
		mkdir -p $user_name/$apps_name > /dev/null 2>&1
		cd $user_name/$apps_name || die
		
		git clone https://github.com/$user_name/$apps_name github
		if [[ $? == "0" ]]; then
			log_warning "$user_name/$apps_name/github - clone successful."
			return 0
		else
			log_warning "$user_name/$apps_name/github - clone failed."
			log_warning "$?"
			return 1
		fi
	fi
}

# $1 - work_home, $2 - user_name, $3 - apps_name
utils_github_update() {
	_utils_github_check $1 $2 $3
	work_home=$1
	user_name=$2
	apps_name=$3
	
	log_info "$FUNCNAME"
	cd $work_home || die
	cd $user_name/$apps_name/github || die
	
	git pull -v --progress  "origin"
	git show-branch --list --reflog=1
	
	if [[ $? == "0" ]]; then
		log_warning "$user_name/$apps_name/github - update successful."
		return 0
	else
		log_warning "$user_name/$apps_name/github - update failed."
		log_warning "$?"
		return 1
	fi
}

_utils_github_init
# try wsUtils_github_SrcFetch to resumes transmission at break-points
# wsUtils_github_SrcFetch
# wsUtils_github_SrcClone
# wsUtils_github_SrcUpdate