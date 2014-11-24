shared_examples_for 'repo_centos::updates' do |ver|
  it { should create_class('repo_centos::updates') }

  it do
    should contain_yumrepo('centos-updates').with({
      :mirrorlist => "http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates&infra=$infra",
      :descr    => "CentOS-$releasever - Updates",
      :enabled  => '1',
      :gpgcheck => '1',
      :gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{ver}",
    })
  end

  context 'when mirrorlisturl => "http://foo.example.com/centos"' do
    let(:params) {{ :mirrorlisturl => 'http://foo.example.com/centos' }}

    it { should contain_yumrepo('centos-updates').with_mirrorlist("http://foo.example.com/centos/?release=$releasever&arch=$basearch&repo=updates&infra=$infra") }
  end

  context 'when enable_mirrorlist => false"' do
    let(:params) {{ :enable_mirrorlist => false }}

    it { should contain_yumrepo('centos-updates').with_baseurl("http://mirror.centos.org/centos/$releasever/updates/$basearch/") }
  end

  context 'when repourl => "http://foo.example.com/centos"' do
    let(:params) {{ :enable_mirrorlist => false, :repourl => 'http://foo.example.com/centos' }}

    it { should contain_yumrepo('centos-updates').with_baseurl("http://foo.example.com/centos/$releasever/updates/$basearch/") }
  end

  context 'when enable_updates => false' do
    let(:params) {{ :enable_updates => false }}

    it { should contain_yumrepo('centos-updates').with_enabled('0') }
  end

  if Gem::Version.new(PUPPET_VERSION) >= Gem::Version.new('3.5.0')
    it { should contain_yumrepo('centos-updates').with_ensure('present') }

    context 'when ensure_updates => "absent"' do
      let(:params) {{ :ensure_updates => "absent" }}
      it { should contain_yumrepo('centos-updates').with_ensure('absent') }
    end
  end

end
