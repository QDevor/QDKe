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
if "x%INCLUDE_CLEAR_DFLT_VARS_BATCH%" == "xtrue" (
	goto :EOF
)
:----------------RUN-ONCE----------------

:----------------------------------------
:: Clear INCLUDE, LIB, LIBPATH Variable and resetting
:----------------------------------------
set "INCLUDE="
set "LIB="
set "LIBPATH="
:----------------------------------------
:: Clear PATH Variable and resetting
:----------------------------------------

set "ORIGINAL_PATH=%PATH%"
set "PATH="

:: Add WINDOWS PATH...
set "PATH=C:/WINDOWS/system32;C:/WINDOWS;C:/WINDOWS/System32/Wbem"
:----------------------------------------

:----------------RUN-ONCE----------------
set INCLUDE_CLEAR_DFLT_VARS_BATCH=true
:EOF
:----------------RUN-ONCE----------------