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

if "x%INCLUDE_CHECK_DFLT_VARS_BATCH%" == "xtrue" (
	goto :EOF
)

:: Checking and Setting dflt-vars
:-------------------------------------

if "!MSYSTEM!" == "" (
	rem MSYS MINGW32 MINGW64
	if "!QDKe_VAR_IS_XP!" == "true" (
		set MSYSTEM=MINGW32
	) else (
		set MSYSTEM=MINGW64
	)
	set MSYSCON=mintty.exe
)

:-------------------------------------
set INCLUDE_CHECK_DFLT_VARS_BATCH=true
:EOF