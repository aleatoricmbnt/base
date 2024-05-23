<table>
  <tr>
    <th>Key</th>
    <th>Value</th>
  </tr>
  <tr>
    <td>type_any</td>
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
</table>
