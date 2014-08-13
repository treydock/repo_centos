require 'spec_helper'

describe 'repo_centos' do
  context 'when operatingsystemmajrelease => 7, os_maj_version => undef, and operatingsystemrelease => undef' do
    let :facts do
      {
        :operatingsystem            => 'CentOS',
        :operatingsystemrelease     => '7.0.1406',
        :operatingsystemmajrelease  => '7',
        :architecture               => 'x86_64',
      }
    end

    it_behaves_like 'centos7'
  end

  context 'when operatingsystemmajrelease => 6' do
    let :facts do
      {
        :operatingsystem            => 'CentOS',
        :operatingsystemrelease     => '6.5',
        :operatingsystemmajrelease  => '6',
        :architecture               => 'x86_64',
      }
    end

    it_behaves_like 'centos6'
  end

  context 'when os_maj_version => 5' do
    let :facts do
      {
        :operatingsystem        => 'CentOS',
        :os_maj_version         => '5',
        :architecture           => 'x86_64',
      }
    end

    it { should contain_gpg_key('RPM-GPG-KEY-CentOS-5').with_path('/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5') }
    it { should contain_file('/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5').with_source('puppet:///modules/repo_centos/RPM-GPG-KEY-CentOS-5') }
  end

  context 'when operatingsystem => "Fedora"' do
    let :facts do
      {
        :operatingsystem        => 'Fedora',
        :os_maj_version         => '20',
        :architecture           => 'x86_64',
      }
    end

    it { should have_class_count(2) }
    it { should have_file_resource_count(0) }
    it { should have_gpg_key_resource_count(0) }

    it { should_not contain_class('repo_centos::base') }
    it { should_not contain_class('repo_centos::contrib') }
    it { should_not contain_class('repo_centos::cr') }
    it { should_not contain_class('repo_centos::extras') }
    it { should_not contain_class('repo_centos::plus') }
    it { should_not contain_class('repo_centos::scl') }
    it { should_not contain_class('repo_centos::updates') }
    it { should_not contain_class('repo_centos::source') }
    it { should_not contain_class('repo_centos::debug') }
  end
end
