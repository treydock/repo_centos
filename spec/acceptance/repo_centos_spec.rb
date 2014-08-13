require 'spec_helper_acceptance'

describe 'repo_centos class' do
  context 'default parameters' do
    it 'should run successfully' do
      pp =<<-EOS
        package { 'httpd': ensure => present }
        class { 'repo_centos': }
      EOS

      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    # Enabled by default
    [
      'centos-base',
      'centos-extras',
      'centos-updates',
    ].each do |repo|
      describe yumrepo(repo) do
        it { should exist }
        it { should be_enabled }
      end
    end

    # Disabled by default
    [
      'centos-contrib',
      'centos-cr',
      'centos-plus',
      'centos-base-source',
      'centos-updates-source',
      'centos-debug',
    ].each do |repo|
      describe yumrepo(repo) do
        it { should exist }
        it { should_not be_enabled }
      end
    end

    # centos-scl only tested when EL 6 or greater
    if fact('operatingsystemrelease').to_i >= 6.0
      describe yumrepo('centos-scl') do
        it { should exist }
        it { should_not be_enabled }
      end
    end

    # Test files are correctly removed
    [
      "/etc/yum.repos.d/centos#{fact('operatingsystemmajrelease')}.repo",
      "/etc/yum.repos.d/CentOS-Base.repo",
      "/etc/yum.repos.d/CentOS-Vault.repo",
      "/etc/yum.repos.d/CentOS-Debuginfo.repo",
      "/etc/yum.repos.d/CentOS-Media.repo",
      "/etc/yum.repos.d/CentOS-Sources.repo",
      "/etc/yum.repos.d/CentOS-SCL.repo",
    ].each do |repo_file|
      describe file(repo_file) do
        it { should_not be_file }
      end
    end
  end
end
