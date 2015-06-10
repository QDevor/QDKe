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

if "x%INCLUDE_SET_ENV_MISC_BATCH%" == "xtrue" (
	goto :EOF
)

:: Setting Msic Envirement variables
:-------------------------------------
:: Default settings
:-------------------------------------

:-------------------------------------
:: Golang
:-------------------------------------
set "GOROOT=!QDK_ROOT!/go"
set "GOPATH=!QDKE_HOME!/go_home"
set "PATH=!PATH!;!GOPATH!/bin"
set "PATH=!PATH!;!GOROOT!/bin"
set "PATH=!PATH!;!GOROOT!/pkg/tool/windows_386"
:-------------------------------------

:-------------------------------------
:: Rust
:-------------------------------------
set "RUST_ROOT=!QDK_ROOT!/Rust"
set "PATH=!PATH!;!RUST_ROOT!/bin"
goto :skip_check_version_rust
set version=
set print_version=rust --version
	if not "!errorlevel!"=="9009" (
		set _tolen_counts=0
		for /F "usebackq tokens=1* delims= " %%v in (`!print_version!`) do (
			if !_tolen_counts!==0 (
				set version=%%v%%w
			)
			set /a _tolen_counts=!_tolen_counts!+1
		)
		rem set version=!version:~8,42!
	)
	
	if not "!version!"=="" (
		echo [Checking] - Rust - "!version!."
	) else (
		echo [Checking] - Rust - "!unknown!."
	)
:skip_check_version_rust
:-------------------------------------

:-------------------------------------
set INCLUDE_SET_ENV_MISC_BATCH=true
:EOF