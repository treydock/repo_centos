shared_examples_for 'repo_centos::plus' do |ver|
  it { should create_class('repo_centos::plus') }

  it do
    should contain_yumrepo('centos-plus').with({
      :baseurl  => "http://mirror.centos.org/centos/#{ver}/centosplus/x86_64",
      :descr    => "CentOS #{ver} Plus - x86_64",
      :enabled  => '0',
      :gpgcheck => '1',
      :gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{ver}",
    })
  end

  context 'when repourl => "http://foo.example.com/centos"' do
    let(:params) {{ :repourl => 'http://foo.example.com/centos' }}

    it { should contain_yumrepo('centos-plus').with_baseurl("http://foo.example.com/centos/#{ver}/centosplus/x86_64") }
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
