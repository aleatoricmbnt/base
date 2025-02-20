# Hook Scripts Documentation

This directory contains multiple hook scripts designed to run sequentially. Each script performs a specific task, and they are interconnected as follows:

```
set_random_env_var.sh → export_env_vars_to_file.sh → install_jq_and_parse_response.sh
```


## 📜 Script Overview

### **1. `set_random_env_var.sh`**
- **Purpose:** Generates a random environment variable (`ALLOW_RUN`) with a value of `0` or `1`.
- **Calls:** `export_env_vars_to_file.sh` after setting the variable.

### **2. `export_env_vars_to_file.sh`**
- **Purpose:** Captures all environment variables and saves them to a timestamped file.
- **Calls:** `./nested/install_jq_and_parse_response.sh` to ensure `jq` is installed and fetch an API response.

### **3. `install_jq_and_parse_response.sh`**
- **Purpose:** Installs `jq` if missing and makes a `GET` request to:
```
https://{SCALR_HOSTNAME}/api/iacp/v3/workspaces/{SCALR_WORKSPACE_ID}
```
- Extracts the `created-by-email` field from the JSON response.

## ⚙️ How to Use

### 1. **Ensure all scripts have execute permissions:**
 ```bash
 chmod +x nested/*.sh
 ```
### 2. **Attach script to the workspace:**
 - Execution directory: Hook
 - Phase: pre-plan
### 3. **Expected Flow:**
 - `set_random_env_var.sh` sets `ALLOW_RUN` (`0` or `1`).
 - Calls `export_env_vars_to_file.sh`, which saves environment variables to a file.
 - Calls `install_jq_and_parse_response.sh`, ensuring `jq` is installed and fetching API data.
