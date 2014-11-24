shared_examples_for 'repo_centos::debug' do |ver|
  it { should create_class('repo_centos::debug') }

  it do
    should contain_yumrepo('centos-debug').with({
      :baseurl  => "http://debuginfo.centos.org/#{ver}/$basearch/",
      :descr    => "CentOS-#{ver} - Debuginfo",
      :enabled  => '0',
      :gpgcheck => '1',
      :gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Debug-#{ver}",
    })
  end

  context 'when repourl => "http://foo.example.com/centos-debug"' do
    let(:params) {{ :debug_repourl => 'http://foo.example.com/centos-debug' }}

    it { should contain_yumrepo('centos-debug').with_baseurl("http://foo.example.com/centos-debug/#{ver}/$basearch/") }
  end

  context 'when enable_debug => true' do
    let(:params) {{ :enable_debug => true }}

    it { should contain_yumrepo('centos-debug').with_enabled('1') }
  end

  if Gem::Version.new(PUPPET_VERSION) >= Gem::Version.new('3.5.0')
    it { should contain_yumrepo('centos-debug').with_ensure('present') }

    context 'when ensure_debug => "absent"' do
      let(:params) {{ :ensure_debug => "absent" }}
      it { should contain_yumrepo('centos-debug').with_ensure('absent') }
    end
  end

end
