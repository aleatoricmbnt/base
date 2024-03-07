# Setup
Add the following custom hook to the workspace configuration and trigger run
```
echo "Test special characters in commands: " && echo {1..5} && echo "The date is: `date`" && ls | grep ?.txt && ls | grep *.txt && echo "The current directory is: $(pwd)" && echo "He said, \"DOBROGO VECHORA!\"" && echo 'This is a single-quoted string with special characters *&^%'
```
# Verification
The console output for the hook should be following:
```

```
