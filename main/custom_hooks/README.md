Tests are designed for agent. Some commands might not work on the server backend.

# TEST 1
Checks if different special special characters are correctly parsed.
## Setup 
Set the following custom hook:
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
Checks whether the software can be installed on agent via hook and if execution of the hook can be canceled manually.
> **Note:** ⚠️ Works only for the Docker and Kubernetes agents.
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
Checks if default curl usage is available (with quotes and `{}` characters)
## Setup 
Add the following custom hook to the workspace configuration and trigger run
```
curl -v --header "Content-Type: application/json" --data '{"workspace_name": "test-workspace"}' http://httpbin.org/post
```
## Verification
The console output for the hook should be similar to:
```
Executing pre-init hook...
~$ curl -v --header "Content-Type: application/json" --data '{"workspace_name": "test-workspace"}' http://httpbin.org/post
% Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
Dload  Upload   Total   Spent    Left  Speed
0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0*   Trying 44.217.66.37:80...
* Connected to httpbin.org (44.217.66.37) port 80 (#0)
> POST /post HTTP/1.1
> Host: httpbin.org
> User-Agent: curl/7.74.0
> Accept: */*
> Content-Type: application/json
> Content-Length: 36
> 
} [36 bytes data]
* upload completely sent off: 36 out of 36 bytes
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Date: Thu, 07 Mar 2024 19:12:12 GMT
< Content-Type: application/json
< Content-Length: 469
< Connection: keep-alive
< Server: gunicorn/19.9.0
< Access-Control-Allow-Origin: *
< Access-Control-Allow-Credentials: true
{
< 
  "args": {}, 
{ [469 bytes data]
100   505  100   469  100    36   1004     77 --:--:-- --:--:-- --:--:--  1081
  "files": {}, 
  "form": {}, 
* Connection #0 to host httpbin.org left intact
  "headers": {
    "Accept": "*/*", 
    "Content-Length": "36", 
    "Content-Type": "application/json", 
    "Host": "httpbin.org", 
    "User-Agent": "curl/7.74.0", 
    "X-Amzn-Trace-Id": "Root=1-65ea118c-6320eb922586345a6cf4a168"
  }, 
  "json": {
    "workspace_name": "test-workspace"
  }, 
  "origin": "<ip>>", 
  "url": "http://httpbin.org/post"
}
Exit code: 0
```
# TEST 4
Checks if all SCALR_ shell variables are automatically passed to agent run.
## Setup 
Add the following custom hook to the workspace configuration and trigger run
```
printenv | grep SCALR
```
## Verification
The console output for the hook should be following (check if all necessary variables are present):
```
SCALR_RUN_PHASE=plan
SCALR_RUN_MODE=apply
SCALR_RUN_VCS_BRANCH=
SCALR_RUN_ID=run-v0o9he4gi5m5jd6qn
SCALR_RUN_IS_DESTROY=0
SCALR_ACCOUNT_ID=acc-v0o9hb3pi2cveh5tt
SCALR_HOSTNAME=test.master.testenv.scalr.dev
SCALR_RUN_SOURCE=ui
SCALR_OIDC_TOKEN=***************
SCALR_TERRAFORM_OPERATION=init
SCALR_TOKEN=***************
TF_VAR_SCALR_OIDC_TOKEN=***************
SCALR_RUN_VCS_COMMIT=
```
# TEST 5
Checks if `.tfvars` value can be changed with `sed` hook. 
## Setup
Set var-file to dev.tfvars (in the workdir) and pre-plan hook. Then trigger the run:
```
echo && cat dev.tfvars && NEW_VALUE="hook.value"; VAR_FILE="dev.tfvars"; sed -i "/^custom_string\s*=/c\custom_string=\"$NEW_VALUE\"" $VAR_FILE && echo && cat dev.tfvars 
```
## Verification
```
Executing pre-init hook...
~$ echo && cat dev.tfvars && NEW_VALUE="hook.value"; VAR_FILE="dev.tfvars"; sed -i "/^custom_string\s*=/c\custom_string=\"$NEW_VALUE\"" $VAR_FILE && echo && cat dev.tfvars
custom_string = "dev.tfvars string"
custom_string="hook.value"
Exit code: 0
```
# TEST 6
Checks the agent OOM message.
> **Note:** ⚠️ It's easier to use with docker or k8s agents (because of config). DO NOT USE WITHOUT THE FOLLOWING STEP: set `-e SCALR_CONTAINER_TASK_MEM_LIMIT=256` if using `docker run` OR `--set agent.container_task_mem_limit=256` if using k8s agent
## Setup
Set custom hook and trigger the run:
```
python3 -c  "['abc' for _ in range(2**38)]; print('OOM killer is failed')"
```
## Verification
Note that Run memoty limits number should vary depending on the pre-config value you used
```
 Killed
Plan operation failed
Error: The Run has reached the memory limit, and this operation was aborted. Please ensure there is enough memory on the Scalr Agent instances and/or consider increasing 
the Run memory limits (256MB) for the Scalr Agent.
```

# TEST 7
Checks if hooks with relative paths can be correctly executed
## Setup
Set custom hook and trigger the run:
```
chmod +x ./subdir/subdir.sh && ./subdir/subdir.sh  && chmod +x ../scripts/create_dir.sh && ../scripts/create_dir.sh && echo && pwd &&  ls -la | grep script
```
## Verification
Console output should be as below. Note that `/opt/workdir/...` depends on your repo structure. The main idea is that the folder corresponds to your workdir and 2 folders are found with `grep`. Also, ensure that you have `scripts` folder along with `custom_hooks` (workdir):
```
Executing pre-init hook...
~$ chmod +x ./subdir/subdir.sh && ./subdir/subdir.sh  && chmod +x ../scripts/create_dir.sh && ../scripts/create_dir.sh && echo && pwd &&  ls -la | grep script
/opt/workdir/main/custom_hooks
drwxr-xr-x  2 997 997 4096 Mar 11 16:58 parent_script
drwxr-xr-x  2 997 997 4096 Mar 11 16:58 subdir_script
Exit code: 0
```
# TEST 8
Checks if force cancel works
## Setup
Set custom hook and trigger the run:
```
i=1; trap "echo BOOM" TERM SIGTERM; while true; do  echo "Waiting for signal: ${i}s"; i=$((i + 1)); sleep 1; done
```
## Verification
Cancel run once hook started reporting "Waiting for signal" and click "Force Cancel" when available

