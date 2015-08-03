ENV['RAILS_ENV'] ||= 'test'

require 'dummy/config/environment'
require 'test/unit'
require 'rails/test_help'
require 'devise_security_extension'

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.logger = Logger.new(nil)
ActiveRecord::Migrator.migrate(File.expand_path('../dummy/db/migrate', __FILE__))
