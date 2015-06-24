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
:: golang.org/x/blog ！ the content and server program for blog.golang.org.
:: golang.org/x/crypto ！ additional cryptography packages.
:: golang.org/x/exp ！ experimental code (handle with care).
:: golang.org/x/image ！ additional imaging packages.
:: golang.org/x/mobile ！ libraries and build tools for Go on Android.
:: golang.org/x/net ！ additional networking packages.
:: golang.org/x/sys ！ for low-level interactions with the operating system.
:: golang.org/x/talks ！ the content and server program for talks.golang.org.
:: golang.org/x/text ！ packages for working with text.
:: golang.org/x/tools ！ godoc, vet, cover, and other tools.
:: golang.org/x/benchmarks - benchmarks for the Go performance 
:: golang.org/x/build - a continuous build client for the Go project.
set "PGM_GOLANG_HOST=golang.org"
:----------------------------------------
:: labix.org/v2/mgo
:: gopkg.in/mgo.v2
:: gopkg.in/redis.v3
set "PGM_GOPKG_HOST=gopkg.in"
:----------------------------------------
:: code.google.com/p/go-uuid/uuid
:: code.google.com/p/freetype-go
set "PGM_CODEGOOGLE_HOST=code.google.com/p"
:----------------------------------------
set "PGM_GITHUB_HOST=github.com"
set "PGM_HOST=!PGM_GITHUB_HOST!"
:----------------------------------------
rem cd !GOLANG_ROOT! ||goto :EOF
rem unlink go
rem mklink /D go go1.4
:----------------------------------------
if not exist !QDKE_STAMPDIR!/!PGM_NAME!-clone-deps-stamp (
  echo [Go] - Cloneing  - Common Deps - golang glog libs.
	go get !PGM_HOST!/golang/glog
	echo [Go] - Cloneing  - Common Deps - golang x libs.
	go get !PGM_HOST!/zieckey/golang.org
	cp -rf !GOPATH!/src/!PGM_HOST!/zieckey/golang.org !GOPATH!/src/!PGM_GOLANG_HOST! ||goto :EOF
	echo [Go] - Cloneing  - Common Deps - gopkg.in libs.
	rem go get !PGM_GOPKG_HOST!
	
	echo [Go] - Cloneing  - Common Deps - GBK mahonia libs.
	go get !PGM_HOST!/axgle/mahonia
	echo [Go] - Cloneing  - Common Deps - http libs.
	go get !PGM_HOST!/gorilla/http
	
	echo [Go] - Cloneing  - Common Deps - Panda libs.
	go get !PGM_HOST!/pandastream/go-panda
	
	touch !QDKE_STAMPDIR!/!PGM_NAME!-clone-deps-stamp
)
:----------------------------------------
echo [Go] - Cloneing  - Common Deps - Finished.
:----------------RUN-ONCE----------------
set INCLUDE_GO_COMMON_BATCH=true
:EOF
:----------------RUN-ONCE----------------