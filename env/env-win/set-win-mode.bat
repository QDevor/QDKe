@echo off
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
setlocal ENABLEDELAYEDEXPANSION
set /a tee=0
for /f "tokens=1* delims==" %%a in ( 'wmic DESKTOPMONITOR  get ScreenWidth^,ScreenHeight^ /value' ) do (
  set /a tee+=1
  if "!tee!" == "3" set QDKe_VAR_SCREEN_HEIGHT=%%b
  if "!tee!" == "4" set QDKe_VAR_SCREEN_WIDTH=%%b
  rem echo %%b
)
:----------------------------------------
if "x%QDKe_VAR_SCREEN_WIDTH%" == "x" (
	set /a QDKe_VAR_SCREEN_WIDTH=1280
)
if "x%QDKe_VAR_SCREEN_HEIGHT%" == "x" (
	set /a QDKe_VAR_SCREEN_HEIGHT=1024
)
:----------------------------------------
set /a QDKe_VAR_FONT_WIDTH_1=3
set /a QDKe_VAR_FONT_HEIGHT_1=5
set /a QDKe_VAR_FONT_WIDTH_2=5
set /a QDKe_VAR_FONT_HEIGHT_2=8
set /a QDKe_VAR_FONT_WIDTH_3=6
set /a QDKe_VAR_FONT_HEIGHT_3=12
set /a QDKe_VAR_FONT_WIDTH_DFLT=8
set /a QDKe_VAR_FONT_HEIGHT_DFLT=16
set /a QDKe_VAR_FONT_WIDTH_5=8
set /a QDKe_VAR_FONT_HEIGHT_5=18
set /a QDKe_VAR_FONT_WIDTH_MAX=10
set /a QDKe_VAR_FONT_HEIGHT_MAX=20
:----------------------------------------
set /a QDKe_VAR_SCREEN_WH_RATIO=%QDKe_VAR_SCREEN_WIDTH%/%QDKe_VAR_SCREEN_HEIGHT%+1
set /a QDKe_VAR_SCREEN_TERM_RATIO=%QDKe_VAR_SCREEN_WIDTH%/%QDKe_VAR_SCREEN_HEIGHT%*4
:----------------------------------------
set /a QDKe_COLS_DFLT=%QDKe_VAR_SCREEN_WIDTH%/%QDKe_VAR_FONT_WIDTH_DFLT%-4
set /a QDKe_LINES_DFLT=%QDKe_COLS_DFLT%/%QDKe_VAR_SCREEN_WH_RATIO%

