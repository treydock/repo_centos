shared_examples_for 'repo_centos::plus' do |ver|
  it { should create_class('repo_centos::plus') }

  it do
    should contain_yumrepo('centos-plus').with({
      :mirrorlist => "http://mirrorlist.centos.org/?release=\$releasever&arch=\$basearch&repo=centosplus&infra=$infra",
      :descr    => "CentOS-$releasever - Plus",
      :enabled  => '0',
      :gpgcheck => '1',
      :gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{ver}",
    })
  end

  context 'when mirrorlisturl => "http://foo.example.com/centos"' do
    let(:params) {{ :mirrorlisturl => 'http://foo.example.com/centos' }}

    it { should contain_yumrepo('centos-plus').with_mirrorlist("http://foo.example.com/centos/?release=\$releasever&arch=\$basearch&repo=centosplus&infra=$infra") }
  end

  context 'when enable_mirrorlist => false"' do
    let(:params) {{ :enable_mirrorlist => false }}

    it { should contain_yumrepo('centos-plus').with_baseurl("http://mirror.centos.org/centos/#{ver}/centosplus/$basearch/") }
  end

  context 'when repourl => "http://foo.example.com/centos"' do
    let(:params) {{ :enable_mirrorlist => false, :repourl => 'http://foo.example.com/centos' }}

    it { should contain_yumrepo('centos-plus').with_baseurl("http://foo.example.com/centos/#{ver}/centosplus/$basearch/") }
  end

  context 'when enable_plus => true' do
    let(:params) {{ :enable_plus => true }}

    it { should contain_yumrepo('centos-plus').with_enabled('1') }
  end

  if Gem::Version.new(PUPPET_VERSION) >= Gem::Version.new('3.5.0')
    it { should contain_yumrepo('centos-plus').with_ensure('present') }

    context 'when ensure_plus => "absent"' do
      let(:params) {{ :ensure_plus => "absent" }}
      it { should contain_yumrepo('centos-plus').with_ensure('absent') }
    end
  end

end
