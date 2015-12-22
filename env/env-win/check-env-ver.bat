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

if "x%INCLUDE_CHECK_ENV_VER_BATCH%" == "xtrue" (
	goto :EOF
)

:: Setting Msic Envirement variables
:-------------------------------------
:: Default settings
:-------------------------------------

:-------------------------------------
:: Java
:-------------------------------------
rem goto :skip_check_version_java
set "checkVerPrompt=[Checking] - Java"
set "checkVerPrompt=!checkVerPrompt!!QDKe_VAR_SPACE_30!"
set "checkVerPrompt=!checkVerPrompt:~0,25! -"
set print_version=java -version
set version=
!print_version! >nul 2>&1
	if not "!errorlevel!" == "9009" (
		!print_version! >!TMP!/print_version 2>&1
		set _token_counts=0
		for /F "usebackq tokens=3 delims= " %%v in (!TMP!/print_version) do (
			if !_token_counts! == 0 (
				set version=%%v
			)
			set /a _token_counts=!_token_counts!+1
		)
		set version=!version:"=!
		rem set version=!version:~8,42!
	)
	
	if not "x!version!" == "x" (
		echo !checkVerPrompt! !version!.
	) else (
		echo !checkVerPrompt! !QDKe_VAR_UNKOWN_VERSION!.
	)
:skip_check_version_java
:-------------------------------------

:-------------------------------------
:: Golang
:-------------------------------------
rem goto :skip_check_version_golang
set "checkVerPrompt=[Checking] - Golang"
set "checkVerPrompt=!checkVerPrompt!!QDKe_VAR_SPACE_30!"
set "checkVerPrompt=!checkVerPrompt:~0,25! -"
set print_version=go version
set version=
!print_version! >nul 2>&1
	if not "!errorlevel!" == "9009" (
		set _token_counts=0
		for /F "usebackq tokens=1,2* delims= " %%v in (`!print_version!`) do (
			if !_token_counts! == 0 (
				set version=%%x
			)
			set /a _token_counts=!_token_counts!+1
		)
		rem set version=!version:~8,42!
	)
	
	if not "x!version!" == "x" (
		echo !checkVerPrompt! !version!.
	) else (
		echo !checkVerPrompt! !QDKe_VAR_UNKOWN_VERSION!.
	)
:skip_check_version_golang
:-------------------------------------

:-------------------------------------
:: Rust
:-------------------------------------
rem goto :skip_check_version_rust
set "checkVerPrompt=[Checking] - Rust"
set "checkVerPrompt=!checkVerPrompt!!QDKe_VAR_SPACE_30!"
set "checkVerPrompt=!checkVerPrompt:~0,25! -"
set print_version=rustc --version
set version=
!print_version! >nul 2>&1
	if not "!errorlevel!" == "9009" (
		set _token_counts=0
		for /F "usebackq tokens=1* delims= " %%v in (`!print_version!`) do (
			if !_token_counts! == 0 (
				set version=%%v%%w
			)
			set /a _token_counts=!_token_counts!+1
		)
		rem set version=!version:~8,42!
	)
	
	if not "x!version!" == "x" (
		echo !checkVerPrompt! !version!.
	) else (
		echo !checkVerPrompt! !QDKe_VAR_UNKOWN_VERSION!.
	)
:skip_check_version_rust
:-------------------------------------

:-------------------------------------
set INCLUDE_CHECK_ENV_VER_BATCH=true
:EOF