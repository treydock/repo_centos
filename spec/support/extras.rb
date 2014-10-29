shared_examples_for 'repo_centos::extras' do |ver|
  it { should create_class('repo_centos::extras') }

  it do
    should contain_yumrepo('centos-extras').with({
      :baseurl  => "http://mirror.centos.org/centos/#{ver}/extras/x86_64",
      :descr    => "CentOS #{ver} Extras - x86_64",
      :enabled  => '1',
      :gpgcheck => '1',
      :gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{ver}",
    })
  end

  context 'when repourl => "http://foo.example.com/centos"' do
    let(:params) {{ :repourl => 'http://foo.example.com/centos' }}

    it { should contain_yumrepo('centos-extras').with_baseurl("http://foo.example.com/centos/#{ver}/extras/x86_64") }
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
