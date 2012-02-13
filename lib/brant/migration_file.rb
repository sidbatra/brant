module Brant
  
  # Representation of the actual file that stores a migration
  #
  class MigrationFile
    
    attr_accessor :filename, :klass, :timestamp

    # Returns hash of migration file objects of all defnied migrations
    # with their timestamps as the keys
    #
    def self.all
      migrations = {}

      if File.exists? Brant.migrationsPath
        Dir.entries(Brant.migrationsPath).each do |file|
          next if file.length < 3 || file.match(/^\./)
          migration = new(file)
          migrations[migration.timestamp] = migration
        end
      end

      migrations
    end

    # Returns a hash of migration timestamps that 
    # have been performed
    #
    def self.existing
      migrations = {}
      
      if File.exists? Brant.migrationsConfigPath
        File.open(Brant.migrationsConfigPath,'r') do |file|
          while(line = file.gets)
            migrations[line.chomp] = true
          end
        end
      end

      migrations
    end

    # Update migrations config to show all finished migrations
    #
    def self.update(migrations)
      File.open(Brant.migrationsConfigPath,'w') do |file|
        file.write migrations.join("\n")
      end
    end


    # Compare objects based on timestamp
    #
    def <=>(other)
      self.timestamp <=> other.timestamp
    end

    # Constructor logic
    #
    def initialize(filename)
      self.filename   = filename

      parts           = self.filename.split('_')
      self.timestamp  = parts.last.split('.').first
      self.klass      = parts[0..-2].join('_').camelize
    end
  end
end
