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

#----------------RUN-ONCE----------------
if [[ x$INCLUDE_WORKBENCH_COMMON_SCRIPT == "xtrue" ]]; then
	echo [QDKe] - We Are Checking Included More Than Once - workbench-common.sh.
else
#----------------RUN-ONCE----------------

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
#----------------------------------------
for filename in `ls $QDKE_ROOT/env/env-workbench/`
do
    if [ -f $PROGDIR/../env-workbench/$filename ]; then
      case $filename in
        workbench-fn-*.sh)
          echo [debug] Will included $PROGDIR/../env-workbench/$filename
          . $PROGDIR/../env-workbench/$filename
          ;;
        *) 
          continue;;
      esac
    fi
done
#----------------------------------------
workbench_common_prepare() {
  workbench_key_file=$QDKE_ROOT/env/env-workbench/workbench.key
  if [ ! -e $workbench_key_file ]; then
    echo "WORKBENCH_COMMON_COMP_NAME=workbench_common_comp_name"     >$workbench_key_file
    echo "WORKBENCH_COMMON_PROJ_NAME=workbench_common_proj_name"     >>$workbench_key_file
    echo "WORKBENCH_COMMON_HW_BRD_NAME=workbench_common_hw_brd_name" >>$workbench_key_file
  else
    WORKBENCH_COMMON_COMP_NAME=$(cat $workbench_key_file   | grep "WORKBENCH_COMMON_COMP_NAME="   | sed 's/WORKBENCH_COMMON_COMP_NAME=//g')
    WORKBENCH_COMMON_PROJ_NAME=$(cat $workbench_key_file   | grep "WORKBENCH_COMMON_PROJ_NAME="   | sed 's/WORKBENCH_COMMON_PROJ_NAME=//g')
    WORKBENCH_COMMON_HW_BRD_NAME=$(cat $workbench_key_file | grep "WORKBENCH_COMMON_HW_BRD_NAME=" | sed 's/WORKBENCH_COMMON_HW_BRD_NAME=//g')
    echo [debug] Reading config from $workbench_key_file:
    echo [debug] WORKBENCH_COMMON_COMP_NAME=$WORKBENCH_COMMON_COMP_NAME
    echo [debug] WORKBENCH_COMMON_PROJ_NAME=$WORKBENCH_COMMON_PROJ_NAME
    echo [debug] WORKBENCH_COMMON_HW_BRD_NAME=$WORKBENCH_COMMON_HW_BRD_NAME
  fi
  
  return 0
}

workbench_common_init() {
  workbench_common_prepare
  
  if [ -z $WORKBENCH_COMMON_COMP_NAME ]; then
    local_suffix=$(date +%Y-%m-%d)
    WORKBENCH_COMMON_COMP_NAME="nullcomp-$local_suffix"
  else
    WORKBENCH_COMMON_COMP_NAME_PREFIX=$(echo $WORKBENCH_COMMON_COMP_NAME | cut -f1 -d'-')
    WORKBENCH_COMMON_COMP_NAME_SUFFIX=$(echo $WORKBENCH_COMMON_COMP_NAME | cut -f2 -d'-')
  fi

	if [ -z $WORKBENCH_COMMON_PROJ_NAME ]; then
    local_suffix=$(date +%m-%d)
    WORKBENCH_COMMON_PROJ_NAME="nullproj-$local_suffix"
  fi
  
  if [ -z $(echo $WORKBENCH_COMMON_HW_BRD_NAME | sed 's/ //g') ]; then
	  local_suffix=$(date +%m-%d)
    WORKBENCH_COMMON_HW_BRD_NAME="nullbrd-$local_suffix"
	fi
	
	return 0
}

workbench_common_conf_dirs() {
	export WORKBENCH_COMMON_ROOT_DIR=$WORK_HOME/workbench	
	export WORKBENCH_COMMON_COMP_DIR=$WORKBENCH_COMMON_ROOT_DIR/$WORKBENCH_COMMON_COMP_NAME
	export WORKBENCH_COMMON_PROJ_DIR=$WORKBENCH_COMMON_COMP_DIR/$WORKBENCH_COMMON_PROJ_NAME
	
	export WORKBENCH_COMMON_HARDWARE_DIR=$WORKBENCH_COMMON_PROJ_DIR/hardware
	export WORKBENCH_COMMON_SOFTWARE_DIR=$WORKBENCH_COMMON_PROJ_DIR/software
	export WORKBENCH_COMMON_PREDEV_DIR=$WORKBENCH_COMMON_PROJ_DIR/preDev
	
	return 0
}

