shared_examples_for 'repo_centos::fasttrack' do |ver|
  it { should create_class('repo_centos::fasttrack') }

  it do
    should contain_yumrepo('centos-fasttrack').with({
      :mirrorlist => "http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=fasttrack&infra=$infra",
      :descr    => "CentOS-$releasever - fasttrack",
      :enabled  => '0',
      :gpgcheck => '1',
      :gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{ver}",
    })
  end

  context 'when mirrorlisturl => "http://foo.example.com/centos"' do
    let(:params) {{ :mirrorlisturl => 'http://foo.example.com/centos' }}

    it { should contain_yumrepo('centos-fasttrack').with_mirrorlist("http://foo.example.com/centos/?release=$releasever&arch=$basearch&repo=fasttrack&infra=$infra") }
  end

  context 'when enable_mirrorlist => false"' do
    let(:params) {{ :enable_mirrorlist => false }}

    it { should contain_yumrepo('centos-fasttrack').with_baseurl("http://mirror.centos.org/centos/$releasever/fasttrack/$basearch/") }
  end

  context 'when repourl => "http://foo.example.com/centos"' do
    let(:params) {{ :enable_mirrorlist => false, :repourl => 'http://foo.example.com/centos' }}

    it { should contain_yumrepo('centos-fasttrack').with_baseurl("http://foo.example.com/centos/$releasever/fasttrack/$basearch/") }
  end

  context 'when enable_fasttrack => true' do
    let(:params) {{ :enable_fasttrack => true }}

    it { should contain_yumrepo('centos-fasttrack').with_enabled('1') }
  end

  if Gem::Version.new(PUPPET_VERSION) >= Gem::Version.new('3.5.0')
    it { should contain_yumrepo('centos-fasttrack').with_ensure('present') }

    context 'when ensure_fasttrack => "absent"' do
      let(:params) {{ :ensure_fasttrack => "absent" }}
      it { should contain_yumrepo('centos-fasttrack').with_ensure('absent') }
    end
  end

end
