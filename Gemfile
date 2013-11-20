source 'https://rubygems.org'
gem 'rails', '3.2.12'
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
    gem 'sqlite3'
    gem 'debugger'
end

group :test do
    gem 'cucumber-rails', :require => false
    gem 'database_cleaner'
    gem "rspec-rails", "~> 2.0"
    gem 'factory_girl'
end

group :production do
    gem 'pg'
end
 
gem 'jquery-rails'
gem "email_spec", ">= 1.4.0", :group => :test
gem "launchy", ">= 2.2.0", :group => :test
gem "capybara", ">= 2.0.2", :group => :test
gem "factory_girl_rails", ">= 4.2.0", :group => [:development, :test]
gem "bootstrap-sass", ">= 2.3.0.0"
gem "devise", ">= 2.2.3"
gem "cancan", ">= 1.6.8"
gem "rolify", ">= 3.2.0"
gem "simple_form", ">= 2.0.4"
gem "quiet_assets", ">= 1.0.1", :group => :development
gem "figaro", ">= 0.5.3"
gem "better_errors", ">= 0.6.0", :group => :development
gem "binding_of_caller", ">= 0.7.1", :group => :development, :platforms => [:mri_19, :rbx]
gem 'rails_admin'

gem 'thin'

gem "d3-rails"
