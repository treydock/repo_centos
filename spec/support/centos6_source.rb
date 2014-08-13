require 'spec_helper'

shared_examples_for 'centos6_source' do
  it { should create_class('repo_centos::source') }
  it { should contain_class('repo_centos') }

  it do
    should contain_yumrepo('centos-base-source').with({
      :baseurl  => 'http://vault.centos.org/6.5/os/Source',
      :descr    => 'CentOS-6.5 - Base Source',
      :enabled  => '0',
      :gpgcheck => '1',
      :gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
    })
  end

  it do
    should contain_yumrepo('centos-updates-source').with({
      :baseurl  => 'http://vault.centos.org/6.5/updates/Source',
      :descr    => 'CentOS-6.5 - Updates Source',
      :enabled  => '0',
      :gpgcheck => '1',
      :gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
    })
  end

  context 'when repourl => "http://foo.example.com/centos-source"' do
    let(:pre_condition) { "class { 'repo_centos': source_repourl => 'http://foo.example.com/centos-source' }"}

    it { should contain_yumrepo('centos-base-source').with_baseurl('http://foo.example.com/centos-source/6.5/os/Source') }
    it { should contain_yumrepo('centos-updates-source').with_baseurl('http://foo.example.com/centos-source/6.5/updates/Source') }
  end

  context 'when enable_source => true' do
    let(:pre_condition) { "class { 'repo_centos': enable_source => true }"}

    it { should contain_yumrepo('centos-base-source').with_enabled('1') }
    it { should contain_yumrepo('centos-updates-source').with_enabled('1') }
  end
end