set /a QDKe_COLS_FULL=%QDKe_VAR_SCREEN_WIDTH%/%QDKe_VAR_FONT_WIDTH_DFLT%-4
set /a QDKe_LINES_FULL=%QDKe_COLS_FULL%/%QDKe_VAR_SCREEN_WH_RATIO%
:----------------------------------------
rem mode con cols=%screenwidth%
rem mode con lines=%screenheight%
rem echo [QDKe][MODE] - %screenwidth% x %screenheight%
:----------------------------------------
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
:: New FreeDOS MODE by Eric Auer 2003-2005. License: GPL.   (version 12may2005)
:: MODE [device] [/STA[TUS]]                (show status of one or all devices)
:: MODE LPTn[:] cols[,[lines][,retry]]     (cols or cpi, 6/8 lpi, retry p or n)
:: MODE LPTn[:] [COLS=...] [LINES=...] [RETRY=...] (retry: p infinite / n none)
:: MODE LPTn[:]=[COMn[:]|NUL]     (redirect printer data to serial port or NUL)
:: MODE COMn[:] baud,parity,data,stop,retry              (empty values allowed)
:: MODE COMn[:] [BAUD[HARD]=...] [PARITY=...] [DATA=...] [STOP=...] [RETRY=...]
::   Baud can be abbreviated to unique prefix,  parity can be o/e/n/s/m,  the
::   latter 2 mean space/mark, data can be 5..8, stop 1..2. Retry is IGNORED!
::   PLANNED: Retry b/e/r -> busy/error/ready if busy, p/n infinite/no retry.
:: MODE CON[:] [CP|CODEPAGE] [/STA[TUS]]       (FreeDOS DISPLAY must be loaded)
:: MODE CON[:] [CP|CODEPAGE] REF[RESH]                          (needs DISPLAY)
:: MODE CON[:] [CP|CODEPAGE] SEL[ECT]=number                    (needs DISPLAY)
:: MODE CON[:] [CP|CODEPAGE] PREP[ARE]=((codepage) filename)    (needs DISPLAY)
::   Use PREP=((,cp2,cp3,,cp5) ...) to prep codepages in other buffers.
:: MODE [40|80|BW40|BW80|CO40|CO80|MONO][,rows]  (rows can be 25, 28, 43 or 50)
::   Use 8, 14 or 16 as 'rows' value if you only want to change the font.
:: MODE [CO40|CO80|...],[R|L][,T] (shift CGA left/right, T is interactive mode)
:: MODE CON[:] [NUMLOCK|CAPSLOCK|SCROLLLOCK|SWITCHAR]=value
::   Value can be: + or - for the locks or a character for switchar.
:: MODE CON[:] [COLS=...] [LINES=...] (possible values depend on your hardware)
:: MODE CON[:] [RATE=...] [DELAY=...]        (default rate 20, default delay 1)
::   Rate can be 1..32 for 2..30 char/sec,  delay can be 1..4 for 1/4..4/4 sec.
:---------------------------------------- 
set IN_ARG=%1
if "x%IN_ARG%" == "x" (
  set IN_ARG=1
)
rem echo [QDKe][MODE] - x%IN_ARG% 
:----------------------------------------
:: fullsize - 198x51[WIN7] - axb[WINXP]
:: GoodSize - 80x40
:----------------------------------------
if "x%IN_ARG%" == "x1" (
  goto :EOF
)
if "x%IN_ARG%" == "x2" (
  set /a QDKe_COLS=%QDKe_COLS_DFLT%*2/4
  set /a QDKe_LINES=!QDKe_COLS!/%QDKe_VAR_SCREEN_TERM_RATIO%
  goto :label_set_win_mode
)
if "x%IN_ARG%" == "x3" (
  set /a QDKe_COLS=%QDKe_COLS_DFLT%*3/4
  set /a QDKe_LINES=!QDKe_COLS!/%QDKe_VAR_SCREEN_TERM_RATIO%
  goto :label_set_win_mode
)
if "x%IN_ARG%" == "x4" (
  set /a QDKe_COLS=%QDKe_COLS_DFLT%
  set /a QDKe_LINES=%QDKe_LINES_DFLT%
  goto :label_set_win_mode
)
rem echo [QDKe][MODE] - [default]
set /a QDKe_COLS=%QDKe_VAR_SCREEN_WIDTH%/%QDKe_VAR_FONT_WIDTH_DFLT%-4
set /a QDKe_LINES=%QDKe_COLS%/%QDKe_VAR_SCREEN_TERM_RATIO%
goto :label_set_win_mode
:----------------------------------------
rem set QDKe_COLS=80
rem set QDKe_LINES=300
rem mode con:cols=80 lines=300
:----------------------------------------
:label_set_win_mode
:----------------------------------------
  rem mode con:cols=%QDKe_COLS% lines=%QDKe_LINES%
  rem echo [QDKe][MODE] - %IN_ARG%
  echo [QDKe][Screen] - %QDKe_VAR_SCREEN_WIDTH% x %QDKe_VAR_SCREEN_HEIGHT%
  echo [QDKe][MODE] - %QDKe_COLS% x %QDKe_LINES%
  goto :EOF
:----------------------------------------

:----------------RUN-ONCE----------------
set INCLUDE_SETWIN_MODE_BATCH=true
:EOF
PAUSE