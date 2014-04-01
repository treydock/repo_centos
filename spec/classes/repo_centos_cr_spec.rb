require 'spec_helper'

describe 'repo_centos::cr' do
  let :facts do
    {
      :operatingsystem            => 'CentOS',
      :operatingsystemmajrelease  => '6',
      :architecture               => 'x86_64',
    }
  end

  it { should create_class('repo_centos::cr') }
  it { should contain_class('repo_centos') }

  it do
    should contain_yumrepo('centos-cr').with({
      :baseurl  => 'http://mirror.centos.org/centos/6/cr/x86_64',
      :descr    => "CentOS 6 Continuous Release - x86_64",
      :enabled  => '0',
      :gpgcheck => '1',
      :gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
    })
  end

  context 'when repourl => "http://foo.example.com/centos"' do
    let(:pre_condition) { "class { 'repo_centos': repourl => 'http://foo.example.com/centos' }"}

    it { should contain_yumrepo('centos-cr').with_baseurl('http://foo.example.com/centos/6/cr/x86_64') }
  end

  context 'when enable_cr => true' do
    let(:pre_condition) { "class { 'repo_centos': enable_cr => true }"}

    it { should contain_yumrepo('centos-cr').with_enabled('1') }
  end

  context 'when operatingsystemmajrelease => 5' do
    let :facts do
      {
        :operatingsystem            => 'CentOS',
        :operatingsystemmajrelease  => '5',
        :architecture               => 'x86_64',
      }
    end

    it do
      should contain_yumrepo('centos-cr').with({
        :baseurl  => 'http://mirror.centos.org/centos/5/cr/x86_64',
        :descr    => "CentOS 5 Continuous Release - x86_64",
        :enabled  => '0',
        :gpgcheck => '1',
        :gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
      })
    end
  end
end
