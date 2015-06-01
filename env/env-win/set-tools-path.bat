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

if "x%INCLUDE_SET_TOOLS_PATH_BATCH%" == "xtrue" (
	goto :EOF
)

:: Setting tools-path variables
:-------------------------------------
:: Default settings
:-------------------------------------
set "QDKE_XP_C_PGM_FILES_DIR=C:/Program Files"
set "QDKE_WIN7_C_PGM_FILES_DIR=C:/Program Files (x86)"
set "QDKE_C_PGM_FILES_DIR=%QDKE_WIN7_C_PGM_FILES_DIR%"
if "x%QDKe_VAR_IS_XP%" == "xtrue" set "QDKE_C_PGM_FILES_DIR=%QDKE_XP_C_PGM_FILES_DIR%"
set "QDKE_XP_D_PGM_FILES_DIR=D:/Program Files"
set "QDKE_WIN7_D_PGM_FILES_DIR=D:/Program Files (x86)"
set QDKE_D_PGM_FILES_DIR=%QDKE_WIN7_D_PGM_FILES_DIR%"
if "x%QDKe_VAR_IS_XP%" == "xtrue" set "QDKE_D_PGM_FILES_DIR=%QDKE_XP_D_PGM_FILES_DIR%"
:-------------------------------------
:: Microsoft Visual Studio
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
:-------------------------------------
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
:-------------------------------------
:: Microsoft SQL Server
:-------------------------------------
set "MSSQL_ROOT=%QDKE_C_PGM_FILES_DIR%/Microsoft SQL Server/100"
set "MSSQL_TOOLS_ROOT=%MSSQL_ROOT%/Tools/Binn"
set "MSSQL_DTS_ROOT=%MSSQL_ROOT%/DTS/Binn"
:-------------------------------------
:: Microsoft Windows SDK
:: -----------------------------------
:: Microsoft Platform SDK for Windows XP SP2
:: 
:: -----------------------------------
:: Microsoft Windows SDK for Windows 7 and .NET Framework 4 (ISO)
:: Windows SDK 7.1 do not support version up to Microsoft Visual C++ 2010 x86 Redistributable - 10.0.30319
:: https://www.microsoft.com/en-us/download/details.aspx?id=8442
:: GRMSDK_EN_DVD.iso is a version for x86 environment.
:: GRMSDKX_EN_DVD.iso is a version for x64 environment.
:: GRMSDKIAI_EN_DVD.iso is a version for Itanium environment.
:: http://download.microsoft.com/download/F/1/0/F10113F5-B750-4969-A255-274341AC6BCE/GRMSDKX_EN_DVD.iso
:: windows 7 - What SDK version to download?
:: http://stackoverflow.com/questions/20115186/what-sdk-version-to-download
:: -----------------------------------
:-------------------------------------
set "MSSDK_VXPSP2_ROOT=%QDKE_XP_C_PGM_FILES_DIR%/Microsoft Platform SDK for Windows XP SP2"
set "MSSDK_V60A_ROOT=%QDKE_XP_C_PGM_FILES_DIR%/Microsoft SDKs/Windows/v6.0A"
set "MSSDK_V70_ROOT=%QDKE_XP_C_PGM_FILES_DIR%/Microsoft SDKs/Windows/v7.0"
set "MSSDK_V70A_ROOT=%QDKE_XP_C_PGM_FILES_DIR%/Microsoft SDKs/Windows/v7.0A"
set "MSSDK_V71_ROOT=%QDKE_XP_C_PGM_FILES_DIR%/Microsoft SDKs/Windows/v7.1"

