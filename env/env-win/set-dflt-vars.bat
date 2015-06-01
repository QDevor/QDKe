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
if "x%INCLUDE_SET_DFLT_VARS_BATCH%" == "xtrue" (
	goto :EOF
)
:----------------RUN-ONCE----------------

:: Setting dflt-vars
:----------------------------------------
if "x%QDKe_VAR_DEBUG%" == "x" (
	set QDKe_VAR_DEBUG=false
) else (
	set QDKe_VAR_DEBUG=true
	echo [QDKe] - We Are Running on debug mode.
)
:----------------------------------------
rem Default setting to i686(XP) and x86_64(WIN7)
rem i686 x86_64
rem set QDKe_VAR_BUILD_ARCH=i686
:----------------------------------------
rem Default setting to static
rem static shared
rem set QDKe_VAR_BUILD_LIBTYPE=shared
:----------------------------------------
rem Default setting to MINGW32(XP) and MINGW64(WIN7)
rem MSYS MINGW32 MINGW64
rem set to MINGW32 Swtich MinGW to 32bit when On WIN7
rem set MSYSTEM=MSYS
:----------------------------------------
rem Default setting to false
rem set QDKe_VAR_INCLUDED_MINGW=true
:----------------------------------------
rem Default setting to true
rem set QDKe_VAR_MSYS2=false
rem Default setting to false
rem set QDKe_VAR_UAC=true
:----------------------------------------
rem Default setting to VXPSP2(WINXP) or V71(WIN7)
rem set QDKe_VAR_MSSDK_VER=VXPSP2 V60A V70 V70A V71
:----------------------------------------
rem Default setting to 2010(WINXP) or 2013(WIN7)
rem set QDKe_VAR_MSVS_VER_YEAR=None
:----------------------------------------
rem Default setting to 27(WINXP or WIN7)
rem set QDKe_VAR_PYTHON_VER=None

:----------------RUN-ONCE----------------
set INCLUDE_SET_DFLT_VARS_BATCH=true
:EOF
:----------------RUN-ONCE----------------