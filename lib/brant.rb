require 'brant/migration'
require 'active_support/core_ext/string/inflections.rb'

module Brant

    # Relative path of the root dir for packages
    #
    def self.rootPath
      'pkg'  
    end

    # Relative path of the dir that contains the migration files
    #
    def self.migrationsPath
      File.join(rootPath,'migrate')
    end

    # Relative path of the hidden file that contains the current migration
    #
    def self.migrationsConfigPath
      File.join(rootPath,'.migrations')
    end

end
