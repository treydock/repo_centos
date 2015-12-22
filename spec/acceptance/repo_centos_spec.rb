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

    it_behaves_like 'repo_centos-default'
  end

  context 'ensure_source => present' do
    it 'should run successfully' do
      pp =<<-EOS
        package { 'httpd': ensure => present }
        class { 'repo_centos': ensure_source => 'present' }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe yumrepo('centos-base-source') do
      it { should exist }
      it { should_not be_enabled }
    end
    describe yumrepo('centos-updates-source') do
      it { should exist }
      it { should_not be_enabled }
    end

    describe file("/etc/yum.repos.d/CentOS-source.repo") do
      it { should be_file }
    end
  end

  if fact('operatingsystemmajrelease') == '6'
    context 'enable_scl => true' do
      it 'should run successfully' do
        pp =<<-EOS
          class { 'repo_centos': enable_scl => true }
        EOS

        apply_manifest(pp, :catch_failures => true)
        apply_manifest(pp, :catch_changes => true)
        on hosts, 'ls -la /etc/yum.repos.d/'
      end

      describe yumrepo('scl') do
        it { should exist }
        it { should be_enabled }
      end

      describe file("/etc/yum.repos.d/CentOS-SCL.repo") do
        it { should be_file }
      end
    end

    context 'remove SCL' do
      it 'should run successfully' do
        pp =<<-EOS
          class { 'repo_centos': }
        EOS

        apply_manifest(pp, :catch_failures => true)
        apply_manifest(pp, :catch_changes => true)
      end

      describe yumrepo('scl') do
        it { should_not exist }
        it { should_not be_enabled }
      end

      describe file("/etc/yum.repos.d/CentOS-SCL.repo") do
        it { should_not be_file }
      end
    end
  end
end
