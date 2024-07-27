# borgfs
# Autogenerated from man page /usr/share/man/man1/borgfs.1.gz
complete -c borgfs -s V -l version -d 'show version number and exit'
complete -c borgfs -l consider-checkpoints -d 'Show checkpoint archives in the repository contents list (default: hidden)'
complete -c borgfs -s f -l foreground -d 'stay in foreground, do not daemonize'
complete -c borgfs -s o -d 'Extra mount options'
complete -c borgfs -l numeric-owner -d 'deprecated, use --numeric-ids instead'
complete -c borgfs -l numeric-ids -d 'use numeric user and group identifiers from archive(s)'
complete -c borgfs -s P -l prefix -d 'only consider archive names starting with this prefix.  (deprecated)'
complete -c borgfs -s a -l glob-archives -d 'only consider archive names matching the glob'
complete -c borgfs -l sort-by -d 'Comma-separated list of sorting keys; valid keys are: timestamp, archive, nam…'
complete -c borgfs -l first -d 'consider first N archives after other filters were applied'
complete -c borgfs -l last -d 'consider last N archives after other filters were applied'
complete -c borgfs -s e -l exclude -d 'exclude paths matching PATTERN'
complete -c borgfs -l exclude-from -d 'read exclude patterns from EXCLUDEFILE, one per line'
complete -c borgfs -l pattern -d 'include/exclude paths matching PATTERN'
complete -c borgfs -l patterns-from -d 'read include/exclude patterns from PATTERNFILE, one per line'
complete -c borgfs -l strip-components -d 'Remove the specified number of leading path elements'
