# ctest
# Autogenerated from man page /usr/share/man/man1/ctest.1.gz
complete -c ctest -l preset -l preset -d 'Use a test preset to specify test options'
complete -c ctest -l list-presets -d 'Lists the available test presets'
complete -c ctest -s C -l build-config -d 'Choose configuration to test'
complete -c ctest -l progress -d 'Enable short progress output from tests'
complete -c ctest -s V -l verbose -d 'Enable verbose output from tests'
complete -c ctest -o VV -l extra-verbose -d 'Enable more verbose output from tests'
complete -c ctest -l debug -d 'Displaying more verbose internals of CTest'
complete -c ctest -l output-on-failure -d 'Output anything outputted by the test program if the test should fail'
complete -c ctest -l stop-on-failure -d 'Stop running the tests when the first failure happens'
complete -c ctest -s F -d 'Enable failover'
complete -c ctest -s j -l parallel -d 'Run tests in parallel, optionally limited to a given level of parallelism'
complete -c ctest -l resource-spec-file -d 'Run CTest with %resource allocation enabled, using the %resource specificatio…'
complete -c ctest -l test-load -d 'While running tests in parallel (e. g'
complete -c ctest -s Q -l quiet -d 'Make CTest quiet'
complete -c ctest -s O -l output-log -d 'Output to log file'
complete -c ctest -l output-junit -d 'Added in version 3. 21.  Write test results in JUnit format'
complete -c ctest -s N -l show-only -d 'Disable actual execution of tests'
complete -c ctest -s L -l label-regex -d 'Run tests with labels matching regular expression as described under X\'tty: l…'
complete -c ctest -s R -l tests-regex -d 'Run tests matching regular expression'
complete -c ctest -s E -l exclude-regex -d 'Exclude tests matching regular expression'
complete -c ctest -o LE -l label-exclude -d 'Exclude tests with labels matching regular expression'
complete -c ctest -l tests-from-file -d 'Added in version 3. 29.  Run tests listed in the given file'
complete -c ctest -l exclude-from-file -d 'Added in version 3. 29.  Exclude tests listed in the given file'
complete -c ctest -o FA -l fixture-exclude-any -d 'Exclude fixtures matching <regex> from automatically adding any tests to the …'
complete -c ctest -o FS -l fixture-exclude-setup -d 'Same as %-FA except only matching setup tests are excluded'
complete -c ctest -o FC -l fixture-exclude-cleanup -d 'Same as %-FA except only matching cleanup tests are excluded'
complete -c ctest -s I -l tests-information -d 'Run a specific number of tests by number'
complete -c ctest -s U -l union -d 'Take the Union of %-I and %-R'
complete -c ctest -l rerun-failed -d 'Run only the tests that failed previously'
complete -c ctest -l repeat -d 'Run tests repeatedly based on the given <mode> up to <n> times'
complete -c ctest -l repeat-until-fail -d 'Equivalent to %--repeat until-fail:<n>'
complete -c ctest -l max-width -d 'Set the max width for a test name to output'
complete -c ctest -l interactive-debug-mode -d 'Set the interactive mode to 0 or 1'
complete -c ctest -l no-label-summary -d 'Disable timing summary information for labels'
complete -c ctest -l no-subproject-summary -d 'Disable timing summary information for subprojects'
complete -c ctest -l test-dir -d 'Added in version 3. 20'
complete -c ctest -l test-output-size-passed -d 'Added in version 3. 4.  Limit the output for passed tests to <size> bytes'
complete -c ctest -l test-output-size-failed -d 'Added in version 3. 4.  Limit the output for failed tests to <size> bytes'
complete -c ctest -l test-output-truncation -d 'Added in version 3. 24'
complete -c ctest -l overwrite -d 'Overwrite CTest configuration option'
complete -c ctest -l force-new-ctest-process -d 'Run child CTest instances as new processes'
complete -c ctest -l schedule-random -d 'Use a random order for scheduling tests'
complete -c ctest -l submit-index -d 'Legacy option for old Dart2 dashboard server feature.  Do not use'
complete -c ctest -l timeout -d 'Set the default test timeout'
complete -c ctest -l stop-time -d 'Set a time at which all tests should stop running'
complete -c ctest -l print-labels -d 'Print all available test labels'
complete -c ctest -l no-tests -d 'Regard no tests found either as error (when <action> is set to error) or igno…'
complete -c ctest -o version -l version -d 'Show program name/version banner and exit'
complete -c ctest -s h -s H -l help -o help -o usage -d 'Print usage information and exit'
complete -c ctest -l help-full -d 'Print all help manuals and exit'
complete -c ctest -l help-manual -d 'Print one help manual and exit'
complete -c ctest -l help-manual-list -d 'List help manuals available and exit'
complete -c ctest -l help-command -d 'Print help for one command and exit'
complete -c ctest -l help-command-list -d 'List commands with help available and exit'
complete -c ctest -l help-commands -d 'Print cmake-commands manual and exit'
complete -c ctest -l help-module -d 'Print help for one module and exit'
complete -c ctest -l help-module-list -d 'List modules with help available and exit'
complete -c ctest -l help-modules -d 'Print cmake-modules manual and exit'
complete -c ctest -l help-policy -d 'Print help for one policy and exit'
complete -c ctest -l help-policy-list -d 'List policies with help available and exit'
complete -c ctest -l help-policies -d 'Print cmake-policies manual and exit'
complete -c ctest -l help-property -d 'Print help for one property and exit'
complete -c ctest -l help-property-list -d 'List properties with help available and exit'
complete -c ctest -l help-properties -d 'Print cmake-properties manual and exit'
complete -c ctest -l help-variable -d 'Print help for one variable and exit'
complete -c ctest -l help-variable-list -d 'List variables with help available and exit'
complete -c ctest -l help-variables -d 'Print cmake-variables manual and exit'
complete -c ctest -l build-and-test -d 'Switch into the build and test mode'
complete -c ctest -l build-target -d 'Specify a specific target to build'
complete -c ctest -l build-nocmake -d 'Run the build without running cmake first'
complete -c ctest -l build-run-dir -d 'Specify directory to run programs from'
complete -c ctest -l build-two-config -d 'Run CMake twice'
complete -c ctest -l build-exe-dir -d 'Specify the directory for the executable'
complete -c ctest -l build-generator -d 'Specify the generator to use'
complete -c ctest -l build-generator-platform -d 'Specify the generator-specific platform'
complete -c ctest -l build-generator-toolset -d 'Specify the generator-specific toolset'
complete -c ctest -l build-project -d 'Specify the name of the project to build'
complete -c ctest -l build-makeprogram -d 'Specify the explicit make program to be used by CMake when configuring and bu…'
complete -c ctest -l build-noclean -d 'Skip the make clean step'
complete -c ctest -l build-config-sample -d 'A sample executable to use to determine the configuration that should be used'
complete -c ctest -l build-options -d 'Additional options for configuring the build (i. e'
complete -c ctest -l test-command -d 'The command to run as the test step with the %--build-and-test option'
complete -c ctest -l test-timeout -d 'The time limit in seconds'
complete -c ctest -s D -l dashboard -d 'Execute dashboard test'
complete -c ctest -s M -l test-model -d 'Sets the model for a dashboard'
complete -c ctest -s T -l test-action -d 'Sets the dashboard action to perform'
complete -c ctest -s S -l script -d 'Execute a dashboard for a configuration'
complete -c ctest -o SP -l script-new-process -d 'Execute a dashboard for a configuration'
complete -c ctest -l group -d 'Specify what group you\'d like to submit results to'
complete -c ctest -s A -l add-notes -d 'Add a notes file with submission'
complete -c ctest -l tomorrow-tag -d 'Nightly or Experimental starts with next day tag'
complete -c ctest -l extra-submit -d 'Submit extra files to the dashboard'
complete -c ctest -l http-header -d 'Added in version 3. 29.  Append HTTP header when submitting to the dashboard'
complete -c ctest -l 'http1.0' -d 'Submit using HTTP 1. 0'
complete -c ctest -l no-compress-output -d 'Do not compress test output when submitting'

