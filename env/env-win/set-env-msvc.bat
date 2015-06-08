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
if "x%INCLUDE_SET_ENV_MSVC_BATCH%" == "xtrue" (
	goto :EOF
)
:----------------RUN-ONCE----------------
:----------------------------------------
if "x!QDKE_C_PGM_FILES_DIR!" == "x" (
	echo [QDKe] - [Error] - We Are Checking QDKE_C_PGM_FILES_DIR is not setting.
	goto :EOF
)
if "x!QDKE_D_PGM_FILES_DIR!" == "x" (
	echo [QDKe] - [Error] - We Are Checking QDKE_D_PGM_FILES_DIR is not setting.
	goto :EOF
)
:----------------------------------------
set "QDKe_VAR_MSSDK_VER="
set "QDKe_VAR_MSVS_VER_YEAR="
if "x!QDKe_VAR_FORCE_MSVS_VER_YEAR!" == "x" (
  goto :skip_check_qdke_var_msvs_ver_year
)
if "x!QDKe_VAR_FORCE_MSVS_VER_YEAR!" == "xNone" (
  goto :skip_check_qdke_var_msvs_ver_year
)
set "QDKe_VAR_MSVS_VER_YEAR=!QDKe_VAR_FORCE_MSVS_VER_YEAR!"
:skip_check_qdke_var_msvs_ver_year
:----------------------------------------
if "x!QDKe_VAR_MSVS_VER_YEAR!" == "x" (
  if "x!QDKe_VAR_xCMD!" == "xx32" (
    if "x!QDKe_VAR_IS_XP!" == "xtrue" (
      set "QDKe_VAR_MSVS_VER_YEAR=2008"
    ) else (
      set "QDKe_VAR_MSVS_VER_YEAR=2010"
    )
  ) else (
    if "x!QDKe_VAR_IS_XP!" == "xtrue" (
      echo [QDKe] - We Are Checking Error on XP run the specified  MSVS x64 type.
    ) else (
      set "QDKe_VAR_MSVS_VER_YEAR=2010"
    )
  )
)
:----------------------------------------
:: Microsoft Windows XP - v6.0A - v7.0A - 32bit
::                      - v6.1  - v7.1  - 64bit
if "x!QDKe_VAR_MSSDK_VER!" == "x" (
	if "x!QDKe_VAR_MSVS_VER_YEAR!" == "x2008" (
		set "QDKe_VAR_MSSDK_VER=V60A"
		if "x!QDKe_VAR_xCMD!" == "xx64" (
			set "QDKe_VAR_MSSDK_VER=V61"
		)
		goto :prompt_set_qdke_var_mssdk_ver
	)
	if "x!QDKe_VAR_MSVS_VER_YEAR!" == "x2010" (
		set "QDKe_VAR_MSSDK_VER=V70A"
		if "x!QDKe_VAR_xCMD!" == "xx64" (
			set "QDKe_VAR_MSSDK_VER=V71"
		)
		goto :prompt_set_qdke_var_mssdk_ver
	)
	rem Setting environment for using Microsoft Visual Studio 2008 x86 tools.
	echo [QDKe] - We Are Missing the specified  MSVS configuration type.
	goto :skip_set_qdke_var_mssdk_ver
)
:prompt_set_qdke_var_mssdk_ver
echo [QDKe] - We Are Setting environment for using Microsoft Visual Studio !QDKe_VAR_MSVS_VER_YEAR! !QDKe_VAR_MSVC_ARCH! tools.
echo [QDKe] - We Are Setting environment for using Microsoft Windows SDK !QDKe_VAR_MSSDK_VER! tools.
:skip_set_qdke_var_mssdk_ver
:----------------------------------------
:: Microsoft Visual Studio
:: --------------------------------------
:: Microsoft Visual Studio 2008 Service Pack 1
:: https://www.microsoft.com/en-us/download/details.aspx?id=10986
:: 
:: You must at least run the Visual Studio GUI once
:: 
:: http://matthew-brett.github.io/pydagogue/python_msvc.html
:: 
:: VC++ version	_MSC_VER	Alternative name
:: Version 1.0	800	 
:: Version 2.0	900	 
:: Version 2.x	900	 
:: Version 4.0	1000	 
:: Version 5.0	1100	 
:: Version 6.0	1200	 
:: Version 7.0	1300	Visual Studio 2002
:: Version 7.1	1310	Visual Studio 2003
:: Version 8.0	1400	Visual Studio 2005
:: Version 9.0	1500	Visual Studio 2008
:: Version 10.0	1600	Visual Studio 2010
:: Version 11.0	1700	Visual Studio 2012
:: Version 12.0	1800	Visual Studio 2013
:----------------------------------------
:: Microsoft Windows SDK
:: --------------------------------------
:: Microsoft Platform SDK for Windows XP SP2
:: 
:: --------------------------------------
:: Microsoft Visual Studio 2008 compiler with Microsoft Platform SDK (v6.1)
:: NOTE: You will need to install Platform SDK 6.1 to get 64-bit libraries.
:: --------------------------------------
:: Microsoft Windows SDK for Windows 7 and .NET Framework 4 (ISO)
:: Windows SDK 7.1 do not support version up to Microsoft Visual C++ 2010 x86 Redistributable - 10.0.30319
:: https://www.microsoft.com/en-us/download/details.aspx?id=8442
:: GRMSDK_EN_DVD.iso is a version for x86 environment.
:: GRMSDKX_EN_DVD.iso is a version for x64 environment.
:: GRMSDKIAI_EN_DVD.iso is a version for Itanium environment.
:: http://download.microsoft.com/download/F/1/0/F10113F5-B750-4969-A255-274341AC6BCE/GRMSDKX_EN_DVD.iso
:: windows 7 - What SDK version to download?
:: http://stackoverflow.com/questions/20115186/what-sdk-version-to-download
:: --------------------------------------
:------------------MSVS------------------
set "MSVS_2005_ROOT=%QDKE_C_PGM_FILES_DIR%/Microsoft Visual Studio 8.0"
set "MSVS_2008_ROOT=%QDKE_C_PGM_FILES_DIR%/Microsoft Visual Studio 9.0"
set "MSVS_2010_ROOT=%QDKE_C_PGM_FILES_DIR%/Microsoft Visual Studio 10.0"
set "MSVS_2012_ROOT=%QDKE_C_PGM_FILES_DIR%/Microsoft Visual Studio 11.0"
set "MSVS_2013_ROOT=%QDKE_C_PGM_FILES_DIR%/Microsoft Visual Studio 12.0"

