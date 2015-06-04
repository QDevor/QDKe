#!/bin/bash
#
#            Copyright (C) 2015 QDevor
#
#  Licensed under the GNU General Public License, Version 3.0 (the License);
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#            http://www.gnu.org/licenses/gpl-3.0.html
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

PROGDIR=`dirname $0`
PROGDIR=`cd $PROGDIR && pwd -P`

# echo [Debug] - '$0'=$0
FILENAME=`basename $0`
PROGTYPE=${FILENAME#*.}
PROGNAME=${FILENAME%.*}
# echo [Debug] - The script is: $PROGDIR/$PROGNAME.$PROGTYPE
#----------------------------------------
export PYTHON=python2
#----------------------------------------
. $PROGDIR/../env-msys2/entry-common.sh
. $PROGDIR/../env-msys2/qdev-build-common.sh
. $PROGDIR/../env-pkg/py-qstk-common.sh
#----------------------------------------
. $PROGDIR/../env-pkg/py-extpkgs-UWB.sh
#----------------------------------------
qdev_try_qstk() {
	log_info "$FUNCNAME - $PROGNAME."
	apps_name=numpy					&& extpkgs_uwb_installPkg || die
	apps_name=scipy					&& extpkgs_uwb_installPkg || die
	apps_name=pandas				&& extpkgs_uwb_installPkg || die
	if [ x$PYVER = "2" ]; then
		apps_name=MySQL-python	&& extpkgs_uwb_installPkg || die
	elif [ x$PYVER = "3" ]; then
		apps_name=Mysqlclient		&& extpkgs_uwb_installPkg || die
	fi
	apps_name=wxPython			&& extpkgs_uwb_installPkg || die
	apps_name=h5py					&& extpkgs_uwb_installPkg || die
	apps_name=matplotlib		&& extpkgs_uwb_installPkg || die
	apps_name=vigranumpy		&& extpkgs_uwb_installPkg || die
	apps_name=Pillow				&& extpkgs_uwb_installPkg || die
	apps_name=lxml					&& extpkgs_uwb_installPkg || die
	apps_name=SQLAlchemy		&& extpkgs_uwb_installPkg || die
	apps_name=pymongo				&& extpkgs_uwb_installPkg || die
}
#----------------------------------------
# Other useful packages and applications not currently available on this method
qdev_try_misc() {
	log_info "$FUNCNAME - $PROGNAME."
	#	PyGSL provides an interface for the GNU Scientific Library (gsl).
	apps_name=PyGSL					&& extpkgs_uwb_installPkg || die
	# pyCGNS provides an interface to the CGNS/SIDS data model.
	apps_name=pyCGNS				&& extpkgs_uwb_installPkg || die
	# PyCrypto provides cryptographic modules.
	apps_name=PyCrypto			&& extpkgs_uwb_installPkg || die
	# PyDSTool, a dynamical systems modeling, simulation and analysis environment.
	apps_name=PyDSTool			&& extpkgs_uwb_installPkg || die
	# Pyffmpeg, a wrapper for FFmpeg, a solution to record, convert and stream audio and video.
	apps_name=Pyffmpeg			&& extpkgs_uwb_installPkg || die
	# PyFFTW3 are bindings to the FFTW C library.
	apps_name=PyFFTW3				&& extpkgs_uwb_installPkg || die
	# PyGreSQL interfaces to a PostgreSQL database.
	apps_name=PyGreSQL			&& extpkgs_uwb_installPkg || die
	# pyOpenSSL, an interface to the OpenSSL library.
	apps_name=pyOpenSSL			&& extpkgs_uwb_installPkg || die
	# PyQt5, a set of bindings for the Qt5 application framework
	apps_name=PyQt5					&& extpkgs_uwb_installPkg || die
	# Scikit-bio (unstable) provides data structures, algorithms, and educational resources for bioinformatics.
	apps_name=Scikit-bio		&& extpkgs_uwb_installPkg || die
	# Scikit-tracker, objects detection and robust tracking for cell biology.
	apps_name=Scikit-tracker	&& extpkgs_uwb_installPkg || die
}
#----------------------------------------
#
# Required and optional software
#
#----------------------------------------
#extpkgs_uwb_url=http://www.lfd.uci.edu/~gohlke/pythonlibs
#extpkgs_uwb_dnl=$extpkgs_uwb_url/68tmfkay
#extpkgs_uwb_pkg=
#----------------------------------------
work_home=$QSTK_WORK_HOME
user_name=extpkgs_uwb
#apps_name=
#apps_more=
#----------------------------------------
# pkg_nam=?
# pkg_typ=?
# pkg_ver=?
# pkg_rel=?
# pkg_url=?
#----------------------------------------
qdev_init
#qdev_set					$work_home $user_name $apps_name $apps_more
#qdev_setmore
#qdev_get
#qdev_check
#qdev_try
qdev_try_qstk
# qdev_try_misc
#qdev_tst
