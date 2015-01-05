require 'lita'

Lita.load_locales Dir[File.expand_path(
  File.join('..', '..', 'locales', '*.yml'), __FILE__
)]

require 'mysql_helper/regex'
require 'mysql_helper/utility'

require 'lita/handlers/mysql'
