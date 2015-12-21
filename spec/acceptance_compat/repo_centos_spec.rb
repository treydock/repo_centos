require 'spec_helper_acceptance_compat'

describe 'repo_centos class' do
  context '3.x' do
    it 'should run successfully' do
      pp =<<-EOS
        class { 'repo_centos': }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end

  context '4.x' do
    it 'should run successfully' do
      fix_pp =<<-EOS
        exec { 'reinstall centos-release':
          path    => '/usr/bin:/bin:/usr/sbin:/sbin',
          command => 'yum -y reinstall centos-release ; [ -f /etc/yum.repos.d/CentOS-Base.repo ] || yum -y update centos-release',
          creates => '/etc/yum.repos.d/CentOS-Base.repo',
        }
      EOS
      pp =<<-EOS
        package { 'httpd': ensure => present }
        class { 'repo_centos': attempt_compatibility_mode => true }
      EOS

      proj_root = File.expand_path(File.join(File.dirname(__FILE__), '../..'))
      #apply_manifest(fix_pp, :catch_failures => true)
      #apply_manifest(fix_pp, :catch_changes => true)
      puppet_module_install(:source => proj_root, :module_name => 'repo_centos', :target_module_path => '/etc/puppetlabs/code/environments/production/modules')
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    it_behaves_like 'repo_centos-default'

    [
      'centos-base',
      'centos-contrib',
      'centos-cr',
      'centos-debug',
      'centos-extras',
      'centos-fasttrack',
      'centos-plus',
      'centos-scl',
      'centos-updates',
    ].each do |r|
      describe file("/etc/yum.repos.d/#{r}.repo") do
        it { should_not be_file }
      end

      describe yumrepo(r) do
        it { should_not exist }
      end
    end

  end
end
