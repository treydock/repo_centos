shared_examples_for 'repo_centos::source' do |ver|
  it { should create_class('repo_centos::source') }

  it do
    should contain_yumrepo('centos-base-source').with({
      :baseurl  => "http://vault.centos.org/centos/$releasever/os/Source/",
      :descr    => "CentOS-$releasever - Base Sources",
      :enabled  => '0',
      :gpgcheck => '1',
      :gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{ver}",
    })
  end

  it do
    should contain_yumrepo('centos-updates-source').with({
      :baseurl  => "http://vault.centos.org/centos/$releasever/updates/Source/",
      :descr    => "CentOS-$releasever - Updates Sources",
      :enabled  => '0',
      :gpgcheck => '1',
      :gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{ver}",
    })
  end

  context 'when repourl => "http://foo.example.com/centos-source"' do
    let(:params) {{ :source_repourl => 'http://foo.example.com/centos-source' }}

    it { should contain_yumrepo('centos-base-source').with_baseurl("http://foo.example.com/centos-source/$releasever/os/Source/") }
    it { should contain_yumrepo('centos-updates-source').with_baseurl("http://foo.example.com/centos-source/$releasever/updates/Source/") }
  end

  context 'when enable_source => true' do
    let(:params) {{ :enable_source => true }}

    it { should contain_yumrepo('centos-base-source').with_enabled('1') }
    it { should contain_yumrepo('centos-updates-source').with_enabled('1') }
  end

  if Gem::Version.new(PUPPET_VERSION) >= Gem::Version.new('3.5.0')
    it { should contain_yumrepo('centos-base-source').with_ensure('present') }
    it { should contain_yumrepo('centos-updates-source').with_ensure('present') }

    context 'when ensure_source => "absent"' do
      let(:params) {{ :ensure_source => "absent" }}
      it { should contain_yumrepo('centos-base-source').with_ensure('absent') }
      it { should contain_yumrepo('centos-updates-source').with_ensure('absent') }
    end
  end

end
