shared_examples_for 'repo_centos::debug' do |facts|
  it { should create_class('repo_centos::debug') }

  if facts[:operatingsystemmajrelease] == '5'
    let(:gpgkey) { "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{facts[:operatingsystemmajrelease]}" }
  else
    let(:gpgkey) { "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Debug-#{facts[:operatingsystemmajrelease]}" }
  end

  it do
    should contain_yumrepo('base-debuginfo').only_with({
      :name     => 'base-debuginfo',
      :baseurl  => "http://debuginfo.centos.org/#{facts[:operatingsystemmajrelease]}/$basearch/",
      :descr    => "CentOS-#{facts[:operatingsystemmajrelease]} - Debuginfo",
      :enabled  => '0',
      :gpgcheck => '1',
      :gpgkey   => gpgkey,
      #:target   => '/etc/yum.repos.d/CentOS-Debuginfo.repo',
    })
  end

  context 'when repourl => "http://foo.example.com/centos-debug"' do
    let(:params) {{ :debug_repourl => 'http://foo.example.com/centos-debug' }}
    it { should contain_yumrepo('base-debuginfo').with_baseurl("http://foo.example.com/centos-debug/#{facts[:operatingsystemmajrelease]}/$basearch/") }
  end

  context 'when enable_debug => true' do
    let(:params) {{ :enable_debug => true }}
    it { should contain_yumrepo('base-debuginfo').with_enabled('1') }
  end
end
