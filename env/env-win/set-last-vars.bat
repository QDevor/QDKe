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
:: SSL
:----------------------------------------

:----------------RUN-ONCE----------------
set INCLUDE_SET_LAST_VARS_BATCH=true
:EOF
:----------------RUN-ONCE----------------