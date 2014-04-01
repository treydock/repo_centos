require 'spec_helper'

describe 'repo_centos::plus' do
  let :facts do
    {
      :operatingsystem            => 'CentOS',
      :operatingsystemmajrelease  => '6',
      :architecture               => 'x86_64',
    }
  end

  it { should create_class('repo_centos::plus') }
  it { should contain_class('repo_centos') }

  it do
    should contain_yumrepo('centos-plus').with({
      :baseurl  => 'http://mirror.centos.org/centos/6/centosplus/x86_64',
      :descr    => "CentOS 6 Plus - x86_64",
      :enabled  => '0',
      :gpgcheck => '1',
      :gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
    })
  end

  context 'when repourl => "http://foo.example.com/centos"' do
    let(:pre_condition) { "class { 'repo_centos': repourl => 'http://foo.example.com/centos' }"}

    it { should contain_yumrepo('centos-plus').with_baseurl('http://foo.example.com/centos/6/centosplus/x86_64') }
  end

  context 'when enable_plus => true' do
    let(:pre_condition) { "class { 'repo_centos': enable_plus => true }"}

    it { should contain_yumrepo('centos-plus').with_enabled('1') }
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
      should contain_yumrepo('centos-plus').with({
        :baseurl  => 'http://mirror.centos.org/centos/5/centosplus/x86_64',
        :descr    => "CentOS 5 Plus - x86_64",
        :enabled  => '0',
        :gpgcheck => '1',
        :gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
      })
    end
  end
end
