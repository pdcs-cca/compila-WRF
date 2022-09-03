# Compilación de WRF 4.4.1 con química (WRF-Chem) y WPS 4.4

El script `WRF-WPS-chem.sh` instala las depencias para la compilación de  WRF-Chem en Ubuntu  20.04.5 LTS "Focal Fossa" gcc version 9.4.0, durante el proceso generá archivos de modulos "Lua Lmod"  para el uso del software

## Uso del script

~~~bash
wget https://raw.githubusercontent.com/pdcs-cca/compila-WRF/main/ubuntu-20-gcc/chem/WRF-WPS-chem.sh
bash WRF-WPS-chem.sh
~~~

## Uso del software 

~~~bash
ml wrf 
curl -L https://www2.mmm.ucar.edu/wrf/OnLineTutorial/wrf_cloud/wrf_simulation_CONUS12km.tar.gz | tar xzvf -
cd conus_12km
ln -s $WRF_ROOT/test/em_real/* .
mpiexec.hydra -n 4 wrf.exe
~~~

