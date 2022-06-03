# compila-WRF

Compilación del modelo WRF 4.3.3 utilizando compiladores de intel.

* zlib-1.2.12.tar.gz
* curl-7.82.0.tar.gz
* jasper-1.900.22.tar.gz
* libaec-1.0.6.tar.gz
* libpng-1.6.37.tar.xz
* hdf5-1.10.8.tar.gz
* netcdf-c-4.8.1.tar.gz
* netcdf-fortran-4.5.4.tar.gz


## ZLIB

~~~bash
HOME_APPS=/opt/software/apps
COMP_VERSION=intel/2021u5
export CC=icc FC=ifort F77=ifort F90=ifort CXX=icpc
export CFLAGS=" -O3 -fPIC"
APP_NAME=zlib
APP_VERSION=1.2.12
APP_ROOT=$HOME_APPS/$APP_NAME
APP_BUILD=$APP_ROOT/$COMP_VERSION/build
APP_INSTALL=$APP_ROOT/$COMP_VERSION/$APP_VERSION
~~~

~~~bash
cd $HOME_APPS
mkdir -pv $APP_NAME/$COMP_VERSION/build
cd $APP_NAME/$COMP_VERSION/build
curl -L https://github.com/pdcs-cca/compila-WRF/raw/main/src/zlib-1.2.12.tar.gz | tar xzvf -
cd $APP_NAME-$APP_VERSION/
./configure prefix=$APP_INSTALL  
make
make install
~~~


