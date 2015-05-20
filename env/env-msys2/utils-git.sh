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
}

utils_git_set() {
	env		
	template_prefix=$QDkE_ROOT/env/env-msys2/tpl-git-hooks
	dst_hooks_dir=$work_home/.git/hooks
	echo $QDkE_ROOT
	echo $work_home
	echo "$template_prefix"
	echo "$dst_hooks_dir"
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
}

utils_git_check() {
	global_email=$(git config --global user.email)
	global_name=$(git config --global user.name)
	repository_email=$(git config user.email)
	repository_name=$(git config user.name)
	if [ -z "$repository_email" ] || [ -z "$repository_name" ] || [ -n "$global_email" ] || [ -n "$global_name" ]; then
	# user.email is empty
	echo "ERROR: [pre-commit hook] Aborting commit because user.email or user.name is missing. Configure them for this repository. Make sure not to configure globally."
	exit 1
	else
	# user.email is not empty
	exit 0
	fi 
}

_utils_git_init
echo 123-$QDkE_ROOT
work_home=$QDkE_ROOT && utils_git_set
exit 0
# utils_git_check

