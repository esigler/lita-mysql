# Helper functions for lita-mysql
module MysqlHelper
  # Utility functions
  module Utility
    def alias_exists?(a)
      redis.exists(normalize_alias(a))
    end

    def save_host(a, fqdn, username, password)
      redis.hset(normalize_alias(a), 'fqdn', fqdn)
      redis.hset(normalize_alias(a), 'username', username)
      redis.hset(normalize_alias(a), 'password', password)
    end

    def delete_host(a)
      redis.del(normalize_alias(a))
    end

    def normalize_alias(a)
      "alias_#{a}"
    end

    def fetch_alias(a)
      redis.hgetall(normalize_alias(a))
    end

    def list_aliases
      raw_aliases = redis.keys('alias_*')
      raw_aliases.each { |a| a.gsub!(/^alias_/, '') }
      raw_aliases
    end
  end
end
