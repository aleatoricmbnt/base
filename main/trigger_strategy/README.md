## Workspace settings

#### Set Trigger strategy > Patterns

```
**/trigger_strategy/**/*
*
!**/main[1-9].tf
```

## Change / Run:
| File to change                          | Run |
|-----------------------------------------|-----|
| /main/trigger_strategy/some.tf          | ✅  |
| /dummy.file                             | ✅  |
| /main/trigger_strategy/data/main0.tf    | ✅  |
| /main/trigger_strategy/data/main2.tf    | ❌  |
| /main/local_wait/main.tf                | ❌  |
