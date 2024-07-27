# cmake
# Autogenerated from man page /usr/share/man/man1/cmake.1.gz
complete -c cmake -s S -d 'Path to root directory of the CMake project to build'
complete -c cmake -s B -d 'Path to directory which CMake will use as the root of build directory'
complete -c cmake -s C -d 'Pre-load a script to populate the cache'
complete -c cmake -s D -s D -d 'Create or update a CMake CACHE entry'
complete -c cmake -o 'D<var>:<type>' -o 'D<var>'
complete -c cmake -s U -d 'Remove matching entries from CMake CACHE'
complete -c cmake -s G -d 'Specify a build system generator'
complete -c cmake -s T -d 'Toolset specification for the generator, if supported'
complete -c cmake -s A -d 'Specify platform name if supported by generator'
complete -c cmake -l toolchain -d 'Added in version 3. 21'
complete -c cmake -l install-prefix -d 'Added in version 3. 21'
complete -c cmake -o Wno-dev -d 'Suppress developer warnings'
complete -c cmake -o Wdev -d 'Enable developer warnings'
complete -c cmake -o Wdeprecated -d 'Enable deprecated functionality warnings'
complete -c cmake -o Wno-deprecated -d 'Suppress deprecated functionality warnings'
complete -c cmake -o Werror -d 'Treat CMake warnings as errors'
complete -c cmake -o Wno-error -d 'Do not treat CMake warnings as errors'
complete -c cmake -l fresh -d 'Added in version 3. 24.  Perform a fresh configuration of the build tree'
complete -c cmake -s L -d 'List non-advanced cached variables'
complete -c cmake -s N -d 'View mode only'
complete -c cmake -l graphviz -d 'Generate graphviz of dependencies, see X\'tty: link #module:CMakeGraphVizOptio…'
complete -c cmake -l system-information -d 'Dump information about this system'
complete -c cmake -l log-level -d 'Set the log <level>'
complete -c cmake -l log-context -d 'Enable the X\'tty: link #command:message\'%message()X\'tty: link\' command output…'
complete -c cmake -l debug-trycompile -d 'Do not delete the files and directories created for X\'tty: link #command:try_…'
complete -c cmake -l debug-output -d 'Put cmake in a debug mode'
complete -c cmake -l debug-find -d 'Added in version 3. 17.  Put cmake find commands in a debug mode'
complete -c cmake -l debug-find-pkg -d 'Added in version 3. 23'
complete -c cmake -l debug-find-var -d 'Added in version 3. 23'
complete -c cmake -l trace -d 'Put cmake in trace mode'
complete -c cmake -l trace-expand -d 'Put cmake in trace mode'
complete -c cmake -l trace-format -d 'Added in version 3. 17'
complete -c cmake -l trace-source -d 'Put cmake in trace mode, but output only lines of a specified file'
complete -c cmake -l trace-redirect -d 'Put cmake in trace mode and redirect trace output to a file instead of stderr'
complete -c cmake -l warn-uninitialized -d 'Warn about uninitialized values'
complete -c cmake -l warn-unused-vars -d 'Does nothing.   In CMake versions 3'
complete -c cmake -l no-warn-unused-cli -d 'Don\'t warn about command line options'
complete -c cmake -l check-system-vars -d 'Find problems with variable usage in system files'
complete -c cmake -l compile-no-warning-as-error -d 'Added in version 3. 24'
complete -c cmake -l profiling-output -d 'Added in version 3. 18'
complete -c cmake -l profiling-format -d 'Enable the output of profiling data of CMake script in the given format'
complete -c cmake -l preset -l preset -d 'Reads a X\'tty: link #manual:cmake-presets(7)\'%presetX\'tty: link\' from <path-t…'
complete -c cmake -l list-presets -d 'Lists the available presets of the specified <type>'
complete -c cmake -l debugger -d 'Enables interactive debugging of the CMake language'
complete -c cmake -l debugger-pipe -l debugger-pipe -d 'Name of the pipe (on Windows) or domain socket (on Unix) to use for debugger …'
complete -c cmake -l debugger-dap-log -l debugger-dap-log -d 'Logs all debugger communication to the specified file'
complete -c cmake -l build -d 'Project binary directory to be built'
complete -c cmake -s j -l parallel -d 'Added in version 3. 12'
complete -c cmake -s t -l target -d 'Build <tgt> instead of the default target'
complete -c cmake -l config -d 'For multi-configuration tools, choose configuration <cfg>'
complete -c cmake -l clean-first -d 'Build target clean first, then build.  (To clean only, use %--target clean. )'
complete -c cmake -l resolve-package-references -d 'Added in version 3. 23'
complete -c cmake -l use-stderr -d 'Ignored.   Behavior is default in CMake >= 3. 0'
complete -c cmake -s v -l verbose -d 'Enable verbose output - if supported - including the build commands to be exe…'
complete -c cmake -l install -d 'Project binary directory to install.  This is required and must be first'
complete -c cmake -l component -d 'Component-based install.  Only install component <comp>'
complete -c cmake -l default-directory-permissions -d 'Default directory install permissions'
complete -c cmake -l prefix -d 'Override the installation prefix, X\'tty: link #variable:CMAKE_INSTALL_PREFIX\'…'
complete -c cmake -l strip -d 'Strip before installing'
complete -c cmake -s P -d 'Process the given cmake file as a script written in the CMake language'
complete -c cmake -s E -d 'Run cmake -E or cmake -E help for a summary of commands'
complete -c cmake -l ignore-eol -d 'Added in version 3. 14'
complete -c cmake -l unset -d 'Unsets the current value of NAME'
complete -c cmake -l modify -d 'Added in version 3. 25'
complete -c cmake -l zstd -d 'Added in version 3. 15.  Compress the resulting archive with Zstandard'
complete -c cmake -l files-from -d 'Added in version 3. 1.  Read file names from the given file, one per line'
complete -c cmake -l format -d 'Added in version 3. 3.  Specify the format of the archive to be created'
complete -c cmake -l mtime -d 'Added in version 3. 1.  Specify modification time recorded in tarball entries'
complete -c cmake -l touch -d 'Added in version 3. 24'
complete -c cmake -l workflow -d 'Select a X\'tty: link #workflow-preset\'%Workflow PresetX\'tty: link\' using one …'
complete -c cmake -o version -l version -d 'Show program name/version banner and exit'
complete -c cmake -s h -s H -l help -o help -o usage -d 'Print usage information and exit'
complete -c cmake -l help-full -d 'Print all help manuals and exit'
complete -c cmake -l help-manual -d 'Print one help manual and exit'
complete -c cmake -l help-manual-list -d 'List help manuals available and exit'
complete -c cmake -l help-command -d 'Print help for one command and exit'
complete -c cmake -l help-command-list -d 'List commands with help available and exit'
complete -c cmake -l help-commands -d 'Print cmake-commands manual and exit'
complete -c cmake -l help-module -d 'Print help for one module and exit'
complete -c cmake -l help-module-list -d 'List modules with help available and exit'
complete -c cmake -l help-modules -d 'Print cmake-modules manual and exit'
complete -c cmake -l help-policy -d 'Print help for one policy and exit'
complete -c cmake -l help-policy-list -d 'List policies with help available and exit'
complete -c cmake -l help-policies -d 'Print cmake-policies manual and exit'
complete -c cmake -l help-property -d 'Print help for one property and exit'
complete -c cmake -l help-property-list -d 'List properties with help available and exit'
complete -c cmake -l help-properties -d 'Print cmake-properties manual and exit'
complete -c cmake -l help-variable -d 'Print help for one variable and exit'
complete -c cmake -l help-variable-list -d 'List variables with help available and exit'
complete -c cmake -l help-variables -d 'Print cmake-variables manual and exit'
