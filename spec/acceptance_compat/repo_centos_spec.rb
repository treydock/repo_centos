require 'spec_helper_acceptance'

describe 'repo_centos class' do
  context 'default parameters' do
    it 'should run successfully' do
      pp =<<-EOS
        package { 'httpd': ensure => present }
        class { 'repo_centos': }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    # Enabled by default
    [
      'base',
      'extras',
      'updates',
    ].each do |repo|
      describe yumrepo(repo) do
        it { should exist }
        it { should be_enabled }
      end
    end

    # Disabled by default
    [
      'centosplus',
      'fasttrack',
      'base-debuginfo',
    ].each do |repo|
      describe yumrepo(repo) do
        it { should exist }
        it { should_not be_enabled }
      end
    end

    # Not present by default
    [
      'scl',
      'centos-base-source',
      'centos-updates-source',
    ].each do |repo|
      describe yumrepo(repo) do
        it { should_not exist }
      end
    end

    # cr only on EL 7 by default
    describe yumrepo('cr') do
      if fact('operatingsystemmajrelease') >= '7'
        it { should exist }
        it { should_not be_enabled }
      else
        it { should_not exist }
      end
    end

    # centos-contrib only on EL 5 and 6
    describe yumrepo('contrib') do
      if fact('operatingsystemmajrelease') <= '6'
        it { should exist }
        it { should_not be_enabled }
      end
      else
        it { should_not exist }
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
