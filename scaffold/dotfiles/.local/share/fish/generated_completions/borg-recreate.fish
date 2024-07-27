# borg-recreate
# Autogenerated from man page /usr/share/man/man1/borg-recreate.1.gz
complete -c borg-recreate -l list -d 'output verbose list of items (files, dirs, . )'
complete -c borg-recreate -l filter -d 'only display items with the given status characters (listed in borg create --…'
complete -c borg-recreate -s n -l dry-run -d 'do not change anything'
complete -c borg-recreate -s s -l stats -d 'print statistics at end'
complete -c borg-recreate -s e -l exclude -d 'exclude paths matching PATTERN'
complete -c borg-recreate -l exclude-from -d 'read exclude patterns from EXCLUDEFILE, one per line'
complete -c borg-recreate -l pattern -d 'include/exclude paths matching PATTERN'
complete -c borg-recreate -l patterns-from -d 'read include/exclude patterns from PATTERNFILE, one per line'
complete -c borg-recreate -l exclude-caches -d 'exclude directories that contain a CACHEDIR. TAG file (\\%http://www. bford'
complete -c borg-recreate -l exclude-if-present -d 'exclude directories that are tagged by containing a filesystem object with th…'
complete -c borg-recreate -l keep-exclude-tags -d 'if tag objects are specified with --exclude-if-present, don\'t omit the tag ob…'
complete -c borg-recreate -l target -d 'create a new archive with the name ARCHIVE, do not replace existing archive (…'
complete -c borg-recreate -s c -l checkpoint-interval -d 'write checkpoint every SECONDS seconds (Default: 1800)'
complete -c borg-recreate -l comment -d 'add a comment text to the archive'
complete -c borg-recreate -l timestamp -d 'manually specify the archive creation date/time (UTC, yyyy-mm-ddThh:mm:ss for…'
complete -c borg-recreate -s C -l compression -d 'select compression algorithm, see the output of the "borg help compression" c…'
complete -c borg-recreate -l recompress -d 'recompress data chunks according to MODE and --compression'
complete -c borg-recreate -l chunker-params -d 'rechunk using given chunker parameters (ALGO, CHUNK_MIN_EXP, CHUNK_MAX_EXP, H…'

