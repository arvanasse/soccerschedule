source 'http://rubygems.org'
gem 'rails', '~>3.2.1'

gem 'nokogiri', '~>1.5'
gem 'haml', '~>3.0'
gem 'sass', '~>3.0'
gem 'cancan', '1.4.0'
gem 'paperclip', '~>3.4.0'
gem 'state_machine', '0.9.4'

# Solves the to_key problem
gem "authlogic", :git => "git://github.com/binarylogic/authlogic.git"
 

group :development, :test do
  gem 'mysql', '2.8.1'
  gem 'rspec-rails'
end

group :test do
  gem 'test-unit'
  gem 'rspec'
end

group :staging, :production do
  gem "pg"
end
