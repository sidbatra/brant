require 'fileutils'
require 'lib/brant/migration'

namespace :brant do

desc "Create dir to hold migrations and hidden file for current migration"
task :init do
  
  unless File.exists? Brant::Migration.rootPath
    Dir.mkdir(Brant::Migration.rootPath)
  end

  unless File.exists? Brant::Migration.migrationsPath
    Dir.mkdir(Brant::Migration.migrationsPath)
  end

  unless File.exists? Brant::Migration.migrationsConfigPath
    FileUtils.touch(Brant::Migration.migrationsConfigPath)
  end
end

end
