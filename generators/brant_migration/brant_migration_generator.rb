class BrantMigrationGenerator < Rails::Generator::Base

  # Perform validations on input 
  #
  def initialize(runtime_args, runtime_options = {})
    super

    unless @args.present?
      raise IOError, "Please include name of migration"
    end

    @name = @args.first 

    unless is_migration_unique?
      raise IOError, "A migration titled #{@name} already exists"
    end
  end

  # Test if a migration with the given name already exists
  #
  def is_migration_unique?
    !File.exists?(Brant.migrationsPath) ||
        !Dir.entries(Brant.migrationsPath).
        map{|f| f.split('_')[0..-2].join('_')}.
        include?(@name)
  end

  # Name of the migration file
  #
  def file_name
    @file ||= @name + '_' + 
                Time.now.strftime("%Y%m%M%S") + ("%04d" % rand(1000)) +
                '.rb'
  end

  # Name of the migration class within the new migration file
  #
  def class_name
    @name.camelize
  end


  # Generate various files & directories
  #
  def manifest
    record do |m|
      m.directory Brant.rootPath
      m.directory Brant.migrationsPath
      m.template 'migration.rb',File.join(Brant.migrationsPath,file_name)
    end
  end

end
