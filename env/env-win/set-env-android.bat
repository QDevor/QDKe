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
if "x%INCLUDE_SET_ENV_ANDROID_BATCH%" == "xtrue" (
	goto :EOF
)
:----------------RUN-ONCE----------------
:----------------------------------------
:: Android Toolchains
:----------------------------------------
set "ANDROID_ROOT=!QDK_ROOT!/Android"
:----------------------------------------
:: Android Studio Tool
:----------------------------------------
set "ANDROID_STUDIO_HOME=%ANDROID_ROOT%/android-studio"
:----------------------------------------
:: Android NDK Toolchains
:----------------------------------------
set "ANDROID_NDK_ROOT=%ANDROID_ROOT%/android-ndk"
set "ANDROID_NDK_TOOLCHAINS_ROOT=!ANDROID_NDK_ROOT!/toolchains/arm-linux-androideabi-4.8/prebuilt/windows"
:----------------------------------------
:: Android SDK Toolchains
:----------------------------------------
set "ANDROID_SDK_ROOT=%ANDROID_ROOT%/android-sdk"
set "ANDROID_SDK_TOOLCHAINS_ROOT=!ANDROID_SDK_ROOT!/tools"
set "ANDROID_SDK_BUILD_TOOLS_ROOT=!ANDROID_SDK_ROOT!/build-tools"
set "ANDROID_SDK_PLATFORM_TOOLS_ROOT=!ANDROID_SDK_ROOT!/platform-tools"
	
set "ANDROID_HOME=!ANDROID_SDK_ROOT!"

set "ANDROID_SDK_BUILD_TOOLS_VER=21.1.1"
set "ANDROID_SDK_BUILD_TOOLS_VER=21.1.2"
:----------------------------------------
:: Ant Tool
:----------------------------------------
set "ANT_ROOT=%ANDROID_ROOT%/apache-ant"
set "ANT_HOME=!ANT_ROOT!/ant"
:----------------------------------------
:: Gradle Tool
:----------------------------------------
set "GRADLE_ROOT=%ANDROID_ROOT%/gradle"
set "GRADLE_HOME=!GRADLE_ROOT!/gradle"
set "GRADLE_USER_HOME=!GRADLE_ROOT!/cache"
:----------------------------------------
:: Maven Tool
:----------------------------------------
set "M2_ROOT=%ANDROID_ROOT%/apache-maven"
set "M2_HOME=!M2_ROOT!/maven"
:----------------------------------------

set "PATH=!ANDROID_NDK_ROOT!;!PATH!"
set "PATH=!ANDROID_NDK_TOOLCHAINS_ROOT!;!PATH!"

set "PATH=!ANDROID_SDK_ROOT!;!PATH!"
set "PATH=!ANDROID_SDK_TOOLCHAINS_ROOT!;!PATH!"
set "PATH=!ANDROID_SDK_BUILD_TOOLS_ROOT!;!PATH!"
set "PATH=!ANDROID_SDK_PLATFORM_TOOLS_ROOT!;!PATH!"

set "PATH=!ANT_HOME!;!PATH!"
set "PATH=!GRADLE_HOME!;!PATH!"
set "PATH=!M2_HOME!;!PATH!"
:----------------RUN-ONCE----------------
set INCLUDE_SET_ENV_ANDROID_BATCH=true
:EOF
:----------------RUN-ONCE----------------