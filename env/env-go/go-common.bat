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
if "x%INCLUDE_GO_COMMON_BATCH%" == "xtrue" (
	goto :EOF
)
:----------------RUN-ONCE----------------
echo [Go] - Cloneing  - Common Deps.
:----------------------------------------
set "PGM_BATCH_FILE=%~n0"
set "PGM_NAME=!PGM_BATCH_FILE!"
:----------------------------------------
set "PGM_GOLANG_HOST=golang.org"
set "PGM_GOPKG_HOST=gopkg.in"
set "PGM_GITHUB_HOST=github.com"
set "PGM_HOST=!PGM_GITHUB_HOST!"
:----------------------------------------
if not exist !QDKE_STAMPDIR!/!PGM_NAME!-patch-stamp (
	echo [Go] - Cloneing  - Common Deps - golang.org x libs.
	go get !PGM_HOST!/zieckey/golang.org
	cp -rf !GOPATH!/src/!PGM_HOST!/zieckey/golang.org !GOPATH!/src/!PGM_GOLANG_HOST! ||goto :EOF
	echo [Go] - Cloneing  - Common Deps - gopkg.in libs.
	rem go get !PGM_GOPKG_HOST!
	
	touch !QDKE_STAMPDIR!/!PGM_NAME!-patch-stamp
)
:----------------------------------------
echo [Go] - Cloneing  - Common Deps - Finished.
:----------------RUN-ONCE----------------
set INCLUDE_GO_COMMON_BATCH=true
:EOF
:----------------RUN-ONCE----------------