workbench_common_conf_contents() {
	WORKBENCH_COMMON_SW_CONTENTS="tools third_party src docs examples tests"
	WORKBENCH_COMMON_HW_CONTENTS="Assembly BOM Gerbers Schematics PCB"
	WORKBENCH_COMMON_PREDEV_CONTENTS="docs extLinks"
	
	WORKBENCH_COMMON_HW_VER_NAME="rel_beta rel_production"
	WORKBENCH_COMMON_HW_COM_NAME="com_docs com_datasheets"
	return 0
}

workbench_common_conf() {
	workbench_common_conf_dirs
	workbench_common_conf_contents
	
	return 0
}

workbench_common_check_dirs() {
	[ -d $WORKBENCH_COMMON_ROOT_DIR ]     || mkdir -p $WORKBENCH_COMMON_ROOT_DIR
	
	[ -d $WORKBENCH_COMMON_COMP_DIR ]     || mkdir -p $WORKBENCH_COMMON_COMP_DIR
	utils_win_create_desktop_shortcut $WORKBENCH_COMMON_COMP_DIR
  
	_var_stamp_exists=false
	for dirname in `ls $WORKBENCH_COMMON_COMP_DIR`
  do
    if [ -f $WORKBENCH_COMMON_COMP_DIR/$dirname ]; then
      case $dirname in
        *.compstamp) 
          _var_stamp_exists=true
          break;;
        *) 
          continue;;
      esac
    fi
  done
	if [ x$_var_stamp_exists == xfalse ]; then
	  touch $WORKBENCH_COMMON_COMP_DIR/$(date +%Y-%m-%d).compstamp
	fi
	
	
	[ -d $WORKBENCH_COMMON_PROJ_DIR ]     || mkdir -p $WORKBENCH_COMMON_PROJ_DIR
	_var_stamp_exists=false
	for dirname in `ls $WORKBENCH_COMMON_PROJ_DIR`
  do
    if [ -f $WORKBENCH_COMMON_PROJ_DIR/$dirname ]; then
      case $dirname in
        *.projstamp) 
          _var_stamp_exists=true
          break;;
        *) 
          continue;;
      esac
    fi
  done
	if [ x$_var_stamp_exists == xfalse ]; then
	  touch $WORKBENCH_COMMON_PROJ_DIR/$(date +%Y-%m-%d).projstamp
	fi
	
	[ -d $WORKBENCH_COMMON_HARDWARE_DIR ] || mkdir -p $WORKBENCH_COMMON_HARDWARE_DIR
	[ -d $WORKBENCH_COMMON_SOFTWARE_DIR ] || mkdir -p $WORKBENCH_COMMON_SOFTWARE_DIR
	[ -d $WORKBENCH_COMMON_PREDEV_DIR   ] || mkdir -p $WORKBENCH_COMMON_PREDEV_DIR
	
#	[ -d $WORKBENCH_COMMON_HARDWARE_DIR/beta ]       || mkdir -p $WORKBENCH_COMMON_HARDWARE_DIR/beta
#	[ -d $WORKBENCH_COMMON_HARDWARE_DIR/production ] || mkdir -p $WORKBENCH_COMMON_HARDWARE_DIR/production
  
	return 0
}