set "MSVS_2005_VC_ROOT=%MSVS_2005_ROOT%/VC"
set "MSVS_2008_VC_ROOT=%MSVS_2008_ROOT%/VC"
set "MSVS_2010_VC_ROOT=%MSVS_2010_ROOT%/VC"
set "MSVS_2013_VC_ROOT=%MSVS_2013_ROOT%/VC"

set VS80COMNTOOLS=!MSVS_2005_ROOT!/Common7/Tools/
set VS90COMNTOOLS=!MSVS_2008_ROOT!/Common7/Tools/
set VS100COMNTOOLS=!MSVS_2010_ROOT!/Common7/Tools/

set "MSVS_ROOT=!MSVS_%QDKe_VAR_MSVS_VER_YEAR%_ROOT!"
set "MSVS_VC_ROOT=!MSVS_%QDKe_VAR_MSVS_VER_YEAR%_VC_ROOT!"
:------------------MSVS------------------
:------------------MSSDK-----------------
:: Microsoft Windows XP - v6.0A - v7.0A - 32bit
::                      - v6.1  - v7.1  - 64bit
set "MSSDK_VXPSP2_ROOT=%QDKE_XP_C_PGM_FILES_DIR%/Microsoft Platform SDK for Windows XP SP2"
set "MSSDK_V60A_ROOT=%QDKE_XP_C_PGM_FILES_DIR%/Microsoft SDKs/Windows/v6.0A"
set "MSSDK_V70_ROOT=%QDKE_XP_C_PGM_FILES_DIR%/Microsoft SDKs/Windows/v7.0"
set "MSSDK_V70A_ROOT=%QDKE_XP_C_PGM_FILES_DIR%/Microsoft SDKs/Windows/v7.0A"
set "MSSDK_V71_ROOT=%QDKE_XP_C_PGM_FILES_DIR%/Microsoft SDKs/Windows/v7.1"

set "MSSDK_ROOT=!MSSDK_%QDKe_VAR_MSSDK_VER%_ROOT!"
:------------------MSSDK-----------------
:------------------NETFX-----------------
set "MSNETFX_ROOT=C:/WINDOWS/Microsoft.NET/Framework
set "MSNETFX64_ROOT=C:/WINDOWS/Microsoft.NET/Framework64
:------------------NETFX-----------------
:----------------------------------------
:: Besides that, the following environment variables can also be set (but are not required):
:----------------------------------------
if "x!QDKe_VAR_xCMD!" == "xx32" (
	set "DevEnvDir=!MSVS_ROOT!/Common7/IDE"
	set "Framework35Version=v3.5"
	set "FrameworkDir=!MSNETFX_ROOT!"
	set "FrameworkVersion=v2.0.50727"
	set "VCINSTALLDIR=!MSVS_ROOT!/VC"
	rem set "VS90COMNTOOLS=!MSVS_ROOT!/Common7/Tools"
	set "VSINSTALLDIR=!MSVS_ROOT!"
	set "WindowsSdkDir=!MSSDK_ROOT!"
	set "MSSdk=!MSSDK_ROOT!"
)

