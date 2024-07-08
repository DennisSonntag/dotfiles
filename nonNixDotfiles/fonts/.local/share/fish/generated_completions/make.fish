# make
# Autogenerated from man page /usr/share/man/man1/make.1.gz
complete -c make -s b -s m -d 'These options are ignored for compatibility with other versions of  make '
complete -c make -s B -l always-make -d 'Unconditionally make all targets'
complete -c make -s C -l directory -d 'Change to directory  dir before reading the makefiles or doing anything else'
complete -c make -s d -d 'Print debugging information in addition to normal processing'
complete -c make -l debug -d 'Print debugging information in addition to normal processing'
complete -c make -s e -l environment-overrides -d 'Give variables taken from the environment precedence over variables from make…'
complete -c make -s E -l eval -d 'Interpret string using the eval function, before parsing any makefiles'
complete -c make -s f -l file -l makefile -d 'Use  file as a makefile'
complete -c make -s i -l ignore-errors -d 'Ignore all errors in commands executed to remake files'
complete -c make -s I -l include-dir -d 'Specifies a directory  dir to search for included makefiles'
complete -c make -s j -l jobs -d 'Specifies the number of  jobs (commands) to run simultaneously'
complete -c make -l jobserver-style -d 'The style of jobserver to use'
complete -c make -s k -l keep-going -d 'Continue as much as possible after an error'
complete -c make -s l -l load-average -d 'Specifies that no new jobs (commands) should be started if there are others j…'
complete -c make -s L -l check-symlink-times -d 'Use the latest mtime between symlinks and target'
complete -c make -s n -l just-print -l dry-run -l recon -d 'Print the commands that would be executed, but do not execute them (except in…'
complete -c make -s o -l old-file -l assume-old -d 'Do not remake the file  file even if it is older than its dependencies, and d…'
complete -c make -s O -l output-sync -d 'When running multiple jobs in parallel with -j, ensure the output of each job…'
complete -c make -s p -l print-data-base -d 'Print the data base (rules and variable values) that results from reading the…'
complete -c make -s q -l question -d '``Question mode\'\''
complete -c make -s r -l no-builtin-rules -d 'Eliminate use of the built-in implicit rules'
complete -c make -s R -l no-builtin-variables -d 'Don\'t define any built-in variables'
complete -c make -s s -l silent -l quiet -d 'Silent operation; do not print the commands as they are executed'
complete -c make -l no-silent -d 'Cancel the effect of the -s option'
complete -c make -s S -l no-keep-going -l stop -d 'Cancel the effect of the  -k option'
complete -c make -s t -l touch -d 'Touch files (mark them up to date without really changing them) instead of ru…'
complete -c make -l trace -d 'Information about the disposition of each target is printed (why the target i…'
complete -c make -s v -l version -d 'Print the version of the  make program plus a copyright, a list of authors an…'
complete -c make -s w -l print-directory -d 'Print a message containing the working directory before and after other proce…'
complete -c make -l no-print-directory -d 'Turn off  -w , even if it was turned on implicitly'
complete -c make -l shuffle -d 'Enable shuffling of goal and prerequisite ordering'
complete -c make -s W -l what-if -l new-file -l assume-new -d 'Pretend that the target  file has just been modified'
complete -c make -l warn-undefined-variables -d 'Warn when an undefined variable is referenced'

