three components:
**linux kernel** el nucleo del sistema operativo
**BusyBox** proporciona las utilidades basicas de unix en un solo binario
**Syslinux** el bootloadre que carga todo al arrancar

**para que sirve cada paquete?**
gcc
make - compilación del kernel y BusyBox
-"libncurses-dev' - menús interactivos de configuración ('menuconfig )
•'flex', "bison"
"be - requeridos por el proceso de build del kernel
• cpio' - para crear el initramfs
- "Libelf-dev', "libssl-dev' - dependencias del kernel
"syslinux' - el bootloader
-'dosfstools' - para crear el filesystem FAT
~
- 'qemu-system-x86' - para probar la imagen sin necesidad de hardware real