workbench_common_check_contents() {
	for dirname in $WORKBENCH_COMMON_SW_CONTENTS
	do
	  [ -d $WORKBENCH_COMMON_SOFTWARE_DIR/$dirname ]     || mkdir -p $WORKBENCH_COMMON_SOFTWARE_DIR/$dirname
	done
	
	for vername in $WORKBENCH_COMMON_HW_VER_NAME
  do
  	for brdname in $WORKBENCH_COMMON_HW_BRD_NAME
  	do
    	for dirname in $WORKBENCH_COMMON_HW_CONTENTS
    	do
    	  [ -d $WORKBENCH_COMMON_HARDWARE_DIR/$vername/$brdname/$dirname ]     || mkdir -p $WORKBENCH_COMMON_HARDWARE_DIR/$vername/$brdname/$dirname
    	done
    done
  done
  
	for comname in $WORKBENCH_COMMON_HW_COM_NAME
  do
	  [ -d $WORKBENCH_COMMON_HARDWARE_DIR/$comname ]     || mkdir -p $WORKBENCH_COMMON_HARDWARE_DIR/$comname
	done
	
	
	for dirname in $WORKBENCH_COMMON_PREDEV_CONTENTS
	do
	  [ -d $WORKBENCH_COMMON_PREDEV_DIR/$dirname ]     || mkdir -p $WORKBENCH_COMMON_PREDEV_DIR/$dirname
	done
	return 0
}

workbench_common_copy_readme() {
  cat \
      $QDKE_ROOT/etc/template/readme-party-title.tpl \
      $QDKE_ROOT/etc/template/readme-party-license.tpl \
  > $TMP/readme-orig ||die
  
  _var=$(date +%Y)
  sed -e "s/README_PARTY_LICENSE_YEAR/$_var/g" \
      -e "s/README_PARTY_LICENSE_AUTHOR/anyDev/g" \
  $TMP/readme-orig \
  >$TMP/readme-tmp1
  
  sed -e "s/README_PARTY_TITLE_TPL_TITLE/$WORKBENCH_COMMON_PROJ_NAME/g" \
      -e "s/README_PARTY_TITLE_TPL_DESC/Development Top Root Dir/g" \
  $TMP/readme-tmp1 \
  >$TMP/readme-tmp
  cp -n $TMP/readme-tmp $WORKBENCH_COMMON_PROJ_DIR/README.rst
  
  sed -e "s/README_PARTY_TITLE_TPL_TITLE/$WORKBENCH_COMMON_PROJ_NAME - Software/g" \
      -e "s/README_PARTY_TITLE_TPL_DESC/Placed all software files here/g" \
  $TMP/readme-tmp1 \
  >$TMP/readme-tmp
  cp -n $TMP/readme-tmp $WORKBENCH_COMMON_SOFTWARE_DIR/README.rst
  
  sed -e "s/README_PARTY_TITLE_TPL_TITLE/$WORKBENCH_COMMON_PROJ_NAME - Hardware/g" \
      -e "s/README_PARTY_TITLE_TPL_DESC/Placed all hardware files here/g" \
  $TMP/readme-tmp1 \
  >$TMP/readme-tmp
  cp -n $TMP/readme-tmp $WORKBENCH_COMMON_HARDWARE_DIR/README.rst
  
  sed -e "s/README_PARTY_TITLE_TPL_TITLE/$WORKBENCH_COMMON_PROJ_NAME - pre-Development/g" \
      -e "s/README_PARTY_TITLE_TPL_DESC/Placed all pre-Development files here/g" \
  $TMP/readme-tmp1 \
  >$TMP/readme-tmp
  cp -n $TMP/readme-tmp $WORKBENCH_COMMON_PREDEV_DIR/README.rst
  
	return 0
}

workbench_common_copy_proj() {
	# copy proj common files
	cp -n $QDKE_ROOT/QDKe_AnyCmds.bat $WORKBENCH_COMMON_PROJ_DIR/hw_cmds.bat
  cp -n $QDKE_ROOT/QDKe_AnyCmds.bat $WORKBENCH_COMMON_PROJ_DIR/sw_cmds.bat
  
  # copy comp && proj common files
	cp -n $QDKE_ROOT/etc/template/workben-tar-rules.tpl $WORKBENCH_COMMON_COMP_DIR/workben-tar-rules.ini
  cp -n $QDKE_ROOT/etc/template/workben-tar-rules.tpl $WORKBENCH_COMMON_PROJ_DIR/workben-tar-rules.ini
	return 0
}

workbench_common_copy_soft() {
	return 0
}

