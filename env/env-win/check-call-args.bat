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

:: Checking call args
:-------------------------------------
rem args support: %0 - %9, more args needed use SHIFT
rem %0 - the batch file name
rem %1-%9 - call args 0f the batch

rem %~1  expanding %1 to remove any quotation marks ("")
rem %~f1 expanding %1 to the fully qualified path name
rem %~d1 expanding %1 to the drive letter
rem %~p1 expanding %1 to the path
rem %~n1 expanding %1 to the file name
rem %~x1 expanding %1 to the file extension
rem %~s1 expanding %1 to the path contains only short name
rem %~a1 expanding %1 to the file attributes
rem %~t1 expanding %1 to the file date and time
rem %~z1 expanding %1 to the file size
rem '%*' all args from %1
rem '%*' conflicting with formerly expression

set args=
set ret=0

if "%1"=="" goto end
set args=%1
set /a ret=%ret%+1
shift /1
:loop
	if "%1"=="" goto end
	set args=%args%,%1
	set /a ret=%ret%+1
	shift /1
	goto :loop
:end

%decho% %~n0 check args number: %ret%
%decho% %~n0 check args   list: %args%

rem retrun -  ret: number of call args
rem return - args: list of call args with seperating character ',' 
:-------------------------------------

:EOF