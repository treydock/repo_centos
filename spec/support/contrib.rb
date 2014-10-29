shared_examples_for 'repo_centos::contrib' do |ver|
  it { should create_class('repo_centos::contrib') }

  it do
    should contain_yumrepo('centos-contrib').with({
      :baseurl  => "http://mirror.centos.org/centos/#{ver}/contrib/x86_64",
      :descr    => "CentOS #{ver} contrib - x86_64",
      :enabled  => '0',
      :gpgcheck => '1',
      :gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{ver}",
    })
  end

  context 'when repourl => "http://foo.example.com/centos"' do
    let(:params) {{ :repourl => 'http://foo.example.com/centos' }}

    it { should contain_yumrepo('centos-contrib').with_baseurl("http://foo.example.com/centos/#{ver}/contrib/x86_64") }
  end

  context 'when enable_contrib => true' do
    let(:params) {{ :enable_contrib => true }}

    it { should contain_yumrepo('centos-contrib').with_enabled('1') }
  end

  if Gem::Version.new(PUPPET_VERSION) >= Gem::Version.new('3.5.0')
    it { should contain_yumrepo('centos-contrib').with_ensure('present') }

    context 'when ensure_contrib => "absent"' do
      let(:params) {{ :ensure_contrib => "absent" }}
      it { should contain_yumrepo('centos-contrib').with_ensure('absent') }
    end
  end

end
