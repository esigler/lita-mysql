# Helper functions for lita-mysql
module MysqlHelper
  # Regular expressions
  module Regex
    ALIAS_PATTERN    = /(?<alias>\w+)/
    FQDN_PATTERN     = /(?<fqdn>[\w\.]+)/
    USERNAME_PATTERN = /(?<username>\w+)/
    PASSWORD_PATTERN = /(?<password>\w+)/
  end
end
