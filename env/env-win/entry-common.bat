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

if "x%INCLUDE_ENTRY_COMMON_BATCH%" == "xtrue" (
	goto :EOF
)

:: Common entry of call QDKe batches
:-------------------------------------

call %~dp0set-dflt-vars.bat
call %~dp0set-dflt-dirs.bat

call %~dp0check-win-ver.bat
call %~dp0check-cpu-info.bat
call %~dp0check-dflt-vars.bat

call %~dp0set-tools-path.bat
call %~dp0add-tools-path.bat
call %~dp0set-msys2-path.bat

:-------------------------------------
set INCLUDE_ENTRY_COMMON_BATCH=true
:EOF