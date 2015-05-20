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

rem uncomment following sentence, output debug info to be enabled separately
rem set QDKe_VAR_DEBUG_%~n0=true
if "x!QDKe_VAR_DEBUG_%~n0!" == "xtrue" (
	set decho=echo
) else (
	set decho=rem
)

:: Checking dirs exist
:-------------------------------------

rem FOR /para %%I        IN (Command1)    DO Command2
rem FOR /para %%Variable IN (Set)         DO Command [Command-Parameters]
rem FOR /para %%Variable IN (Set)         DO Command [Command-Parameters]
rem Command1 support wildcard character: 
rem ? - a any character
rem * - all the characters

rem %1 %2 %3 %4 %5 %6 %7 %8 %9 %10 %11 %12 %13"
%decho% %~n0 check in args  list: %*

call %QDKE_ENV%/env-win/check-call-args.bat %*

%decho% %~n0 checked args number: %ret%
%decho% %~n0 checked args   list: %args%

rem for %%I in (i,love,you,the world) do echo %%I

FOR %%I IN (%args%) DO (
	set var=%%I
	rem %decho% !var!
	if not exist !var! (
		mkdir !var! >nul 2>&1
	)
)

:-------------------------------------

:EOF