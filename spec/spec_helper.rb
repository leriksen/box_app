require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

  RSpec.configure do |config|
    config.use_transactional_fixtures = true

    config.infer_base_class_for_anonymous_controllers = false

    config.order = "random"

    # Include the Capybara DSL so that specs in spec/requests still work.
    # config.include Capybara::DSL

    config.include FactoryGirl::Syntax::Methods

    # Disable the old-style object.should syntax.
    config.expect_with :rspec do |c|
      c.syntax = :expect
    end
  end
end

Spork.each_run do
  load "#{Rails.root}/config/routes.rb"
  Dir["#{Rails.root}/app/**/*.rb"].each {|f| load f}
  Dir["#{Rails.root}/lib/**/*.rb"].each {|f| load f}

  # This code will be run each time you run your specs.
  RSpec.configure do |config|
    config.mock_with :rspec

    config.use_transactional_fixtures = true
  end
end