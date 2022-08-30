# compila-WRF

Compilación del modelo WRF 4.4.1 utilizando compiladores gcc 9.4.0

* [zlib](README.md#zlib) 1.2.12.tar.gz
* [libaec](README.md#libaec) 1.0.6.tar.gz
* [curl](README.md#curl) 7.82.0.tar.gz
* [jasper](README.md#jasper) 1.900.22.tar.gz
* [libpng](README.md#libpng) 1.6.37.tar.gz
* [hdf5](README.md#hdf5) 1.10.8.tar.gz
* [netcdf-c](README.md#netcdf-c) c-4.8.1.tar.gz
* [netcdf-fortran](README.md#netcdf-fortran) fortran-4.5.4.tar.gz

## Requisitos
~~~bash
sudo apt -y install gfortran flex curl axel vim htop mpich libssl-dev lmod mc git tmux
~~~
## Compilador y directorio de apps
~~~bash
export HOME_APPS=/opt/software/apps
export COMP_VERSION=gcc/9.4.0

~~~


## ZLIB

~~~bash
APP_NAME=zlib
APP_VERSION=1.2.12
APP_ROOT=$HOME_APPS/$APP_NAME
APP_BUILD=$APP_ROOT/$COMP_VERSION/build
APP_INSTALL=$APP_ROOT/$COMP_VERSION/$APP_VERSION
APP_URL=https://github.com/pdcs-cca/compila-WRF/raw/main/src/zlib-1.2.12.tar.gz

~~~

~~~bash
mkdir -pv $APP_BUILD
cd $APP_BUILD
curl -L $APP_URL | tar xzvf -
cd $APP_NAME-$APP_VERSION/
./configure --prefix=$APP_INSTALL  
make
make install
export LDFLAGS="-L$APP_INSTALL/lib $LDFLAGS"
export CPPFLAGS="-I$APP_INSTALL/include $CPPFLAGS"
export ZLIB_ROOT=$APP_INSTALL

~~~

## LIBAEC
~~~bash
APP_NAME=libaec
APP_VERSION=1.0.6
APP_ROOT=$HOME_APPS/$APP_NAME
APP_BUILD=$APP_ROOT/$COMP_VERSION/build
APP_INSTALL=$APP_ROOT/$COMP_VERSION/$APP_VERSION
APP_URL=https://github.com/pdcs-cca/compila-WRF/raw/main/src/libaec-1.0.6.tar.gz
~~~
~~~bash
mkdir -pv $APP_BUILD
cd $APP_BUILD
curl -L $APP_URL | tar xzvf -
cd $APP_NAME-$APP_VERSION/
./configure --prefix=$APP_INSTALL  
make
make install
export LDFLAGS="-L$APP_INSTALL/lib $LDFLAGS"
export CPPFLAGS="-I$APP_INSTALL/include $CPPFLAGS"
export LIBAEC_ROOT=$APP_ROOT
~~~

## CURL

~~~bash
APP_NAME=curl
APP_VERSION=7.82.0
APP_ROOT=$HOME_APPS/$APP_NAME
APP_BUILD=$APP_ROOT/$COMP_VERSION/build
APP_INSTALL=$APP_ROOT/$COMP_VERSION/$APP_VERSION
APP_URL=https://github.com/pdcs-cca/compila-WRF/raw/main/src/curl-7.82.0.tar.gz
~~~
~~~bash
mkdir -pv $APP_BUILD
cd $APP_BUILD
curl -L $APP_URL | tar xzvf -
cd $APP_NAME-$APP_VERSION/
./configure --with-openssl --prefix=$APP_INSTALL  
make
make install
export LDFLAGS="-L$APP_INSTALL/lib $LDFLAGS"
export CPPFLAGS="-I$APP_INSTALL/include $CPPFLAGS"
export CURL_ROOT=$APP_INSTALL
~~~

## LIBPNG

~~~bash
APP_NAME=libpng
APP_VERSION=1.6.37
APP_ROOT=$HOME_APPS/$APP_NAME
APP_BUILD=$APP_ROOT/$COMP_VERSION/build
APP_INSTALL=$APP_ROOT/$COMP_VERSION/$APP_VERSION
APP_URL=https://github.com/pdcs-cca/compila-WRF/raw/main/src/libpng-1.6.37.tar.gz
~~~

~~~bash
mkdir -pv $APP_BUILD
cd $APP_BUILD
curl -L $APP_URL | tar xzvf -
cd $APP_NAME-$APP_VERSION/
./configure --prefix=$APP_INSTALL  
make
make install
export LDFLAGS="-L$APP_INSTALL/lib $LDFLAGS"
export CPPFLAGS="-I$APP_INSTALL/include $CPPFLAGS"
export LIBPNG_ROOT=$APP_INSTALL
~~~

## JASPERLIB 

~~~bash
APP_NAME=jasper
APP_VERSION=1.900.22
APP_ROOT=$HOME_APPS/$APP_NAME
APP_BUILD=$APP_ROOT/$COMP_VERSION/build
APP_INSTALL=$APP_ROOT/$COMP_VERSION/$APP_VERSION
APP_URL=https://github.com/pdcs-cca/compila-WRF/raw/main/src/jasper-1.900.22.tar.gz
~~~

~~~bash
mkdir -pv $APP_BUILD
cd $APP_BUILD
curl -L $APP_URL | tar xzvf -
cd $APP_NAME-$APP_VERSION/
./configure --prefix=$APP_INSTALL  
make
make install
export LDFLAGS="-L$APP_INSTALL/lib $LDFLAGS"
export CPPFLAGS="-I$APP_INSTALL/include $CPPFLAGS"
export JASPERLIB_ROOT=$APP_INSTALL
~~~

## HDF5

~~~bash
APP_NAME=hdf5
APP_VERSION=1.10.8
APP_ROOT=$HOME_APPS/$APP_NAME
APP_BUILD=$APP_ROOT/$COMP_VERSION/build
APP_INSTALL=$APP_ROOT/$COMP_VERSION/$APP_VERSION
APP_URL=https://github.com/pdcs-cca/compila-WRF/raw/main/src/${APP_NAME}-${APP_VERSION}.tar.gz
~~~

~~~bash
mkdir -pv $APP_BUILD
cd $APP_BUILD
curl -L $APP_URL | tar xzvf -
cd $APP_NAME-$APP_VERSION/
./configure --enable-fortran --with-zlib=$ZLIB_ROOT--with-szlib=$LIBAEC_ROOT --prefix=$APP_INSTALL  
make -j4
make -j4 check
make install
export LDFLAGS="-L$APP_INSTALL/lib $LDFLAGS"
export CPPFLAGS="-I$APP_INSTALL/include $CPPFLAGS"
export HDF5_ROOT=$APP_INSTALL
export HFD5=$APP_INSTALL
~~~


## NETCDF-C
~~~bash
APP_NAME=netcdf-c
APP_VERSION=4.8.1
APP_ROOT=$HOME_APPS/$APP_NAME
APP_BUILD=$APP_ROOT/$COMP_VERSION/build
APP_INSTALL=$APP_ROOT/$COMP_VERSION/$APP_VERSION
APP_URL=https://github.com/pdcs-cca/compila-WRF/raw/main/src/${APP_NAME}-${APP_VERSION}.tar.gz
~~~

~~~bash
mkdir -pv $APP_BUILD
cd $APP_BUILD
curl -L $APP_URL | tar xzvf -
cd $APP_NAME-$APP_VERSION/
./configure --disable-dap-remote-tests --prefix=$APP_INSTALL  
make -j4
make -j4 check
make install
export LDFLAGS="-L$APP_INSTALL/lib $LDFLAGS"
export CPPFLAGS="-I$APP_INSTALL/include $CPPFLAGS"
export NETCDF_C_ROOT=$APP_INSTALL
~~~


## NETCDF-FORTRAN
~~~bash
APP_NAME=netcdf-fortran
APP_VERSION=4.5.4
APP_ROOT=$HOME_APPS/$APP_NAME
APP_BUILD=$APP_ROOT/$COMP_VERSION/build
APP_INSTALL=$APP_ROOT/$COMP_VERSION/$APP_VERSION
APP_URL=https://github.com/pdcs-cca/compila-WRF/raw/main/src/${APP_NAME}-${APP_VERSION}.tar.gz
~~~

~~~bash
mkdir -pv $APP_BUILD
cd $APP_BUILD
curl -L $APP_URL | tar xzvf -
cd $APP_NAME-$APP_VERSION/
./configure  --prefix=$APP_INSTALL  
make -j4
make -j4 check
make install
export LDFLAGS="-L$APP_INSTALL/lib $LDFLAGS"
export CPPFLAGS="-I$APP_INSTALL/include $CPPFLAGS"
export NETCDF_FORTRAN_ROOT=$APP_INSTALL
export NETCDF=$APP_INSTALL
~~~
