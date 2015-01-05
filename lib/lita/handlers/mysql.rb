module Lita
  module Handlers
    class Mysql < Handler
      namespace 'Mysql'

      include ::MysqlHelper::Regex
      include ::MysqlHelper::Utility

      route(
        /^mysql\salias\sadd\s#{ALIAS_PATTERN}\s#{FQDN_PATTERN}\s#{USERNAME_PATTERN}\s#{PASSWORD_PATTERN}$/,
        :alias_add,
        command: true,
        restrict_to: [:mysql_admins],
        help: {
          t('help.alias_add.syntax') => t('help.alias_add.desc')
        }
      )

      route(
        /^mysql\salias\sremove\s#{ALIAS_PATTERN}$/,
        :alias_remove,
        command: true,
        restrict_to: [:mysql_admins],
        help: {
          t('help.alias_remove.syntax') => t('help.alias_remove.desc')
        }
      )

      route(
        /^mysql\salias\slist$/,
        :alias_list,
        command: true,
        help: {
          t('help.alias_list.syntax') => t('help.alias_list.desc')
        }
      )

      def alias_add(response)
        a        = response.match_data['alias']
        fqdn     = response.match_data['fqdn']
        username = response.match_data['username']
        password = response.match_data['password']
        return response.reply(t('alias.exists', a: a)) if alias_exists?(a)
        save_host(a, fqdn, username, password)
        response.reply(t('alias.added', a: a))
      end

      def alias_remove(response)
        a = response.match_data['alias']
        return response.reply(t('alias.does_not_exist', a: a)) unless alias_exists?(a)
        delete_host(a)
        response.reply(t('alias.removed', a: a))
      end

      def alias_list(response)
        aliases = list_aliases
        return response.reply(t('alias.none_defined')) unless aliases.count > 0
        aliases.each do |a|
          info = fetch_alias(a)
          response.reply(t('alias.info', a: a, fqdn: info['fqdn']))
        end
      end
    end

    Lita.register_handler(Mysql)
  end
end
