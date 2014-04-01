require 'spec_helper'

describe 'repo_centos::updates' do
  let :facts do
    {
      :operatingsystem            => 'CentOS',
      :operatingsystemmajrelease  => '6',
      :architecture               => 'x86_64',
    }
  end

  it { should create_class('repo_centos::updates') }
  it { should contain_class('repo_centos') }

  it do
    should contain_yumrepo('centos-updates').with({
      :baseurl  => 'http://mirror.centos.org/centos/6/updates/x86_64',
      :descr    => "CentOS 6 Updates - x86_64",
      :enabled  => '1',
      :gpgcheck => '1',
      :gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
    })
  end

  context 'when repourl => "http://foo.example.com/centos"' do
    let(:pre_condition) { "class { 'repo_centos': repourl => 'http://foo.example.com/centos' }"}

    it { should contain_yumrepo('centos-updates').with_baseurl('http://foo.example.com/centos/6/updates/x86_64') }
  end

  context 'when enable_updates => false' do
    let(:pre_condition) { "class { 'repo_centos': enable_updates => false }"}

    it { should contain_yumrepo('centos-updates').with_enabled('0') }
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
      should contain_yumrepo('centos-updates').with({
        :baseurl  => 'http://mirror.centos.org/centos/5/updates/x86_64',
        :descr    => "CentOS 5 Updates - x86_64",
        :enabled  => '1',
        :gpgcheck => '1',
        :gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
      })
    end
  end
end
