source 'http://rubygems.org'
gem 'rails', '3.0.1'

gem 'nokogiri', '1.4.3.1'
gem 'haml', '3.0.23'
gem 'cancan', '1.4.0'
gem 'paperclip', '2.3.5'
gem 'state_machine', '0.9.4'

# Solves the to_key problem
gem 'authlogic', :path => File.join(File.dirname(__FILE__), '/vendor/gems/authlogic')

group :development, :test do
  gem 'mysql', '2.8.1'
  gem 'rspec-rails', '>=2.0.0'
end

group :test do
  gem 'test-unit', '2.1.1'
  gem 'rspec', '>=2.0.0'
end

group :staging, :production do
  gem "pg"
end
