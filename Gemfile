source "http://rubygems.org"

group :development, :test do
  gem 'rake', '< 10.2.0',       :require => false
  gem 'rspec-puppet',           :require => false, :git => 'https://github.com/rodjek/rspec-puppet.git'
  gem 'puppetlabs_spec_helper', :require => false
  gem 'puppet-lint',            :require => false
  gem 'puppet-syntax',          :require => false
  gem 'travis-lint',            :require => false
  gem 'simplecov',              :require => false
  gem 'coveralls',              :require => false
end

group :development do
  gem 'beaker',                 :require => false
  gem 'beaker-rspec',           :require => false
  # specinfra required until specinfra-1.0.2 is released
  # Ref: https://github.com/serverspec/specinfra/pull/77
  gem 'specinfra',              :require => false, :git => 'https://github.com/serverspec/specinfra.git', :ref => '679770067f'
  gem 'system_timer',           :require => false
  gem 'vagrant-wrapper',        :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end
