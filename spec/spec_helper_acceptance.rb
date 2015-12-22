require 'beaker-rspec'

dir = File.expand_path(File.dirname(__FILE__))
Dir["#{dir}/acceptance/shared_examples/*.rb"].sort.each {|f| require f}

install_puppet_on(hosts, {:version => '3.8.3'})

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    puppet_module_install(:source => proj_root, :module_name => 'repo_centos')

    hosts.each do |host|
      on host, puppet('module', 'install', 'puppetlabs-stdlib'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module', 'install', 'puppetlabs-inifile'), { :acceptable_exit_codes => [0,1] }
      puppet_pp = <<-EOF
      ini_setting { 'puppet.conf/main/show_diff':
        ensure  => 'present',
        section => 'main',
        path    => '/etc/puppet/puppet.conf',
        setting => 'show_diff',
        value   => 'true',
      }
      EOF
      apply_manifest_on(host, puppet_pp, :catch_failures => true)
    end
  end
end
