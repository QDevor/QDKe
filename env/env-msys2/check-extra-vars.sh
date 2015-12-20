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
if [[ x$INCLUDE_CHECK_EXTRA_VARS_SCRIPT == "xtrue" ]]; then
	:
else
#----------------RUN-ONCE----------------

_PGMDIR_CHECK_DFLT_VARS=`dirname $0`
_PGMDIR_CHECK_DFLT_VARS=`cd $_PGMDIR_CHECK_DFLT_VARS && pwd -P`
_FN_CHECK_DFLT_VARS=`basename $0`
_FNTYPE_CHECK_DFLT_VARS=${_FN_CHECK_DFLT_VARS#*.}
_FNNAME_CHECK_DFLT_VARS=${_FN_CHECK_DFLT_VARS%.*}
#----------------------------------------

export MXE_ROOT=$QDKE_HOME/mxe
export MXE_MINGW32_ROOT=$MXE_ROOT/usr/i686-w64-mingw32.static
export MXE_MINGW64_ROOT=$MXE_ROOT/usr/x86_64-w64-mingw32.static
export MXE_MINGW32_SHARED_ROOT=$MXE_ROOT/usr/i686-w64-mingw32.shared
export MXE_MINGW64_SHARED_ROOT=$MXE_ROOT/usr/x86_64-w64-mingw32.shared
#----------------------------------------
export QDKE_CFG_PATH=$MINGW64_ROOT
if [ x$QDKe_VAR_ARCH == xi686 ]; then
export QDKE_CFG_PATH=$MINGW64_ROOT
fi
export PKG_CONFIG_PATH=$QDKE_CFG_PATH/lib/pkgconfig
export OCAMLFIND_CONF=$QDKE_CFG_PATH/etc/findlib.conf
# This variable overrides the location of the configuration file findlib.conf. It must contain the absolute path name of this file.
export OCAMLPATH=$QDKE_CFG_PATH/lib/ocaml
# This variable may contain an additional search path for package directories. It is treated as if the directories were prepended to the configuration variable path.
export OCAMLFIND_DESTDIR=$OCAMLPATH
# This variable overrides the configuration variable destdir.
export OCAMLFIND_METADIR=$OCAMLPATH
# This variable overrides the configuration variable metadir.
# export OCAMLFIND_COMMANDS=$QDKE_CFG_PATH/bin
# This variable overrides the configuration variables ocamlc, ocamlopt, ocamlcp, ocamlmktop, ocamldoc, ocamldep, and/or ocamlbrowser.
export CAMLLIB=$OCAMLPATH
export OCAMLLIB=$OCAMLPATH
# This variable overrides the configuration variable stdlib.
export OCAMLFIND_LDCONF=$OCAMLPATH
# This variable overrides the configuration variable ldconf.
#export OCAMLFIND_IGNORE_DUPS_IN=$OCAMLPATH
# This variable instructs findlib not to emit warnings that packages or module occur several times. 
# The variable must be set to the directory where the packages reside that are to be ignored for this warning.
if [ x$QDKe_VAR_ARCH == xi686 ]; then
export PKG_CONFIG_PATH=$MINGW64_ROOT/lib/pkgconfig
export OCAMLFIND_CONF=$MINGW32_ROOT/etc/findlib.conf
fi
#----------------RUN-ONCE----------------
export INCLUDE_CHECK_EXTRA_VARS_SCRIPT=true
fi
#----------------RUN-ONCE----------------