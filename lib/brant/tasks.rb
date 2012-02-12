require 'fileutils'

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

end
