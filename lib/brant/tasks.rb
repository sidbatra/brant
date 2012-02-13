
namespace :brant do

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

desc "Undo the last migration"
task :rollback do
  existing_migrations = Brant::MigrationFile.existing
  all_migrations      = Brant::MigrationFile.all
      
  puts ""

  if existing_migrations.length > 0
    migration = all_migrations[existing_migrations.keys.sort.last]

    puts "Rolling back migration " + migration.klass

    begin
      require File.join(Brant.migrationsPath,migration.filename)
      Object.const_get(migration.klass).send(:down) 

      existing_migrations.delete(migration.timestamp)
    rescue
      puts "Failed to rollback migration " + migration.klass
    end
  end

  Brant::MigrationFile.update(existing_migrations.keys.sort)
end

end
