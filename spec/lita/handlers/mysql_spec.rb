require 'spec_helper'

describe Lita::Handlers::Mysql, lita_handler: true do
  it { routes_command('mysql host add foo bar baz bat').to(:host_add) }
end