if "x!QDKe_VAR_xCMD!" == "xx64" (
	set "FxTools=!MSNETFX64_ROOT!/v3.5;!MSNETFX_ROOT!/v3.5;!MSNETFX64_ROOT!/v2.0.50727;!MSNETFX_ROOT!/v2.0.50727"
	set "SdkTools=!MSSDK_ROOT!/Bin/x64;!MSSDK_ROOT!/Bin"
	set "VCINSTALLDIR=!MSVS_ROOT!"
	set "VCRoot=!MSVS_ROOT!"
	rem set "VS90COMNTOOLS=!MSVS_ROOT!/Common7/Tools"
	set "VSRegKeyPath=HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\SxS\VS7"
)

:----------------------------------------
if "x!QDKe_VAR_xCMD!" == "xx32" (
	set "INCLUDE=!INCLUDE!;!MSVS_VC_ROOT!/ATLMFC/include"
	set "INCLUDE=!INCLUDE!;!MSVS_VC_ROOT!/include"
	set "INCLUDE=!INCLUDE!;!MSSDK_ROOT!/include"
	
	set "LIB=!LIB!;!MSVS_VC_ROOT!/ATLMFC/lib"
	set "LIB=!LIB!;!MSVS_VC_ROOT!/lib"
	set "LIB=!LIB!;!MSSDK_ROOT!/lib"
	
	set "LIBPATH=!LIBPATH!;!MSNETFX_ROOT!/v3.5"
	set "LIBPATH=!LIBPATH!;!MSNETFX_ROOT!/v2.0.50727"
	set "LIBPATH=!LIBPATH!;!MSVS_VC_ROOT!/ATLMFC/lib"
	set "LIBPATH=!LIBPATH!;!MSVS_VC_ROOT!/lib"
	
	set "PATH=!PATH!;!MSVS_ROOT!/Common7/IDE"
	set "PATH=!PATH!;!MSVS_VC_ROOT!/bin"
	set "PATH=!PATH!;!MSNETFX_ROOT!/v3.5"
	set "PATH=!PATH!;!MSNETFX_ROOT!/v2.0.50727"
	set "PATH=!PATH!;!MSVS_VC_ROOT!/VCPackages"
	set "PATH=!PATH!;!MSSDK_ROOT!/bin"
)

rem amd64 ia64
rem x86_amd64 x86_ia64
set "QDKe_VAR_MSVS_TOOL_ARCH=x86_amd64"

if "x!QDKe_VAR_xCMD!" == "xx64" (
	set "INCLUDE=!INCLUDE!;!MSVS_VC_ROOT!/include"
	set "INCLUDE=!INCLUDE!;!QDKE_C_PGM_FILES_DIR!/VC/include"
	set "INCLUDE=!INCLUDE!;!MSSDK_ROOT!/include"
	set "INCLUDE=!INCLUDE!;!MSSDK_ROOT!/include/gl"
	
	set "LIB=!LIB!;!MSVS_VC_ROOT!/Lib/amd64"
	rem set "LIB=!LIB!;!MSVS_VC_ROOT!/lib"
	set "LIB=!LIB!;!MSSDK_ROOT!/Lib/x64"
	
	set "LIBPATH=!LIBPATH!;!MSNETFX64_ROOT!/v3.5"
	set "LIBPATH=!LIBPATH!;!MSNETFX_ROOT!/v3.5"
	set "LIBPATH=!LIBPATH!;!MSNETFX64_ROOT!/v2.0.50727"
	set "LIBPATH=!LIBPATH!;!MSNETFX_ROOT!/v2.0.50727"

	set "PATH=!PATH!;!MSVS_VC_ROOT!/bin/amd64"
	set "PATH=!PATH!;!MSVS_VC_ROOT!/VCPackages"
	set "PATH=!PATH!;!MSVS_ROOT!/Common7/IDE"
	set "PATH=!PATH!;!MSSDK_ROOT!/bin/x64"
	set "PATH=!PATH!;!MSSDK_ROOT!/bin"
	set "PATH=!PATH!;!MSNETFX64_ROOT!/v3.5"
	set "PATH=!PATH!;!MSNETFX_ROOT!/v3.5"
	set "PATH=!PATH!;!MSNETFX64_ROOT!/v2.0.50727"
	set "PATH=!PATH!;!MSNETFX_ROOT!/v2.0.50727"
)
:----------------------------------------

:----------------RUN-ONCE----------------
set INCLUDE_SET_ENV_MSVC_BATCH=true
:EOF
:----------------RUN-ONCE----------------