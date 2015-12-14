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

echo [debug] Include `basename $0`

# $1 - current dir
# $2 - list current dirs  regular expression
# $3 - list current files regular expression
# return - 'current_dirs="" and current_files=""'
workbench_fn_ls() {
	local_dirname=""
	local_filename=""
	
	for dirname in `ls $1`
  do
    if [ -n $2 ] && [ -d $dirname ]; then
      case $dirname in
        $2) 
          local_dirname="$local_dirname $dirname"
          ;;
        *) 
          continue;;
      esac
    fi
    if [ -n $3 ] && [ -f $dirname ]; then
      case $dirname in
        $3) 
          local_filename="$local_filename $dirname"
          ;;
        *) 
          continue;;
      esac
    fi
  done
  
  return "current_dirs=$local_dirname and current_files=$local_dirname"
}

workbench_fn_ls_dirs() {
  local_retval=workbench_fn_ls $1 $2
  local_retdirs=$(echo $local_retval | sed 's/\(current_dirs=.* and \)\(current_files=.*\)/\2/g' | tr -d '\"')
  return $local_retdirs
}

workbench_fn_ls_files() {
  local_retval=workbench_fn_ls $1 * $2
  local_retfiles=$(echo $local_retval | sed -e 's/\(current_dirs=.*\)\( and current_files=.*\)/\1/g' | tr -d '\"')
  return $local_retfiles
}