workbench_common_copy_hard() {
  
	return 0
}

workbench_common_copy() {
	workbench_common_copy_readme
	workbench_common_copy_proj
	workbench_common_copy_soft
	workbench_common_copy_hard
	
	return 0
}

workbench_common_scmInit_comp() {
	cd $WORKBENCH_COMMON_COMP_DIR ||die
	if [ ! -d $WORKBENCH_COMMON_COMP_DIR/.git ]; then
	  git init
	  git checkout --no-track -b master
	  git checkout --no-track -b dev
	fi
	return 0
}
workbench_common_scmInit_proj() {
	cd $WORKBENCH_COMMON_PROJ_DIR ||die
	if [ ! -d $WORKBENCH_COMMON_PROJ_DIR/.git ]; then
	  git init
	  git checkout --no-track -b master
	  git checkout --no-track -b dev
	fi
	return 0
}
workbench_common_scmInit_comp_aux() {
  cd $WORKBENCH_COMMON_COMP_DIR ||die
	if [ -d $WORKBENCH_COMMON_COMP_DIR/.git ]; then
	  
	  # cd $WORKBENCH_COMMON_COMP_DIR ||die
  	for dirname in `ls $WORKBENCH_COMMON_COMP_DIR`
    do
      echo [debug] dirname=$dirname
      if [ ! -d $WORKBENCH_COMMON_COMP_DIR/$dirname ]; then
        continue
      fi
      if [ $dirname == .git ]; then
        continue
      fi
      if [ $dirname == cache ]; then
        continue
      fi
      for exists in `git config --list | grep ^submodule. | cut -f 2 -d .`
  	  do
  	    echo [debug] exists=$exists
  	    if [ $dirname == $exists ]; then
          continue
        fi
        echo [debug] git submodule add $dirname
  	    git submodule add -- $WORKBENCH_COMMON_COMP_DIR/$dirname $dirname
  	  done
  	done
	fi
	return 0
}

workbench_common_scmInit() {
	workbench_common_scmInit_proj
	workbench_common_scmInit_comp
	workbench_common_scmInit_comp_aux
	
	return 0
}

