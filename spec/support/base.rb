shared_examples_for 'repo_centos::base' do |ver|
  it { should create_class('repo_centos::base') }

  it do
    should contain_yumrepo('centos-base').with({
      :mirrorlist => "http://mirrorlist.centos.org/?release=\$releasever&arch=\$basearch&repo=os&infra=$infra",
      :descr    => "CentOS-$releasever - Base",
      :enabled  => '1',
      :gpgcheck => '1',
      :gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{ver}",
    })
  end

  context 'when mirrorlisturl => "http://foo.example.com/centos"' do
    let(:params) {{ :mirrorlisturl => 'http://foo.example.com/centos' }}

    it { should contain_yumrepo('centos-base').with_mirrorlist("http://foo.example.com/centos/?release=\$releasever&arch=\$basearch&repo=os&infra=$infra") }
  end

  context 'when enable_mirrorlist => false"' do
    let(:params) {{ :enable_mirrorlist => false }}

    it { should contain_yumrepo('centos-base').with_baseurl("http://mirror.centos.org/centos/#{ver}/os/$basearch/") }
  end

  context 'when repourl => "http://foo.example.com/centos"' do
    let(:params) {{ :enable_mirrorlist => false, :repourl => 'http://foo.example.com/centos' }}

    it { should contain_yumrepo('centos-base').with_baseurl("http://foo.example.com/centos/#{ver}/os/$basearch/") }
  end

  context 'when enable_base => false' do
    let(:params) {{ :enable_base => false }}

    it { should contain_yumrepo('centos-base').with_enabled('0') }
  end

  if Gem::Version.new(PUPPET_VERSION) >= Gem::Version.new('3.5.0')
    it { should contain_yumrepo('centos-base').with_ensure('present') }

    context 'when ensure_base => "absent"' do
      let(:params) {{ :ensure_base => "absent" }}
      it { should contain_yumrepo('centos-base').with_ensure('absent') }
    end
  end

end
