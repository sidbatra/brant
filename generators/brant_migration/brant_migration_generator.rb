class BrantMigrationGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.directory 'pkggg'
    end
  end
end
