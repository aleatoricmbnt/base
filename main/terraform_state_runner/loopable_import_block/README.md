## Steps to test
1. Create 3 environments in Scalr (manually) with the following names: **uat**, **staging**, **prod**.
2. Apply run with Opentofu 1.7.0 (change IDs to the respective ones)
3. Verify that all 3 environments are present in the state file and can be now managed via terraform