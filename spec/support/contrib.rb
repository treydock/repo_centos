shared_examples_for 'repo_centos::contrib' do |ver|
  it { should create_class('repo_centos::contrib') }

  if ver == '7'
    default_ensure = 'absent'
  else
    default_ensure = 'present'
  end

  it do
    should contain_yumrepo('centos-contrib').with({
      :mirrorlist => "http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=contrib&infra=$infra",
      :descr    => "CentOS-$releasever - Contrib",
      :enabled  => '0',
      :gpgcheck => '1',
      :gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{ver}",
    })
  end

  context 'when mirrorlisturl => "http://foo.example.com/centos"' do
    let(:params) {{ :mirrorlisturl => 'http://foo.example.com/centos' }}

    it { should contain_yumrepo('centos-contrib').with_mirrorlist("http://foo.example.com/centos/?release=$releasever&arch=$basearch&repo=contrib&infra=$infra") }
  end

  context 'when enable_mirrorlist => false"' do
    let(:params) {{ :enable_mirrorlist => false }}

    it { should contain_yumrepo('centos-contrib').with_baseurl("http://mirror.centos.org/centos/$releasever/contrib/$basearch/") }
  end

  context 'when repourl => "http://foo.example.com/centos"' do
    let(:params) {{ :enable_mirrorlist => false, :repourl => 'http://foo.example.com/centos' }}

    it { should contain_yumrepo('centos-contrib').with_baseurl("http://foo.example.com/centos/$releasever/contrib/$basearch/") }
  end

  context 'when enable_contrib => true' do
    let(:params) {{ :enable_contrib => true }}

    it { should contain_yumrepo('centos-contrib').with_enabled('1') }
  end

  if Gem::Version.new(PUPPET_VERSION) >= Gem::Version.new('3.5.0')
    it { should contain_yumrepo('centos-contrib').with_ensure(default_ensure) }

    context 'when ensure_contrib => "absent"' do
      let(:params) {{ :ensure_contrib => "absent" }}
      it { should contain_yumrepo('centos-contrib').with_ensure('absent') }
    end
  end

end
