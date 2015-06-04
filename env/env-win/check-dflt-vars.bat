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
if "x%INCLUDE_CHECK_DFLT_VARS_BATCH%" == "xtrue" (
	goto :EOF
)
:----------------RUN-ONCE----------------

:: Checking and Setting dflt-vars
:----------------------------------------

:: Default setting to true
:----------------------------------------
if "!QDKe_VAR_MSYS2!" == "" (
	set QDKe_VAR_MSYS2=true
)

:----------------------------------------
:: Default setting to MINGW32(x32) and MINGW64(x64)
:: MSYS MINGW32 MINGW64
:----------------------------------------
if "!MSYSTEM!" == "" (
	if "!QDKe_VAR_xCMD!" == "x32" (
		set MSYSTEM=MINGW32
	) else (
		set MSYSTEM=MINGW64
	)
	set MSYSCON=mintty.exe
)

:----------------------------------------
:: Default setting to false
:----------------------------------------
if "!QDKe_VAR_INCLUDED_MINGW!" == "" (
	set QDKe_VAR_INCLUDED_MINGW=false
)

:----------------------------------------
:: Default setting to false
:----------------------------------------
if "!QDKe_VAR_UAC!" == "" (
	set QDKe_VAR_UAC=false
)

:----------------------------------------
:: Default setting to VXPSP2(WINXP) or V71(WIN7)
:----------------------------------------
if "x%QDKe_VAR_MSSDK_VER%" == "x" (
	set QDKe_VAR_MSSDK_VER=V71
	if "x!QDKe_VAR_IS_XP!" == "xtrue" set QDKe_VAR_MSSDK_VER=VXPSP2
)
:----------------------------------------
:: Default setting to 2010(WINXP) or 2013(WIN7)
:----------------------------------------
if "!QDKe_VAR_MSVS_VER_YEAR!" == "" (
	set QDKe_VAR_MSVS_VER_YEAR=2013
	if "x%QDKe_VAR_IS_XP%" == "xtrue" set QDKe_VAR_MSVS_VER_YEAR=2010
)

:----------------------------------------
:: Default setting to 27
:----------------------------------------
if "!QDKe_VAR_PYTHON_VER!" == "" (
	set QDKe_VAR_PYTHON_VER=27
)
if "!QDKe_VAR_PYTHON_TYPE!" == "" (
	set QDKe_VAR_PYTHON_TYPE=Miniconda
)

:----------------RUN-ONCE----------------
set INCLUDE_CHECK_DFLT_VARS_BATCH=true
:EOF
:----------------RUN-ONCE----------------