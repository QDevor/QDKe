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

# Consult How to create a desktop shortcut with the Windows Script Host to see a few examples.
# http://superuser.com/questions/455364/how-to-create-a-shortcut-using-a-batch-script
# 
utils_win_create_desktop_shortcut() {
  RANDOM=`openssl rand -base64 8`
  SCRIPT="$RANDOM-$RANDOM-$RANDOM-$RANDOM.vbs"
  
  shortcut_path=`cygpath -w $1`
  shortcut_path=`echo $shortcut_path | sed -e 's/\\//\\\/g'`
  shortcut_name=`basename $1`
  echo [debug] call_arg=$1
  echo [debug] shortcut_path=$shortcut_path
  echo [debug] shortcut_name=$shortcut_name
  
  echo set WshShell=CreateObject\(\"WScript.Shell\"\) >$SCRIPT
  echo strDesktop = WshShell.SpecialFolders\(\"Desktop\"\) >>$SCRIPT
  echo set oMyShortCut= WshShell.CreateShortcut\(strDesktop+\"\\$shortcut_name.lnk\"\) >>$SCRIPT
#  echo oMyShortCut.WindowStyle = 7  \&\&Minimized 0=Maximized  4=Normal >>$SCRIPT
#  echo oMyShortcut.IconLocation = home\(\)+\"wizards\\graphics\\builder.ico\" >>$SCRIPT
  echo oMyShortCut.TargetPath = \"$shortcut_path\" >>$SCRIPT
#  echo oMyShortCut.Arguments = \'-c\'+\'\"\'+Home\(\)+\'config.fpw\'+\'\"\' >>$SCRIPT
#  echo oMyShortCut.WorkingDirectory = \"c:\\\" >>$SCRIPT
  echo oMyShortCut.Save >>$SCRIPT
  
  echo [debug] cscript //Nologo $SCRIPT
  cscript //Nologo $SCRIPT
  rm $SCRIPT
}

# utils_win_create_desktop_shortcut $@