# Assume the tar file store two backup *-1.7z *-2.7z
# 
workbench_common_tar_init() {
	workbench_common_tar_dir=$WORKBENCH_COMMON_COMP_DIR/cache/tars
	[ -d $workbench_common_tar_dir ]     || mkdir -p $workbench_common_tar_dir
	
	TAR_RULES_TYPE_COMP=0
	TAR_RULES_TYPE_PROJ=1
	
	return 0
}
workbench_common_tar_common() {
	# WORKBENCH_COMMON_TAR_RULES_FLAG="-mx=9 -ms=200m -mf -mhc -mhcf -m0=LZMA:a=2:d=25:mf=bt4b:fb=64 -mmt -r"
  WORKBENCH_COMMON_TAR_RULES_FLAG="-mx=9 -ms=200m -mf -mhc -mhcf -m0=LZMA:a=2:d=25:fb=64 -mmt -r"
  WORKBENCH_TAR_RULES_FILES_INCLUDE="* -i!.gitignore -i!.gitmodules"
  WORKBENCH_TAR_RULES_FILES_EXCLUDE="-x!*.bak"
  WORKBENCH_TAR_RULES_DIRS_INCLUDE="-ir!.git"
  WORKBENCH_TAR_RULES_DIRS_EXCLUDE="-xr!cache"
  
  tar_target_type=$1
  tar_target_prefix=workbench-tar-$2
	tar_target_head_suffix=1.$3
	tar_target_tail_suffix=2.$3
	tar_target_head_file=$tar_target_prefix-$tar_target_head_suffix
	tar_target_tail_file=$tar_target_prefix-$tar_target_tail_suffix
	
	tar_target_filename=
	tar_target_includes=
	tar_target_excludes=
	
	tar_target_filename=$tar_target_head_file
	
	cd $workbench_common_tar_dir ||die
	if [ -f $tar_target_head_file ]; then
  	if [ -f $tar_target_tail_file ]; then
    	tar_target_head_stamp=`stat -c %Y $tar_target_head_file`
    	tar_target_tail_stamp=`stat -c %Y $tar_target_tail_file`
    	# if [ $t -ge 1330 -a $t -le 1430 ]; then
    	if [ $tar_target_head_stamp -ge $tar_target_tail_stamp ]; then
    	  tar_target_filename=$tar_target_tail_file
    	# elif [ $[ $b - $a ] -gt 180 ]; then
    	# command
    	fi
    else
      tar_target_filename=$tar_target_tail_file
  	fi
	fi
	
	rm -rf "$workbench_common_tar_dir/$tar_target_filename" >/dev/null 2>&1
	
	return 0
}
workbench_common_tar_rules_get() {
  workbench_common_tar_rules_get_files_include=
  workbench_common_tar_rules_get_files_exclude=
  workbench_common_tar_rules_get_dirs_include=
  workbench_common_tar_rules_get_dirs_exclude=
  workbench_common_tar_rules_flag=
  
  workbench_common_tar_rules_file=$WORKBENCH_COMMON_COMP_DIR/workben-tar-rules.ini
  
  case $tar_target_type in
    $TAR_RULES_TYPE_COMP)echo [debug] TAR_RULES_TYPE_COMP.
        WORKBENCH_TAR_RULES_DIRS_EXCLUDE="$WORKBENCH_TAR_RULES_DIRS_EXCLUDE -xr!$WORKBENCH_COMMON_COMP_NAME";;
    $TAR_RULES_TYPE_PROJ)echo [debug] TAR_RULES_TYPE_PROJ.
        workbench_common_tar_rules_file=$WORKBENCH_COMMON_PROJ_DIR/workben-tar-rules.ini;;
    *)
    echo [ERROR] [$FUNCNAME] - We can come here.
    die;;
  esac
  echo [debug] - workbench_common_tar_rules_file=$workbench_common_tar_rules_file.
  
  for rule in `cat $workbench_common_tar_rules_file | grep "WORKBENCH_TAR_RULES_FILES_INCLUDE=" | sed 's/WORKBENCH_TAR_RULES_FILES_INCLUDE=//g'`
  do
    workbench_common_tar_rules_get_files_include+=" -i!$rule"
  done
  for rule in `cat $workbench_common_tar_rules_file | grep "WORKBENCH_TAR_RULES_FILES_EXCLUDE=" | sed 's/WORKBENCH_TAR_RULES_FILES_EXCLUDE=//g'`
  do
    workbench_common_tar_rules_get_files_exclude+=" -x!$rule"
  done
  for rule in `cat $workbench_common_tar_rules_file | grep "WORKBENCH_TAR_RULES_DIRS_INCLUDE=" | sed 's/WORKBENCH_TAR_RULES_DIRS_INCLUDE=//g'`
  do
    workbench_common_tar_rules_get_dirs_include+=" -ir!$rule"
  done
  for rule in `cat $workbench_common_tar_rules_file | grep "WORKBENCH_TAR_RULES_DIRS_EXCLUDE=" | sed 's/WORKBENCH_TAR_RULES_DIRS_EXCLUDE=//g'`
  do
    # echo [debug] rule in WORKBENCH_TAR_RULES_DIRS_EXCLUDE = $rule.
    workbench_common_tar_rules_get_dirs_exclude+=" -xr!$rule"
  done
  
  if [ x"$workbench_common_tar_rules_get_files_include" == x ]; then
    echo [debug] resetting workbench_common_tar_rules_get_files_include.
    workbench_common_tar_rules_get_files_include="$WORKBENCH_TAR_RULES_FILES_INCLUDE"
  fi
  if [ x"$workbench_common_tar_rules_get_files_exclude" == x ]; then
    echo [debug] resetting workbench_common_tar_rules_get_files_exclude=.
    workbench_common_tar_rules_get_files_exclude="$WORKBENCH_TAR_RULES_FILES_EXCLUDE"
  fi
  if [ x"$workbench_common_tar_rules_get_dirs_include" == x ]; then
    echo [debug] resetting workbench_common_tar_rules_get_dirs_include.
    workbench_common_tar_rules_get_dirs_include="$WORKBENCH_TAR_RULES_DIRS_INCLUDE"
  fi
  if [ x"$workbench_common_tar_rules_get_dirs_exclude" == x ]; then
    echo [debug] resetting workbench_common_tar_rules_get_dirs_exclude.
    workbench_common_tar_rules_get_dirs_exclude="$WORKBENCH_TAR_RULES_DIRS_EXCLUDE"
  fi
  
  workbench_common_tar_rules_flag=" \
    $workbench_common_tar_rules_get_files_include \
    $workbench_common_tar_rules_get_files_exclude \
    $workbench_common_tar_rules_get_dirs_include \
    $workbench_common_tar_rules_get_dirs_exclude \
    "
  
  echo [debug] - workbench_common_tar_rules_flag=$workbench_common_tar_rules_flag.
  return 0
}

