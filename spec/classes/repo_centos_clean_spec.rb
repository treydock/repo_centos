require 'spec_helper'

describe 'repo_centos::clean' do
  let :facts do
    {
      :operatingsystem            => 'CentOS',
      :operatingsystemmajrelease  => '6',
      :architecture               => 'x86_64',
    }
  end

  let(:pre_condition) { "class { 'repo_centos': }" }

  it { should create_class('repo_centos::clean') }

  it { should contain_file('/etc/yum.repos.d/centos6.repo').with_ensure('absent') }
  it { should contain_file('/etc/yum.repos.d/CentOS-Base.repo').with_ensure('absent') }
  it { should contain_file('/etc/yum.repos.d/CentOS-Vault.repo').with_ensure('absent') }
  it { should contain_file('/etc/yum.repos.d/CentOS-Debuginfo.repo').with_ensure('absent') }
  it { should contain_file('/etc/yum.repos.d/CentOS-Media.repo').with_ensure('absent') }
  it { should contain_file('/etc/yum.repos.d/CentOS-Sources.repo').with_ensure('absent') }
  it { should contain_file('/etc/yum.repos.d/CentOS-SCL.repo').with_ensure('absent') }

  context 'when operatingsystemmajrelease => 7' do
    let :facts do
      {
        :operatingsystem            => 'CentOS',
        :operatingsystemmajrelease  => '7',
        :architecture               => 'x86_64',
      }
    end

    it { should contain_file('/etc/yum.repos.d/centos7.repo').with_ensure('absent') }
    it { should contain_file('/etc/yum.repos.d/CentOS-Base.repo').with_ensure('absent') }
    it { should contain_file('/etc/yum.repos.d/CentOS-Vault.repo').with_ensure('absent') }
    it { should contain_file('/etc/yum.repos.d/CentOS-Debuginfo.repo').with_ensure('absent') }
    it { should contain_file('/etc/yum.repos.d/CentOS-Media.repo').with_ensure('absent') }
    it { should contain_file('/etc/yum.repos.d/CentOS-Sources.repo').with_ensure('absent') }
    it { should contain_file('/etc/yum.repos.d/CentOS-SCL.repo').with_ensure('absent') }
  end

  context 'when operatingsystemmajrelease => 5' do
    let :facts do
      {
        :operatingsystem            => 'CentOS',
        :operatingsystemmajrelease  => '5',
        :architecture               => 'x86_64',
      }
    end

    it { should contain_file('/etc/yum.repos.d/centos5.repo').with_ensure('absent') }
    it { should contain_file('/etc/yum.repos.d/CentOS-Base.repo').with_ensure('absent') }
    it { should contain_file('/etc/yum.repos.d/CentOS-Vault.repo').with_ensure('absent') }
    it { should contain_file('/etc/yum.repos.d/CentOS-Debuginfo.repo').with_ensure('absent') }
    it { should contain_file('/etc/yum.repos.d/CentOS-Media.repo').with_ensure('absent') }
    it { should contain_file('/etc/yum.repos.d/CentOS-Sources.repo').with_ensure('absent') }
    it { should contain_file('/etc/yum.repos.d/CentOS-SCL.repo').with_ensure('absent') }
  end
end
