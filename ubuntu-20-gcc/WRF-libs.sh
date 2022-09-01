#!/bin/bash 

_banner(){

echo "#######################################################"
figlet -tr $*
echo "#######################################################"

}

_modulo(){
local APP_NAME="$1" 
local APP_VERSION="$2"


local __CPPFLAGS="$(echo $APP_NAME | tr [a-z] [A-Z] | tr "-" "_" )_CPPFLAGS"
local __LDFLAGS="$(echo $APP_NAME | tr [a-z] [A-Z] | tr "-" "_" )_LDFLAGS"
local __ROOT="$(echo $APP_NAME | tr [a-z] [A-Z] | tr "-" "_" )_ROOT"
local __NAME="$(echo $APP_NAME | tr [a-z] [A-Z] | tr "-" "_" )"

mkdir -pv $HOME_APPS/modulefiles/Compiler/$COMP_VERSION/$APP_NAME/ && \

cat <<LUAMOD > $HOME_APPS/modulefiles/${MODULE_FILE}.lua 
local apps = "$HOME_APPS"
local pkg = "$APP_NAME"
local pkg_version = "$APP_VERSION"
local compiler = "$COMPILER_NAME"
local compiler_version = "$COMPILER_VERSION"
local base = pathJoin(apps,pkg,compiler,compiler_version,pkg_version)
local cppflags = "-I"..base.."/include"
local ldflags = "-L"..base.."/lib".." -Wl,-rpath="..base.."/lib"


prepend_path("PATH",pathJoin(base,"bin"))
--prepend_path("LD_LIBRARY_PATH",pathJoin(base,"lib"))
prepend_path("MANPATH",pathJoin(base,"share/man"))


setenv("$__CPPFLAGS",cppflags)
setenv("$__LDFLAGS",ldflags)
setenv("$__ROOT",base)
setenv("$__NAME",base)


if (os.getenv("CPPFLAGS") == nil )  then  
        setenv("CPPFLAGS",cppflags)
    else  
        setenv("CPPFLAGS",cppflags.." "..os.getenv("CPPFLAGS"))
end

if (os.getenv("LDFLAGS") == nil )  then  
        setenv("LDFLAGS",ldflags)
    else  
        setenv("LDFLAGS",ldflags.." "..os.getenv("LDFLAGS"))
end
LUAMOD

test $APP_NAME == "jasper" && echo "setenv(\"${__NAME}INC\",base..\"/include\")" >> $HOME_APPS/modulefiles/${MODULE_FILE}.lua
test $APP_NAME == "jasper" && echo "setenv(\"${__NAME}LIB\",base..\"/lib\")" >> $HOME_APPS/modulefiles/${MODULE_FILE}.lua
test $APP_NAME == "netcdf-fortran" && echo "setenv(\"NETCDF\",base)" >> $HOME_APPS/modulefiles/${MODULE_FILE}.lua 

}

_variables(){

local APP_NAME=$1
local APP_VERSION=$2
local APP_URL=$3

echo " export APP_NAME=$APP_NAME
APP_VERSION=$APP_VERSION
APP_ROOT=$HOME_APPS/$APP_NAME
APP_BUILD=$HOME_APPS/$APP_NAME/$COMP_VERSION/build
APP_INSTALL=$HOME_APPS/$APP_NAME/$COMP_VERSION/$APP_VERSION
APP_URL=https://github.com/pdcs-cca/compila-WRF/raw/main/src/${APP_NAME}-${APP_VERSION}.tar.gz
MODULE_FILE=Compiler/$COMP_VERSION/$APP_NAME/$APP_VERSION
"
}

_setup(){
test -d $APP_INSTALL && return 0
test "$1" == "check" && local CHECK=1 && shift
mkdir -pv $APP_BUILD
cd $APP_BUILD
curl -L $APP_URL | tar xzf -
cd $APP_NAME-$APP_VERSION/
./configure $@ 
make -j4
test ! -z "$CHECK" && make -j4 check
make install
_modulo $APP_NAME $APP_VERSION
}
##
###
####
####
###
##
_banner "WRF 4.4.1"
ml purge 
sudo apt -y install gfortran tcsh flex curl axel vim htop mpich libssl-dev lmod mc git tmux figlet
export HOME_APPS=$HOME/software/apps
export COMPILER_NAME=gcc
export COMPILER_VERSION=9.4.0
export COMP_VERSION=$COMPILER_NAME/$COMPILER_VERSION
mkdir -pv $HOME_APPS/modulefiles 
sudo sh -c "echo $HOME_APPS/modulefiles > /etc/lmod/modulespath "
ml use $HOME_APPS/modulefiles 

_banner "ZLIB"
eval $(_variables zlib 1.2.12 )
_setup --prefix=$APP_INSTALL 
ml $MODULE_FILE
ml 


_banner "LIBAEC"
eval $(_variables libaec 1.0.6 )
_setup  --prefix=$APP_INSTALL 
ml $MODULE_FILE
ml

_banner "CURL"
eval $(_variables curl 7.82.0 )
_setup --with-openssl  --prefix=$APP_INSTALL 
ml $MODULE_FILE
ml

_banner "LIBPNG"
eval $(_variables libpng 1.6.37 )
_setup  --prefix=$APP_INSTALL 
ml $MODULE_FILE
ml

_banner "JASPERLIB"  
eval $(_variables jasper 1.900.22 )
_setup  --prefix=$APP_INSTALL 
ml $MODULE_FILE
ml

_banner "HDF5"
eval $(_variables hdf5 1.10.8 )
_setup check --enable-fortran --with-zlib=$ZLIB_ROOT --with-szlib=$LIBAEC_ROOT  --prefix=$APP_INSTALL 
ml $MODULE_FILE
ml

_banner "NETCDF-C"
eval $(_variables netcdf-c 4.8.1)
_setup check  --disable-dap-remote-tests  --prefix=$APP_INSTALL 
ml $MODULE_FILE
ml


_banner "NETCDF-FORTRAN"
eval $(_variables netcdf-fortran 4.5.4)
_setup --prefix=$NETCDF_C_ROOT 
ml $MODULE_FILE
ml

-banner "WRF"
mkdir -pv $HOME_APPS/wrf/$COMP_VERSION
cd $HOME_APPS/wrf/$COMP_VERSION
curl -L https://github.com/wrf-model/WRF/releases/download/v4.4.1/v4.4.1.tar.gz | tar xzvf 
cd WRFV4.4.1 
sed -i 's/FALSE/TRUE/' arch/Config.pl 
echo -e "34\n"| ./configure 

export WRF_DIR=$HOME_APPS/wrf/$COMP_VERSION/WRFV4.4.1
cd $HOME_APPS/wrf/$COMP_VERSION 
curl -L https://github.com/wrf-model/WPS/archive/refs/tags/v4.4.tar.gz | tar xzvf -
cd WPS-4.4
echo -e "3\n" | ./configure 

