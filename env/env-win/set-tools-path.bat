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
:-------------------------------------
:-------------------------------------
:: Microsoft Windows SDK
:: -----------------------------------
call %~dp0set-env-msvc.bat
echo [QDKe] - We Are Finishing settting MSVS and MSSDK Env.
:-------------------------------------


:-------------------------------------
:: Microsoft SQL Server
:-------------------------------------
set "MSSQL_ROOT=%QDKE_C_PGM_FILES_DIR%/Microsoft SQL Server/100"
set "MSSQL_TOOLS_ROOT=%MSSQL_ROOT%/Tools/Binn"
set "MSSQL_DTS_ROOT=%MSSQL_ROOT%/DTS/Binn"
:-------------------------------------
:: MySQL
:-------------------------------------
set "MYSQL_MSI_ROOT=%QDKE_XP_C_PGM_FILES_DIR%/MySQL"
set "MYSQL56_SERVER_ROOT=%MYSQL_MSI_ROOT%/MySQL Server 5.6"
set "MYSQL57_SERVER_ROOT=%MYSQL_MSI_ROOT%/MySQL Server 5.7"

set "MYSQL_UTILITIES_ROOT=%MYSQL_MSI_ROOT%/MySQL Fabric 1.5.4 & MySQL Utilities 1.5.4 1.5"
set "MYSQL_UTILITIES_EXT_ROOT=%MYSQL57_UTILITIES_ROOT%/Doctrine extensions for PHP

set "MYSQL_SERVER_ROOT=!MYSQL57_SERVER_ROOT!"
if "x!QDKe_VAR_IS_XP!" == "xtrue" (
  set "MYSQL_SERVER_ROOT=!MYSQL56_SERVER_ROOT!"
)
:-------------------------------------
:: JAVA
:-------------------------------------
set "JDK16_VER=1.6"
set "JDK17_VER=1.7"
set "JDK18_VER=1.8.0_45"
if "x!QDKe_VAR_IS_XP!" == "xtrue" (
  set "JDK18_VER=1.8.0_45"
)
set "JDK_VER=!JDK18_VER!"

rem set "JRE_HOME=!JAVA_ROOT!/jre"
set "JRE_HOME=!QDK_ROOT!/Java/jre!JDK_VER!"
set "JAVA_HOME=!QDK_ROOT!/Java/jdk!JDK_VER!"
set "JAVA_ROOT=!JAVA_HOME!"
:-------------------------------------
:: Python
:-------------------------------------
set "PYTHON27_ROOT=%QDK_ROOT%/Python27"
set "PYTHON34_ROOT=%QDK_ROOT%/Python34"

if "x!QDKe_VAR_PYTHON_TYPE!" == "xMiniconda" (
	set "PYTHON27_ROOT=!QDK_ROOT!/Miniconda"
	set "PYTHON34_ROOT=!QDK_ROOT!/Miniconda3"
)

set "PYTHON_ROOT=%PYTHON27_ROOT%"
if x%QDKe_VAR_PYTHON_VER% == "x27" set "PYTHON_ROOT=%PYTHON27_ROOT%"
if x%QDKe_VAR_PYTHON_VER% == "x34" set "PYTHON_ROOT=%PYTHON34_ROOT%"
:-------------------------------------
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