if "x%QDKe_VAR_IS_XP%" == "xtrue" set "MSSDK_ROOT=!MSSDK_VXPSP2_ROOT!" && goto :skip_set_tools_path_mssdk
if exist "!MSSDK_V71_ROOT!" set "MSSDK_ROOT=!MSSDK_V71_ROOT!" && goto :skip_set_tools_path_mssdk
if exist "!MSSDK_V70_ROOT!" set "MSSDK_ROOT=!MSSDK_V70_ROOT!" && goto :skip_set_tools_path_mssdk
if exist "!MSSDK_V70A_ROOT!" set "MSSDK_ROOT=!MSSDK_V70A_ROOT!" && goto :skip_set_tools_path_mssdk
if exist "!MSSDK_V60A_ROOT!" set "MSSDK_ROOT=!MSSDK_V60A_ROOT!" && goto :skip_set_tools_path_mssdk
if "x%QDKe_VAR_IS_XP%" != "xtrue" goto :skip_set_tools_path_mssdk
if exist "!MSSDK_VXPSP2_ROOT!" set "MSSDK_ROOT=!MSSDK_VXPSP2_ROOT!" && goto :skip_set_tools_path_mssdk
:skip_set_tools_path_mssdk
:-------------------------------------
:: MySQL
:-------------------------------------
set "MYSQL_ROOT=%QDKE_C_PGM_FILES_DIR%/MySQL"
set "MYSQL_SERVER_ROOT=%MYSQL_ROOT%/MySQL Server 5.6"
set "MYSQL_UTILITIES_ROOT=%MYSQL_ROOT%/MySQL Fabric 1.5.4 & MySQL Utilities 1.5.4 1.5"
set "MYSQL_UTILITIES_EXT_ROOT=%MYSQL_UTILITIES_ROOT%/Doctrine extensions for PHP

set "MYSQL_QDK_ROOT=%QDK_ROOT%/mysql"
:-------------------------------------
:: JAVA
:-------------------------------------
set "JAVA_ROOT=D:/cygwin/opt/Java"
set "JAVA6_ROOT=%JAVA_ROOT%"
set "JAVA6_HOME=!JAVA6_ROOT!/jdk6"
set "JRE6_HOME=!JAVA6_ROOT!/jre6"

set "JAVA7_ROOT=%JAVA_ROOT%"
set "JAVA7_HOME=!JAVA7_ROOT!/jdk7"
set "JRE7_HOME=!JAVA7_ROOT!/jre7"

:: Android Toolchains
:-------------------------------------
set "ANDROID_ROOT=D:/Android"
:------------------------
:: Android Studio Tool
:------------------------
set "ANDROID_STUDIO_HOME=%ANDROID_ROOT%/android-studio"
:------------------------
:: Android NDK Toolchains
:------------------------
set "ANDROID_NDK_ROOT=%ANDROID_ROOT%/android-ndk"
set "ANDROID_NDK_TOOLCHAINS_ROOT=!ANDROID_NDK_ROOT!/toolchains/arm-linux-androideabi-4.8/prebuilt/windows"
:------------------------
:: Android SDK Toolchains
:------------------------
set "ANDROID_SDK_ROOT=%ANDROID_ROOT%/android-sdk"
set "ANDROID_SDK_TOOLCHAINS_ROOT=!ANDROID_SDK_ROOT!/tools"
set "ANDROID_SDK_BUILD_TOOLS_ROOT=!ANDROID_SDK_ROOT!/build-tools"
set "ANDROID_SDK_PLATFORM_TOOLS_ROOT=!ANDROID_SDK_ROOT!/platform-tools"
	
set "ANDROID_HOME=!ANDROID_SDK_ROOT!"

set "ANDROID_SDK_BUILD_TOOLS_VER=21.1.1"
set "ANDROID_SDK_BUILD_TOOLS_VER=21.1.2"
:------------------------
:: Ant Tool
:------------------------
set "ANT_ROOT=%ANDROID_ROOT%/apache-ant"
set "ANT_HOME=!ANT_ROOT!/ant"
:------------------------
:: Gradle Tool
:------------------------
set "GRADLE_ROOT=%ANDROID_ROOT%/gradle"
set "GRADLE_HOME=!GRADLE_ROOT!/gradle"
set "GRADLE_USER_HOME=!GRADLE_ROOT!/cache"
:------------------------
:: Maven Tool
:------------------------
set "M2_ROOT=%ANDROID_ROOT%/apache-maven"
set "M2_HOME=!M2_ROOT!/maven"
:------------------------

:-------------------------------------
set INCLUDE_SET_TOOLS_PATH_BATCH=true
:EOF