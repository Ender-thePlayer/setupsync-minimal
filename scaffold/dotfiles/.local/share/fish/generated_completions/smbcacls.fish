# smbcacls
# Autogenerated from man page /usr/share/man/man1/smbcacls.1.gz
complete -c smbcacls -s a -l add -d 'Add the entries specified to the ACL'
complete -c smbcacls -s M -l modify -d 'Modify the mask value (permissions) for the ACEs specified on the command line'
complete -c smbcacls -s D -l delete -d 'Delete any ACEs specified on the command line'
complete -c smbcacls -s S -l set -d 'This command sets the ACL on the object with only what is specified on the co…'
complete -c smbcacls -s C -l chown -d 'The owner of a file or directory can be changed to the name given using the -…'
complete -c smbcacls -s G -l chgrp -d 'The group owner of a file or directory can be changed to the name given using…'
complete -c smbcacls -s I -l inherit -d 'Set or unset the windows "Allow inheritable permissions" check box using the …'
complete -c smbcacls -l propagate-inheritance -d 'Add, modify, delete or set ACEs on an entire directory tree according to the …'
complete -c smbcacls -l save -d 'stores the DACLs in sddl format of the specified file or folder for later use…'
complete -c smbcacls -l restore -d 'applies the stored DACLS to files in directory'
complete -c smbcacls -l recurse -d 'indicates the operation is performed on directory and all files/directories b…'
complete -c smbcacls -l numeric -d 'This option displays all ACL information in numeric format'
complete -c smbcacls -s m -l max-protocol -d 'This allows the user to select the highest SMB protocol level that smbcacls w…'
complete -c smbcacls -s t -l test-args -d 'Don\\*(Aqt actually do anything, only validate the correctness of the arguments'
complete -c smbcacls -l query-security-info -d 'The security-info flags for queries'
complete -c smbcacls -l set-security-info -d 'The security-info flags for queries'
complete -c smbcacls -l sddl -d 'Output and input acls in sddl format'
complete -c smbcacls -l domain-sid -d 'SID used for sddl processing'
complete -c smbcacls -s x -l maximum-access -d 'When displaying an ACL additionally query the server for effective maximum pe…'
complete -c smbcacls -s '?' -l help -d 'Print a summary of command line options'
complete -c smbcacls -l usage -d 'Display brief usage message'
complete -c smbcacls -s d -l debuglevel -d 'level is an integer from 0 to 10'
complete -c smbcacls -l debug-stdout -d 'This will redirect debug output to STDOUT'
complete -c smbcacls -l configfile -d 'The file specified contains the configuration details required by the client'
complete -c smbcacls -l option -d 'Set the smb. conf(5) option "<name>" to value "<value>" from the command line'
complete -c smbcacls -s l -l log-basename -d 'Base directory name for log/debug files.  The extension "'
complete -c smbcacls -l leak-report -d 'Enable talloc leak reporting on exit'
complete -c smbcacls -l leak-report-full -d 'Enable full talloc leak reporting on exit'
complete -c smbcacls -s V -l version -d 'Prints the program version number'
complete -c smbcacls -s R -l name-resolve -d 'This option is used to determine what naming services and in what order to re…'
complete -c smbcacls -s O -l socket-options -d 'TCP socket options to set on the client socket'
complete -c smbcacls -s n -l netbiosname -d 'This option allows you to override the NetBIOS name that Samba uses for itself'
complete -c smbcacls -l netbios-scope -d 'This specifies a NetBIOS scope that nmblookup will use to communicate with wh…'
complete -c smbcacls -s W -l workgroup -d 'Set the SMB domain of the username'
complete -c smbcacls -s r -l realm -d 'Set the realm for the domain'
complete -c smbcacls -s U -l user -d 'Sets the SMB username or username and password'
complete -c smbcacls -s N -l no-pass -d 'If specified, this parameter suppresses the normal password prompt from the c…'
complete -c smbcacls -l password -d 'Specify the password on the commandline'
complete -c smbcacls -l pw-nt-hash -d 'The supplied password is the NT hash'
complete -c smbcacls -s A -l authentication-file -d 'This option allows you to specify a file from which to read the username and …'
complete -c smbcacls -s P -l machine-pass -d 'Use stored machine account password'
complete -c smbcacls -l simple-bind-dn -d 'DN to use for a simple bind'
complete -c smbcacls -l use-kerberos -d 'This parameter determines whether Samba client tools will try to authenticate…'
complete -c smbcacls -l use-krb5-ccache -d 'Specifies the credential cache location for Kerberos authentication'
complete -c smbcacls -l use-winbind-ccache -d 'Try to use the credential cache by winbind'
complete -c smbcacls -l client-protection -d 'Sets the connection protection the client tool should use'

