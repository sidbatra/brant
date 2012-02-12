module Brant

  # Base class for all package migrations
  #
  class Migration

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

    # Stub method for running a migration
    #
    def up
    end

    # Stud method for rolling back a migration
    #
    def down
    end
  end

end
