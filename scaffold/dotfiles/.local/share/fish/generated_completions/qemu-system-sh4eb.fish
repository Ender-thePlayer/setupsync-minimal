# qemu-system-sh4eb
# Autogenerated from man page /usr/share/man/man1/qemu-system-sh4eb.1.gz
complete -c qemu-system-sh4eb -s h -d 'Display help and exit'
complete -c qemu-system-sh4eb -o version -d 'Display version information and exit'
complete -c qemu-system-sh4eb -o machine -d 'Select the emulated machine by name'
complete -c qemu-system-sh4eb -o cpu -d 'Select CPU model (-cpu help for list and additional feature selection)'
complete -c qemu-system-sh4eb -o accel -d 'This is used to enable an accelerator'
complete -c qemu-system-sh4eb -o smp -d 'Simulate a SMP system with \'n\' CPUs initially present on the machine type boa…'
complete -c qemu-system-sh4eb -o numa -d 'Define a NUMA node and assign RAM and VCPUs to it'
complete -c qemu-system-sh4eb -o add-fd -d 'Add a file descriptor to an fd set.  Valid options are: NDENT 7. 0'
complete -c qemu-system-sh4eb -o set -d 'Set parameter arg for item id of type group'
complete -c qemu-system-sh4eb -o global -d 'Set default value of driver\'s property prop to value, e. g. : NDENT 7'
complete -c qemu-system-sh4eb -o boot -d 'Specify boot order drives as a string of drive letters'
complete -c qemu-system-sh4eb -s m -d 'Sets guest startup RAM size to megs megabytes.  Default is 128 MiB'
complete -c qemu-system-sh4eb -o mem-path -d 'Allocate guest RAM from a temporarily created file in path'
complete -c qemu-system-sh4eb -o mem-prealloc -d 'Preallocate memory when using -mem-path'
complete -c qemu-system-sh4eb -s k -d 'Use keyboard layout language (for example fr for French)'
complete -c qemu-system-sh4eb -o audio -d 'If the model option is specified, -audio is a shortcut for configuring both t…'
complete -c qemu-system-sh4eb -o audiodev -d 'Adds a new audio backend driver identified by id'
complete -c qemu-system-sh4eb -o device -d 'Add device driver.  prop=value sets driver properties'
complete -c qemu-system-sh4eb -o name -d 'Sets the name of the guest'
complete -c qemu-system-sh4eb -o uuid -d 'Set system UUID'
complete -c qemu-system-sh4eb -o fdb -d 'Use file as floppy disk 0/1 image (see the \\%Disk Images chapter in the Syste…'
complete -c qemu-system-sh4eb -o hdd -d 'Use file as hard disk 0, 1, 2 or 3 image on the default bus of the emulated m…'
complete -c qemu-system-sh4eb -o cdrom -d 'Use file as CD-ROM image on the default bus of the emulated machine (which is…'
complete -c qemu-system-sh4eb -o blockdev -d 'Define a new block driver node'
complete -c qemu-system-sh4eb -o drive -d 'Define a new drive'
complete -c qemu-system-sh4eb -o mtdblock -d 'Use file as on-board Flash memory image'
complete -c qemu-system-sh4eb -o sd -d 'Use file as SecureDigital card image'
complete -c qemu-system-sh4eb -o snapshot -d 'Write to temporary files instead of disk image files'
complete -c qemu-system-sh4eb -o fsdev -d 'Define a new file system device.  Valid options are: NDENT 7. 0'
complete -c qemu-system-sh4eb -o virtfs -d 'Define a new virtual filesystem device and expose it to the guest using a vir…'
complete -c qemu-system-sh4eb -o iscsi -d 'Configure iSCSI session parameters'
complete -c qemu-system-sh4eb -o usb -d 'Enable USB emulation on machine types with an on-board USB host controller (i…'
complete -c qemu-system-sh4eb -o usbdevice -d 'Add the USB device devname, and enable an on-board USB controller if possible…'
complete -c qemu-system-sh4eb -o display -d 'Select type of display to use'
complete -c qemu-system-sh4eb -o nographic -d 'Normally, if QEMU is compiled with graphical window support, it displays outp…'
complete -c qemu-system-sh4eb -o spice -d 'Enable the spice remote desktop protocol.  Valid options are NDENT 7. 0'
complete -c qemu-system-sh4eb -o portrait -d 'Rotate graphical output 90 deg left (only PXA LCD)'
complete -c qemu-system-sh4eb -o rotate -d 'Rotate graphical output some deg left (only PXA LCD)'
complete -c qemu-system-sh4eb -o vga -d 'Select type of VGA card to emulate.  Valid values for type are NDENT 7. 0'
complete -c qemu-system-sh4eb -o full-screen -d 'Start in full screen'
complete -c qemu-system-sh4eb -s g -d 'Set the initial graphical resolution and depth (PPC, SPARC only)'
complete -c qemu-system-sh4eb -o vnc -d 'Normally, if QEMU is compiled with graphical window support, it displays outp…'
complete -c qemu-system-sh4eb -o win2k-hack -d 'Use it when installing Windows 2000 to avoid a disk full bug'
complete -c qemu-system-sh4eb -o no-fd-bootchk -d 'Disable boot signature checking for floppy disks in BIOS'
complete -c qemu-system-sh4eb -o acpitable -d 'Add ACPI table with specified header fields and context from specified files'
complete -c qemu-system-sh4eb -o smbios -d 'Load SMBIOS entry from binary file'
complete -c qemu-system-sh4eb -o nic -d 'This option is a shortcut for configuring both the on-board (default) guest N…'
complete -c qemu-system-sh4eb -o netdev -d 'Configure user mode host network backend which requires no administrator priv…'
complete -c qemu-system-sh4eb -o net -d 'Legacy option to configure or create an on-board (or machine default) Network…'
complete -c qemu-system-sh4eb -o chardev -d 'Backend is one of: null, socket, udp, msmouse, vc, ringbuf, file, pipe, conso…'
complete -c qemu-system-sh4eb -o tpmdev -d 'The specific backend type will determine the applicable options'
complete -c qemu-system-sh4eb -o bios -d 'Set the filename for the BIOS'
complete -c qemu-system-sh4eb -o pflash -d 'Use file as a parallel flash image'
complete -c qemu-system-sh4eb -o kernel -d 'Use bzImage as kernel image'
complete -c qemu-system-sh4eb -o append -d 'Use cmdline as kernel command line'
complete -c qemu-system-sh4eb -o initrd -d 'Use file as initial ram disk'
complete -c qemu-system-sh4eb -o dtb -d 'Use file as a device tree binary (dtb) image and pass it to the kernel on boot'
complete -c qemu-system-sh4eb -o compat -d 'Set policy for handling deprecated management interfaces (experimental): NDEN…'
complete -c qemu-system-sh4eb -o fw_cfg -d 'Add named fw_cfg entry with contents from file file'
complete -c qemu-system-sh4eb -o serial -d 'Redirect the virtual serial port to host character device dev'
complete -c qemu-system-sh4eb -o parallel -d 'Redirect the virtual parallel port to host device dev (same devices as the se…'
complete -c qemu-system-sh4eb -o monitor -d 'Redirect the monitor to host device dev (same devices as the serial port)'
complete -c qemu-system-sh4eb -o qmp -d 'Like -monitor but opens in \'control\' mode'
complete -c qemu-system-sh4eb -o qmp-pretty -d 'Like -qmp but uses pretty JSON formatting'
complete -c qemu-system-sh4eb -o mon -d 'Set up a monitor connected to the chardev name'
complete -c qemu-system-sh4eb -o debugcon -d 'Redirect the debug console to host device dev (same devices as the serial por…'
complete -c qemu-system-sh4eb -o pidfile -d 'Store the QEMU process PID in file'
complete -c qemu-system-sh4eb -l preconfig -d 'Pause QEMU for interactive configuration before the machine is created, which…'
complete -c qemu-system-sh4eb -s S -d 'Do not start CPU at startup (you must type \'c\' in the monitor)'
complete -c qemu-system-sh4eb -o overcommit -d 'Run qemu with hints about host resource overcommit'
complete -c qemu-system-sh4eb -o gdb -d 'Accept a gdb connection on device dev (see the \\%GDB usage chapter in the Sys…'
complete -c qemu-system-sh4eb -s s -d 'Shorthand for -gdb \\%tcp::1234, i. e'
complete -c qemu-system-sh4eb -s d -d 'Enable logging of specified items.  Use \'-d help\' for a list of log items'
complete -c qemu-system-sh4eb -s D -d 'Output log in logfile instead of to stderr'
complete -c qemu-system-sh4eb -o dfilter -d 'Filter debug output to that relevant to a range of target addresses'
complete -c qemu-system-sh4eb -o seed -d 'Force the guest to use a deterministic pseudo-random number generator, seeded…'
complete -c qemu-system-sh4eb -s L -d 'Set the directory for the BIOS, VGA BIOS and keymaps'
complete -c qemu-system-sh4eb -o enable-kvm -d 'Enable KVM full virtualization support'
complete -c qemu-system-sh4eb -o xen-domid -d 'Specify xen guest domain id (XEN only)'
complete -c qemu-system-sh4eb -o xen-attach -d 'Attach to existing xen domain'
complete -c qemu-system-sh4eb -o no-reboot -d 'Exit instead of rebooting'
complete -c qemu-system-sh4eb -o no-shutdown -d 'Don\'t exit QEMU on guest shutdown, but instead only stop the emulation'
complete -c qemu-system-sh4eb -o action -d 'The action parameter serves to modify QEMU\'s default behavior when certain gu…'
complete -c qemu-system-sh4eb -o loadvm -d 'Start right away with a saved state (loadvm in monitor)'
complete -c qemu-system-sh4eb -o daemonize -d 'Daemonize the QEMU process after initialization'
complete -c qemu-system-sh4eb -o option-rom -d 'Load the contents of file as an option ROM'
complete -c qemu-system-sh4eb -o rtc -d 'Specify base as utc or localtime to let the RTC start at the current UTC or l…'
complete -c qemu-system-sh4eb -o icount -d 'Enable virtual instruction counter'
complete -c qemu-system-sh4eb -o watchdog-action -d 'The action controls what QEMU will do when the watchdog timer expires'
complete -c qemu-system-sh4eb -o echr -d 'Change the escape character used for switching to the monitor when using moni…'
complete -c qemu-system-sh4eb -o incoming -d 'Prepare for incoming migration, listen on a given tcp port'
complete -c qemu-system-sh4eb -o only-migratable -d 'Only allow migratable devices'
complete -c qemu-system-sh4eb -o nodefaults -d 'Don\'t create default devices'
complete -c qemu-system-sh4eb -o runas -d 'Immediately before starting guest execution, drop root privileges, switching …'
complete -c qemu-system-sh4eb -o prom-env -d 'Set OpenBIOS nvram variable to given value (PPC, SPARC only).  NDENT 7'
complete -c qemu-system-sh4eb -o semihosting -d 'Enable \\%Semihosting mode (ARM, M68K, Xtensa, MIPS, Nios II, RISC-V only)'
complete -c qemu-system-sh4eb -o semihosting-config -d 'Enable and configure \\%Semihosting (ARM, M68K, Xtensa, MIPS, Nios II, RISC-V …'
complete -c qemu-system-sh4eb -o old-param -d 'Old param mode (ARM only)'
complete -c qemu-system-sh4eb -o sandbox -d 'Enable Seccomp mode 2 system call filter'
complete -c qemu-system-sh4eb -o readconfig -d 'Read device configuration from file'
complete -c qemu-system-sh4eb -o no-user-config -d 'The -no-user-config option makes QEMU not load any of the user-provided confi…'
complete -c qemu-system-sh4eb -o trace -d 'Specify tracing options. sp [enable=]PATTERN NDENT 7. 0 NDENT 3'
complete -c qemu-system-sh4eb -o plugin -d 'Load a plugin.  NDENT 7. 0'
complete -c qemu-system-sh4eb -o run-with -d 'Set QEMU process lifecycle options'
complete -c qemu-system-sh4eb -o msg -d 'Control error message format.  NDENT 7. 0'
complete -c qemu-system-sh4eb -o dump-vmstate -d 'Dump json-encoded vmstate information for current machine type to file in file'
complete -c qemu-system-sh4eb -o enable-sync-profile -d 'Enable synchronization profiling'
complete -c qemu-system-sh4eb -o perfmap -d 'Generate a map file for Linux perf tools that will allow basic profiling info…'
complete -c qemu-system-sh4eb -o jitdump -d 'Generate a dump file for Linux perf tools that maps basic blocks to symbol na…'
complete -c qemu-system-sh4eb -o object -d 'Create a new object of type typename setting properties in the order they are…'
complete -c qemu-system-sh4eb -s M
complete -c qemu-system-sh4eb -o fda
complete -c qemu-system-sh4eb -o hda
complete -c qemu-system-sh4eb -o hdb
complete -c qemu-system-sh4eb -o hdc
complete -c qemu-system-sh4eb -s u -s l -s p -d 'QEMU writes something to that port it will appear in the netconsole session'
complete -c qemu-system-sh4eb -s P -s t -s I -s T
complete -c qemu-system-sh4eb -o kernel/-append -d 'still supported for backward compatibility.  If both the'
complete -c qemu-system-sh4eb -l semihosting-config -d 'specified, the former is passed to semihosting as it always takes precedence'

