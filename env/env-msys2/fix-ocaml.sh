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
if [[ x$INCLUDE_FIX_OCAML_SCRIPT == "xtrue" ]]; then
	:
else
#----------------RUN-ONCE----------------

fix_ocaml_findlib_conf() {
  if [ ! -f $QDK_STAMPDIR/$FUNCNAME-stamp ]; then
    #var_file=/mingw32/etc/findlib.conf 
    var_file=$OCAMLFIND_CONF
    #echo var_file=$var_file
    if [ x"$var_file" == x ]; then
      return 0
    fi
    var_path=`cygpath -w $MINGW_ROOT`
    #echo $var_path
    var_path=`echo $var_path | sed -e 's/\\\/\\\\\\\/g'`
    #echo $var_path
    var_path=$var_path\\\\\lib\\\\\ocaml
    #echo $var_path
    
    echo "destdir=\"$var_path\""          >$var_file
    echo "path=\"$var_path\""             >>$var_file
    echo "stdlib=\"$var_path\""           >>$var_file
    echo "ldconf=\"$var_path\\\\ld.conf\""  >>$var_file
    echo "ocamlc=\"ocamlc.opt\""          >>$var_file
    echo "ocamlopt=\"ocamlopt.opt\""      >>$var_file
    echo "ocamldep=\"ocamldep.opt\""      >>$var_file
    echo "ocamldoc=\"ocamldoc.opt\""      >>$var_file
		echo "" >>$var_file
		
		touch $QDK_STAMPDIR/$FUNCNAME-stamp
	#fi
  return 0
}
#----------------------------------------
echo 123
fix_ocaml_findlib_conf
#----------------RUN-ONCE----------------
export INCLUDE_FIX_OCAML_SCRIPT=true
fi
#----------------RUN-ONCE----------------

