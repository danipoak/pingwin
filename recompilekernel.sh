#recompile the kernel when adding new features to the existing source
cd /usr/src/linux
sudo make -j13 
sudo make -j13 modules_install 
sudo make install
sudo emerge -q @module-rebuild 