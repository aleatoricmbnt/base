# Setup
Add the following custom hook to the workspace configuration and trigger run
```
echo "Test special characters in commands: "  && echo "The date is: `date`" && cat file.txt | grep 'some.*string' && echo "The current directory is: $(pwd)" && echo "He said, \"BEEP BOOP!\"" && echo 'This is a single-quoted string with special characters *&^%'
```
# Verification
The console output for the hook should be following (note that date will differ):
```
Test special characters in commands:
The date is: Thu Mar  7 18:35:44 UTC 2024
some_other_string
The current directory is: /opt/workdir/main/custom_hooks
He said, "BEEP BOOP!"
This is a single-quoted string with special characters *&^%
```
