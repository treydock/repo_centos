shared_examples_for 'repo_centos::cr' do |ver|
  it { should create_class('repo_centos::cr') }

  it do
    should contain_yumrepo('centos-cr').with({
      :baseurl  => "http://mirror.centos.org/centos/#{ver}/cr/x86_64",
      :descr    => "CentOS #{ver} Continuous Release - x86_64",
      :enabled  => '0',
      :gpgcheck => '1',
      :gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{ver}",
    })
  end

  context 'when repourl => "http://foo.example.com/centos"' do
    let(:params) {{ :repourl => 'http://foo.example.com/centos' }}

    it { should contain_yumrepo('centos-cr').with_baseurl("http://foo.example.com/centos/#{ver}/cr/x86_64") }
  end

  context 'when enable_cr => true' do
    let(:params) {{ :enable_cr => true }}

    it { should contain_yumrepo('centos-cr').with_enabled('1') }
  end

  if Gem::Version.new(PUPPET_VERSION) >= Gem::Version.new('3.5.0')
    it { should contain_yumrepo('centos-cr').with_ensure('present') }

    context 'when ensure_cr => "absent"' do
      let(:params) {{ :ensure_cr => "absent" }}
      it { should contain_yumrepo('centos-cr').with_ensure('absent') }
    end
  end

end
