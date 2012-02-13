
namespace :brant do

desc "Create dir to hold migrations and hidden file for current migration"
task :init do
  
  unless File.exists? Brant.rootPath
    Dir.mkdir(Brant.rootPath)
  end

  unless File.exists? Brant.migrationsPath
    Dir.mkdir(Brant.migrationsPath)
  end

  unless File.exists? Brant.migrationsConfigPath
    FileUtils.touch(Brant.migrationsConfigPath)
  end
end

desc "Run all pending migrations"
task :migrate do
  existing_migrations = Brant::MigrationFile.existing

  puts ""

  Brant::MigrationFile.all.values.sort.each do |migration|

    puts "Migrating to " + migration.klass + " - " + migration.timestamp

    unless existing_migrations[migration.timestamp]
      begin
        puts "Running migration " + migration.klass

        require File.join(Brant.migrationsPath,migration.filename)
        Object.const_get(migration.klass).send(:up) 

        existing_migrations[migration.timestamp] = true
      rescue
        puts "Failed to execute migration " + migration.klass
      end
    end
  end

  Brant::MigrationFile.update(existing_migrations.keys.sort)
end

end
