require 'spec_helper'

shared_examples_for 'centos6_debug' do
  it { should create_class('repo_centos::debug') }
  it { should contain_class('repo_centos') }

  it do
    should contain_yumrepo('centos-debug').with({
      :baseurl  => 'http://debuginfo.centos.org/6/x86_64',
      :descr    => 'CentOS-6 - Debuginfo',
      :enabled  => '0',
      :gpgcheck => '1',
      :gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Debug-6',
    })
  end

  context 'when repourl => "http://foo.example.com/centos-debug"' do
    let(:pre_condition) { "class { 'repo_centos': debug_repourl => 'http://foo.example.com/centos-debug' }"}

    it { should contain_yumrepo('centos-debug').with_baseurl('http://foo.example.com/centos-debug/6/x86_64') }
  end

  context 'when enable_debug => true' do
    let(:pre_condition) { "class { 'repo_centos': enable_debug => true }"}

    it { should contain_yumrepo('centos-debug').with_enabled('1') }
  end
end
