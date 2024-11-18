terraform {
  source = "./" 
}

inputs = {
  bool                         = true
  key_name                     = "beep-boop"
  list                         = [
    {
      password-length          = 25
      password-special         = true
      password-override-special = "!#$%&*()-_=+[]{}<>:?"
    }
  ]
  list_string                  = ["secret1", "secret2", "secret3"]
  list_untyped                 = ["a", 15, true]
  map_object                   = {
    "AIMS" = {
      cidr     = "10.162.40.0/22"
      zone     = "abc"
      tags     = {
        environment = "DR"
        project     = "InterPac"
      }
      cidr_app = "10.162.40.0/24"
      gw_app   = "10.162.40.1"
      cidr_db  = "10.162.41.0/24"
      gw_db    = "10.162.41.1"
    }
  }
  nested_object                = {
    id     = "id-ywe3jkf"
    labels = {
      user = "test"
      env  = "staging"
    }
    size = 256
  }
  nullable                     = null
  number                       = 13
  object_with_optional_attribute = {
    a = "some string (b attribute should be missing)"
  }
  string                       = "example_string"
  type_any                     = {
    name       = "example_name"
    metadata   = {
      version          = "1.0"
      tags             = {
        env            = "production"
        project        = "example_project"
      }
      nested_metadata  = {
        created_by     = "admin"
        created_at     = "2024-05-16"
        permissions    = [
          { user = "user1", access_level = "read" },
          { user = "user2", access_level = "write" }
        ]
      }
    }
    configuration = {
      settings = [
        { key = "setting1", value = "value1" },
        { key = "setting2", value = "value2" }
      ]
      options = {
        enable_feature_x     = true
        feature_x_settings = {
          settingA = "A"
          settingB = "B"
        }
      }
    }
  }
}