workbench_common_tar_execmd_7z() {
  
  workbench_common_tar_rules_get
  
  exe_cmd "\
  7za a -t7z $WORKBENCH_COMMON_TAR_RULES_FLAG -y \
	  "$workbench_common_tar_dir/$tar_target_filename" \
	  * \
	  $workbench_common_tar_rules_flag"
  
  return 0
  
	echo 7za a -t7z $tar_cmd_args_extra -y "$workbench_common_tar_dir/$tar_target_filename" "$tar_target_includes" "$tar_target_excludes"
	7za a -t7z $tar_cmd_args_extra -y "$workbench_common_tar_dir/$tar_target_filename" "$tar_target_includes" "$tar_target_excludes"
	return 0
}
workbench_common_tar_execmd_targz() {
  
  tar zcvf "$workbench_common_tar_dir/$tar_target_filename" "$tar_target_includes" "$tar_target_excludes"
	return 0
}
workbench_common_tar_comp() {
	workbench_common_tar_common $TAR_RULES_TYPE_COMP $WORKBENCH_COMMON_COMP_NAME 7z
	
	cd $WORKBENCH_COMMON_COMP_DIR ||die
	workbench_common_tar_execmd_7z
	return 0
	
	# tar_cmd_args_extra="-mx=9 -ms=200m -mf -mhc -mhcf -m0=LZMA:a=2:d=25:fb=64 -mmt -r"
	7za a -t7z $tar_cmd_args_extra -y \
	  "$workbench_common_tar_dir/$tar_target_filename"  \
	  * -i!.gitmodules -i!.gitignore -ir!.git \
	  -x!*.bak -xr!cache -xr!uav-heli \
	  "$tar_target_excludes"
	# workbench_common_tar_execmd_7z
	# workbench_common_tar_execmd_targz
	
	return 0
}
workbench_common_tar_proj() {
	workbench_common_tar_common $TAR_RULES_TYPE_PROJ $WORKBENCH_COMMON_COMP_NAME-$WORKBENCH_COMMON_PROJ_NAME 7z
	
	cd $WORKBENCH_COMMON_PROJ_DIR ||die
	workbench_common_tar_execmd_7z
	return 0
	
	tar_cmd_args_extra="-mx=9 -ms=200m -mf -mhc -mhcf -m0=LZMA:a=2:d=25:fb=64 -mmt -r"
	7za a -t7z $tar_cmd_args_extra -y \
	  "$workbench_common_tar_dir/$tar_target_filename" \
	  * -i!.gitmodules -i!.gitignore -ir!.git \
	  -x!*.bak -xr!cache \
	  "$tar_target_excludes"
	# pwd && workbench_common_tar_execmd_7z
	# workbench_common_tar_execmd_targz
	
	return 0
}
workbench_common_tar() {
	workbench_common_tar_init
	workbench_common_tar_proj
	workbench_common_tar_comp
	return 0
}

workbench_common_make() {
	workbench_common_check_dirs
	workbench_common_check_contents
	
	workbench_common_copy
	
	workbench_common_scmInit
	
	workbench_common_tar
	
	return 0
}
#----------------------------------------
# workbench_common_init
# workbench_common_conf
# workbench_common_make
#----------------RUN-ONCE----------------
export INCLUDE_WORKBENCH_COMMON_SCRIPT=true
fi
#----------------RUN-ONCE----------------
