rem.
rem            Copyright (C) 2015 QDevor
rem.
rem  Licensed under the GNU General Public License, Version 3.0 (the License);
rem  you may not use this file except in compliance with the License.
rem  You may obtain a copy of the License at
rem.
rem            http://www.gnu.org/licenses/gpl-3.0.html
rem.
rem Unless required by applicable law or agreed to in writing, software
rem distributed under the License is distributed on an AS IS BASIS,
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem See the License for the specific language governing permissions and
rem limitations under the License.
rem.

:----------------RUN-ONCE----------------
if "x%INCLUDE_SET_LAST_VARS_BATCH%" == "xtrue" (
	goto :EOF
)
:----------------RUN-ONCE----------------

:: Setting last-vars
:----------------------------------------
set "QDK_STAMPDIR=%MSYS_ROOT%/var/ready_qdk"
set "_win_QDK_STAMPDIR=%QDK_STAMPDIR%"
set "_win_QDK_STAMPDIR=!_win_QDK_STAMPDIR:/=\!"
if not exist %_win_QDK_STAMPDIR% mkdir %_win_QDK_STAMPDIR% >nul 2>&1
:----------------------------------------
:: ready python
:----------------------------------------
set "PYTHONPATH=%LIBPATH%"
set "PATH=%PATH%;%LIBPATH%"

set DISTUTILS_USE_SDK=1
set "QDKe_PYSP_PATH=!PYTHON_ROOT!/Lib/site-packages"
set HDF5_DIR=%PYTHON_ROOT%/Library
:----------------------------------------
:: OCAML
:----------------------------------------
set "QDKE_CFG_PATH=!MINGW_ROOT!"
set "PKG_CONFIG_PATH=!QDKE_CFG_PATH!/lib/pkgconfig"
rem set "OCAMLFIND_CONF=!QDKE_CFG_PATH!/etc/findlib.conf"
rem This variable overrides the location of the configuration file findlib.conf. It must contain the absolute path name of this file.
goto :LABEL_SKIP_SET_OCAML_ENV
echo [debug] [WIN] Setting Ocamlfind ENv.
rem set "OCAMLPATH=!QDKE_CFG_PATH!/lib/ocaml"
rem This variable may contain an additional search path for package directories. It is treated as if the directories were prepended to the configuration variable path.
rem set "OCAMLFIND_DESTDIR=!OCAMLPATH!"
rem This variable overrides the configuration variable destdir.
rem set "OCAMLFIND_METADIR=!OCAMLPATH!"
rem This variable overrides the configuration variable metadir.
rem set "OCAMLFIND_COMMANDS=!QDKE_CFG_PATH!/bin"
rem This variable overrides the configuration variables ocamlc, ocamlopt, ocamlcp, ocamlmktop, ocamldoc, ocamldep, and/or ocamlbrowser.
set "CAMLLIB=!QDKE_CFG_PATH!/lib/ocaml"
set "OCAMLLIB=!QDKE_CFG_PATH!/lib/ocaml"
rem This variable overrides the configuration variable stdlib.
set "OCAMLFIND_LDCONF=!QDKE_CFG_PATH!/lib/ocaml"
rem This variable overrides the configuration variable ldconf.
rem set "OCAMLFIND_IGNORE_DUPS_IN=!OCAMLPATH!"
rem This variable instructs findlib not to emit warnings that packages or module occur several times. 
rem The variable must be set to the directory where the packages reside that are to be ignored for this warning.
:LABEL_SKIP_SET_OCAML_ENV
:----------------------------------------
:: SSL
:----------------------------------------
:----------------RUN-ONCE----------------
set INCLUDE_SET_LAST_VARS_BATCH=true
:EOF
:----------------RUN-ONCE----------------