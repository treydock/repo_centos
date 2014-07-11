require 'spec_helper'

describe 'repo_centos::scl' do
  let :facts do
    {
      :operatingsystem            => 'CentOS',
      :operatingsystemmajrelease  => '6',
      :architecture               => 'x86_64',
    }
  end

  it { should create_class('repo_centos::scl') }
  it { should contain_class('repo_centos') }

  it do
    should contain_yumrepo('centos-scl').with({
      :baseurl  => 'http://mirror.centos.org/centos/6/SCL/x86_64',
      :descr    => "CentOS 6 The Software Collection - x86_64",
      :enabled  => '0',
      :gpgcheck => '1',
      :gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
    })
  end

  context 'when repourl => "http://foo.example.com/centos"' do
    let(:pre_condition) { "class { 'repo_centos': repourl => 'http://foo.example.com/centos' }"}

    it { should contain_yumrepo('centos-scl').with_baseurl('http://foo.example.com/centos/6/SCL/x86_64') }
  end

  context 'when enable_scl => true' do
    let(:pre_condition) { "class { 'repo_centos': enable_scl => true }"}

    it { should contain_yumrepo('centos-scl').with_enabled('1') }
  end

  context 'when operatingsystemmajrelease => 7' do
    let :facts do
      {
        :operatingsystem            => 'CentOS',
        :operatingsystemmajrelease  => '7',
        :architecture               => 'x86_64',
      }
    end

    it { should_not contain_yumrepo('centos-scl') }
  end

  context 'when operatingsystemmajrelease => 5' do
    let :facts do
      {
        :operatingsystem            => 'CentOS',
        :operatingsystemmajrelease  => '5',
        :architecture               => 'x86_64',
      }
    end

    it { should_not contain_yumrepo('centos-scl') }
  end
end
