# eu-srcfiles
# Autogenerated from man page /usr/share/man/man1/eu-srcfiles.1.gz
complete -c eu-srcfiles -l core -d 'Find addresses from signatures found in COREFILE'
complete -c eu-srcfiles -l debuginfo-path -d 'Search path for separate debuginfo files'
complete -c eu-srcfiles -s e -l executable -d 'Find addresses in FILE'
complete -c eu-srcfiles -s k -l kernel -d 'Find addresses in the running kernel'
complete -c eu-srcfiles -s K -l offline-kernel -d 'Kernel with all modules'
complete -c eu-srcfiles -s M -l linux-process-map -d 'Find addresses in files mapped as read from FILE in Linux /proc/PID/maps form…'
complete -c eu-srcfiles -s p -l pid -d 'Find addresses in files mapped into process PID'
complete -c eu-srcfiles -s '?' -l help -d 'Give this help list'
complete -c eu-srcfiles -l usage -d 'Give a short usage message'
complete -c eu-srcfiles -s V -l version -d 'Print program version'
complete -c eu-srcfiles -s 0 -l null -d 'Separate items by a null instead of a newline'
complete -c eu-srcfiles -s b -l no-backup -d 'Disables local source file search when debuginfod fails to fetch files'
complete -c eu-srcfiles -s c -l cu-only -d 'Only list the CU (compilation unit) names'
complete -c eu-srcfiles -s v -l verbose -d 'Increase verbosity of logging messages'
complete -c eu-srcfiles -s z -l zip -d 'Zip all the source files and send to stdout'

