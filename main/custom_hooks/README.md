# TEST 1
## Setup 
Add the following custom hook to the workspace configuration and trigger run
```
echo "Test special characters in commands: "  && echo "The date is: `date`" && cat file.txt | grep 'some.*string' && echo "The current directory is: $(pwd)" && echo "He said, \"BEEP BOOP!\"" && echo 'This is a single-quoted string with special characters *&^%'
```
## Verification
The console output for the hook should be following (note that date will differ):
```
Test special characters in commands:
The date is: Thu Mar  7 18:35:44 UTC 2024
some_other_string
The current directory is: /opt/workdir/main/custom_hooks
He said, "BEEP BOOP!"
This is a single-quoted string with special characters *&^%
```
# TEST 2
## Setup 
Add the following custom hook to the workspace configuration, trigger run and cancel run some time after the ping started execution:
```
apt-get update && apt-get install -y iputils-ping && ping 8.8.8.8
```
## Verification
The console output for the hook should be following:
```
```
# TEST 3
## Setup 
Add the following custom hook to the workspace configuration and trigger run
```
```
## Verification
The console output for the hook should be following:
```
```
# TEST 4
## Setup 
Add the following custom hook to the workspace configuration and trigger run
```
```
## Verification
The console output for the hook should be following:
```
```