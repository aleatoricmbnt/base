# Description
Run triggers script on **PLAN** stage, that catches the SIGTERM signal and therefore prevents run from being canceled. So it's possible to test force-cancel on the plan stage instead of hook stage.
# Setup 
1. Set pre-plan custom hook `chmod +x script.sh`
2. Trigger run
3. Wait few seconds after the data source started reporting "Reading"
4. Click "Cancel"
5. Click "Force Cancel" once available