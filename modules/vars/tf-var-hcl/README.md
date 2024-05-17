| Key | Value |
|-----------------|-----------------|
| `bool`  | ```true```  |
| `bool_sensitive`  | ```true```  |
| `key_name`  | ```beep-boop```  |
| `list`  | ```[<br>    {<br>      password-length = 25<br>      password-special = true<br>      password-override-special = "!#$%&*()-_=+[]{}<>:?"<br>    }<br>  ]```  |
| Row 3 Column 1  | Row 3 Column 2  |
| Row 2 Column 1  | Row 2 Column 2  |
| Row 3 Column 1  | Row 3 Column 2  |
| Row 2 Column 1  | Row 2 Column 2  |
| Row 3 Column 1  | Row 3 Column 2  |
| Row 2 Column 1  | Row 2 Column 2  |
| Row 3 Column 1  | Row 3 Column 2  |


`map_object`
```
{
  "AIMS" = {
    cidr     = "10.162.40.0/22"
    zone     = "abc"
    tags     = {
      environment = "DR"
      project = "InterPac"
    }
    cidr_app = "10.162.40.0/24"
    gw_app   = "10.162.40.1"
    cidr_db = "10.162.41.0/24"
    gw_db   = "10.162.41.1"
  }
}
```

`sens-list-hcl`
```
["us-west-1a", "us-west-1c", "us-west-1d", "us-west-1e"]
```
`list-untyped`
```
["a", 15, true]
```
`sens-object`
```
{
  id = "id-ywe3jkf"
  labels = {
    user = "test"
    env = "staging"
  }
  size = 256
}
```
`keys-list`
```
["key1", "key2", "key3", "key4"]
```
`type-any`
```
{
  name = "example_name"
  metadata = {
    version = "1.0"
    tags = {
      env = "production"
      project = "example_project"
    }
    nested_metadata = {
      created_by = "admin"
      created_at = "2024-05-16"
      permissions = [
        {
          user = "user1"
          access_level = "read"
        },
        {
          user = "user2"
          access_level = "write"
        }
      ]
    }
  }
  configuration = {
    settings = [
      {
        key = "setting1"
        value = "value1"
      },
      {
        key = "setting2"
        value = "value2"
      }
    ]
    options = {
      enable_feature_x = true
      feature_x_settings = {
        settingA = "A"
        settingB = "B"
      }
    }
  }
}
```
`with-optional-attribute`
```
{
  a = "some string (b attribute should be missing)"
}
```