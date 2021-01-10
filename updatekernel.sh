#update kernel
printf "Executing: sudo cp /usr/src/linux/.config /kernel-config-`uname -r`\n"
read -p "Press enter to continue"
sudo cp /usr/src/linux/.config /kernel-config-`uname -r`
printf "Success\n"
printf "`eselect kernel list`\n"
echo Which kernel source would you like to compile
read kernelsource
printf "Executing: sudo eselect kernel set $kernelsource\n"
read -p "Press enter to continue"
sudo eselect kernel set $kernelsource
printf "Success\n"
cd /usr/src/linux
printf "Executing: sudo cp /usr/src/`uname -r`/.config /usr/src/linux/\n"
read -p "Press enter to continue"
sudo cp /usr/src/linux-`uname -r`/.config /usr/src/linux/
printf "Success\n"
printf "Compiling the new kernel source\n"
sudo make -j13 olddefconfig
sudo make -j13 
sudo make -j13 modules_install 
sudo make install
printf "Success\n"
printf "Recompiling modules\n"
sudo emerge -q  @module-rebuild
printf "Installing kernel image to grub\n"
sudo grub-mkconfig -o /boot/grub/grub.cfg
