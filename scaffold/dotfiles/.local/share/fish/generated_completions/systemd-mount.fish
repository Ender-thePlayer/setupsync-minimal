# systemd-mount
# Autogenerated from man page /usr/share/man/man1/systemd-mount.1.gz
complete -c systemd-mount -l no-block -d 'Do not synchronously wait for the requested operation to finish'
complete -c systemd-mount -s l -l full -d 'Do not ellipsize the output when --list is specified. sp Added in version 245'
complete -c systemd-mount -l no-pager -d 'Do not pipe output into a pager'
complete -c systemd-mount -l no-legend -d 'Do not print the legend, i. e.  column headers and the footer with hints'
complete -c systemd-mount -l no-ask-password -d 'Do not query the user for authentication for privileged operations'
complete -c systemd-mount -l quiet -s q -d 'Suppresses additional informational output while running'
complete -c systemd-mount -l discover -d 'Enable probing of the mount source'
complete -c systemd-mount -l type -s t -d 'Specifies the file system type to mount (e. g.  "vfat" or "ext4")'
complete -c systemd-mount -l options -s o -d 'Additional mount options for the mount point. sp Added in version 232'
complete -c systemd-mount -l owner -d 'Let the specified user USER own the mounted file system'
complete -c systemd-mount -l fsck -d 'Takes a boolean argument, defaults to on'
complete -c systemd-mount -l description -d 'Provide a description for the mount or automount unit'
complete -c systemd-mount -l property -s p -d 'Sets a unit property for the mount unit that is created'
complete -c systemd-mount -l automount -d 'Takes a boolean argument'
complete -c systemd-mount -s A -d 'Equivalent to --automount=yes. sp Added in version 232'
complete -c systemd-mount -l timeout-idle-sec -d 'Takes a time value that controls the idle timeout in automount mode'
complete -c systemd-mount -l automount-property -d 'Similar to --property=, but applies additional properties to the automount un…'
complete -c systemd-mount -l bind-device -d 'This option only has an effect in automount mode, and controls whether the au…'
complete -c systemd-mount -l list -d 'Instead of establishing a mount or automount point, print a terse list of blo…'
complete -c systemd-mount -s u -l umount -d 'Stop the mount and automount units corresponding to the specified mount point…'
complete -c systemd-mount -s G -l collect -d 'Unload the transient unit after it completed, even if it failed'
complete -c systemd-mount -s T -l tmpfs -d 'Create and mount a new tmpfs file system on WHERE, with an optional NAME that…'
complete -c systemd-mount -l user -d 'Talk to the service manager of the calling user, rather than the service mana…'
complete -c systemd-mount -l system -d 'Talk to the service manager of the system.  This is the implied default'
complete -c systemd-mount -s H -l host -d 'Execute the operation remotely'
complete -c systemd-mount -s M -l machine -d 'Execute operation on a local container'
complete -c systemd-mount -s h -l help -d 'Print a short help text and exit'
complete -c systemd-mount -l version -d 'Print a short version string and exit'

