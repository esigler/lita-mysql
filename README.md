# lita-mysql

[![Build Status](https://img.shields.io/travis/esigler/lita-mysql/master.svg)](https://travis-ci.org/esigler/lita-mysql)
[![MIT License](https://img.shields.io/badge/license-MIT-brightgreen.svg)](https://tldrlegal.com/license/mit-license)
[![RubyGems :: RMuh Gem Version](http://img.shields.io/gem/v/lita-mysql.svg)](https://rubygems.org/gems/lita-mysql)
[![Coveralls Coverage](https://img.shields.io/coveralls/esigler/lita-mysql/master.svg)](https://coveralls.io/r/esigler/lita-mysql)
[![Code Climate](https://img.shields.io/codeclimate/github/esigler/lita-mysql.svg)](https://codeclimate.com/github/esigler/lita-mysql)
[![Gemnasium](https://img.shields.io/gemnasium/esigler/lita-mysql.svg)](https://gemnasium.com/esigler/lita-mysql)

[MySQL](https://example.com) database management handler for [Lita.io](https://github.com/jimmycuadra/lita).

## Installation

Add lita-mysql to your Lita instance's Gemfile:

``` ruby
gem "lita-mysql"
```

## Safty & security considerations

Attack surfaces:

1. MySQL credentials are stored in the Lita Redis instance
2. Anyone who can either impersonate or directly connect to your chat system
   can send limited (but possibly damaging) SQL queries to any MySQL host you
   configure.
3. There could exist a defect in either the plugin, or the stored procedures it
   uses, that could expose the ability to execute additional SQL statements.

Recommendations:

1. Make sure to provide MySQL credentials that are as small in scope as
   needed.  Read-only on a replication slave is a good idea to get comfortable
   and kick the tires.
2. If you don't need to provide backup, clone, drop, restore, and truncate
   functionality, consider disabling them (see below).

## Configuration

This plugin uses the bot's Redis instance to store host and credential
information.  You will need to configure at least one database host to use
the commands shown in 'Usage'.  You can do so by running:

```
mysql host add <name> <fqdn> <username> <password>
```

**NOTE**: There is no 'default' MySQL host - if you have configured more than one
database host, you will need to explicitly choose a host for all relevant
commands.

**NOTE**: Table backup, clone, drop, restore, and truncate require <INSERT SUPER
AWESOME THING HERE>, if you don't wish to allow these commands at all, you can disable
them in the Lita config:

```
config.handlers.mysql.enable_stored_procedures = false
```

## Usage

### Tables
```
mysql [host] backup <name>   - Takes a backup of table <name> on [host], requires confirmation
mysql [host] backup-list     - Shows all recent table backups on [host]
mysql [host] clone <name>    - Clones table <name> on [host], requires confirmation
mysql [host] drop <name>     - Drops table <name> on [host], requires confirmation
mysql [host] drop-list       - Shows all recent table drops on [host]
mysql [host] restore <name>  - Restores a backup from the list on [host], requires confirmation
mysql [host] table <name>    - Shows information for table <name> on [host]
mysql [host] tables          - Shows all tables on [host]
mysql [host] truncate <name> - Truncates table <name> on [host], requires confirmation
mysql [host] truncate-list   - Shows all recent table truncations on [host]
```

### Queries
```
mysql [host] gather          -
mysql [host] digest          -
mysql [host] digest-collect  -
mysql [host] digest-issue    -
mysql [host] explain <query> - Shows explain plan for <query> on [host]
mysql [host] profile <query> - Profiles <query> on [host] and shows results
```

### Statistics
```
mysql [host] cluster -
mysql [host] innodb  - Shows results of "status engine innodb" on [host]
```

### Processes
```
mysql [host] kill <pid>  - Kills process <pid> on [host], requires confirmation
mysql [host] kills       - Show all recent process kills on [host]
mysql [host] processlist - Show all running processes on [host]
```

### Configuration
```
mysql host add <name> <fqdn> <username> <password> - Adds a host with <name>, <name> must match [a-zA-Z0-9_-] (restricted to mysql_admins)
mysql host remove <name>                           - Removes the host <name> (restricted to mysql_admins)
mysql host list                                    - Shows all hosts
```

## License

[MIT](http://opensource.org/licenses/MIT)
