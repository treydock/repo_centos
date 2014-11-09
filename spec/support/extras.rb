shared_examples_for 'repo_centos::extras' do |ver|
  it { should create_class('repo_centos::extras') }

  it do
    should contain_yumrepo('centos-extras').with({
      :mirrorlist => "http://mirrorlist.centos.org/?release=\$releasever&arch=\$basearch&repo=extras&infra=$infra",
      :descr    => "CentOS-$releasever - Extras",
      :enabled  => '1',
      :gpgcheck => '1',
      :gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{ver}",
    })
  end

  context 'when mirrorlisturl => "http://foo.example.com/centos"' do
    let(:params) {{ :mirrorlisturl => 'http://foo.example.com/centos' }}

    it { should contain_yumrepo('centos-extras').with_mirrorlist("http://foo.example.com/centos/?release=\$releasever&arch=\$basearch&repo=extras&infra=$infra") }
  end

  context 'when enable_mirrorlist => false"' do
    let(:params) {{ :enable_mirrorlist => false }}

    it { should contain_yumrepo('centos-extras').with_baseurl("http://mirror.centos.org/centos/#{ver}/extras/$basearch/") }
  end

  context 'when repourl => "http://foo.example.com/centos"' do
    let(:params) {{ :enable_mirrorlist => false, :repourl => 'http://foo.example.com/centos' }}

    it { should contain_yumrepo('centos-extras').with_baseurl("http://foo.example.com/centos/#{ver}/extras/$basearch/") }
  end

  context 'when enable_extras => false' do
    let(:params) {{ :enable_extras => false }}

    it { should contain_yumrepo('centos-extras').with_enabled('0') }
  end

  if Gem::Version.new(PUPPET_VERSION) >= Gem::Version.new('3.5.0')
    it { should contain_yumrepo('centos-extras').with_ensure('present') }

    context 'when ensure_extras => "absent"' do
      let(:params) {{ :ensure_extras => "absent" }}
      it { should contain_yumrepo('centos-extras').with_ensure('absent') }
    end
  end

end
