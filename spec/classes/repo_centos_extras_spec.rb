require 'spec_helper'

describe 'repo_centos::extras' do
  let :facts do
    {
      :operatingsystem            => 'CentOS',
      :operatingsystemmajrelease  => '6',
      :architecture               => 'x86_64',
    }
  end

  it { should create_class('repo_centos::extras') }
  it { should contain_class('repo_centos') }

  it do
    should contain_yumrepo('centos-extras').with({
      :baseurl  => 'http://mirror.centos.org/centos/6/extras/x86_64',
      :descr    => "CentOS 6 Extras - x86_64",
      :enabled  => '1',
      :gpgcheck => '1',
      :gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
    })
  end

  context 'when repourl => "http://foo.example.com/centos"' do
    let(:pre_condition) { "class { 'repo_centos': repourl => 'http://foo.example.com/centos' }"}

    it { should contain_yumrepo('centos-extras').with_baseurl('http://foo.example.com/centos/6/extras/x86_64') }
  end

  context 'when enable_extras => false' do
    let(:pre_condition) { "class { 'repo_centos': enable_extras => false }"}

    it { should contain_yumrepo('centos-extras').with_enabled('0') }
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
      should contain_yumrepo('centos-extras').with({
        :baseurl  => 'http://mirror.centos.org/centos/5/extras/x86_64',
        :descr    => "CentOS 5 Extras - x86_64",
        :enabled  => '1',
        :gpgcheck => '1',
        :gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5',
      })
    end
  end
end
