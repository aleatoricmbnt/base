# Produce multiple state files via pre-plan hook

## Instruction

1. Create run with applied status
2. Open state and copy strings:
```
{
    "version": 4,
    "terraform_version": "1.1.6",
    "serial": 1,
    "lineage": "6378832f-c96f-d892-c7cc-af9ca64fbaaa"
}
```
3. Create in repo `.tfsate` file with the contents above and push it 
4. Add pre-plan hook:
```
x=3 y=`expr $x + 10`; while  [ $x -le $y ]; do sed -i -e "s/\"serial\": .*/\"serial\": $x,/g" some-state.tfstate; terraform state push some-state.tfstate; x=`expr $x + 1`; sleep 1; done
```
5. Trigger new run