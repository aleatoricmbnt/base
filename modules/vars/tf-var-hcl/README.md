<table>
  <tr>
    <th>Key</th>
    <th>Value</th>
  </tr>
  <tr>
    <td>map_object</td>
    <td><pre><code>{
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
}</code></pre></td>
  </tr>
  <tr>
    <td>list-hcl</td>
    <td><pre><code>[
    {
      password-length = 25
      password-special = true
      password-override-special = "!#$%&*()-_=+[]{}<>:?"
    }
  ]</code></pre></td>
  </tr>
  <tr>
    <td>sens-list-hcl</td>
    <td><pre><code>["us-west-1a", "us-west-1c", "us-west-1d", "us-west-1e"]</code></pre></td>
  </tr>
  <tr>
    <td>list-untyped</td>
    <td><pre><code>["a", 15, true]</code></pre></td>
  </tr>
  <tr>
    <td>sens-object</td>
    <td><pre><code>{
  id = "id-ywe3jkf"
  labels = {
    user = "test"
    env = "staging"
  }
  size = 256
}</code></pre></td>
  </tr>
  <tr>
    <td>keys-list</td>
    <td><pre><code>["key1", "key2", "key3", "key4"]</code></pre></td>
  </tr>
  <tr>
    <td>type-any</td>
    <td><pre><code>{
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
}</code></pre></td>
  </tr>
  <tr>
    <td>with-optional-attribute</td>
    <td><pre><code>{
  a = "some string (b attribute should be missing)"
}</code></pre></td>
  </tr>
</table>



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
`list-hcl`
```
[
    {
      password-length = 25
      password-special = true
      password-override-special = "!#$%&*()-_=+[]{}<>:?"
    }
  ]
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