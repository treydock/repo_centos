require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'

include RspecPuppetFacts

PUPPET_VERSION = Gem.loaded_specs['puppet'].version.to_s

dir = File.expand_path(File.dirname(__FILE__))

Dir["#{dir}/support/*.rb"].sort.each { |f| require f }

at_exit { RSpec::Puppet::Coverage.report! }
