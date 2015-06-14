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
if "x%INCLUDE_SETWIN_MODE_BATCH%" == "xtrue" (
	goto :EOF
)
:----------------RUN-ONCE----------------
:: Setting WIN MODE
:----------------------------------------
:: Configures system devices.
:: 
:: Serial port:       MODE COMm[:] [BAUD=b] [PARITY=p] [DATA=d] [STOP=s]
::                                 [to=on|off] [xon=on|off] [odsr=on|off]
::                                 [octs=on|off] [dtr=on|off|hs]
::                                 [rts=on|off|hs|tg] [idsr=on|off]
:: 
:: Device Status:     MODE [device] [/STATUS]
:: 
:: Redirect printing: MODE LPTn[:]=COMm[:]
:: 
:: Select code page:  MODE CON[:] CP SELECT=yyy
:: 
:: Code page status:  MODE CON[:] CP [/STATUS]
:: 
:: Display mode:      MODE CON[:] [COLS=c] [LINES=n]
:: 
:: Typematic rate:    MODE CON[:] [RATE=r DELAY=d]
:----------------------------------------
set QDKe_COLS=80
set QDKe_LINES=300
:----------------------------------------
:label_set_win_mode
:----------------------------------------
  echo [QDKe][MODE] - set to %QDKe_COLS% x %QDKe_LINES%
  mode con:cols=%QDKe_COLS% lines=%QDKe_LINES%
  goto :EOF
:----------------------------------------

:----------------RUN-ONCE----------------
set INCLUDE_SETWIN_MODE_BATCH=true
:EOF
PAUSE