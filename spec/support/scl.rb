shared_examples_for 'repo_centos::scl' do |ver|
  it { should create_class('repo_centos::scl') }

  if ver == '6'
    it do
      should contain_yumrepo('centos-scl').with({
        :baseurl  => "http://mirror.centos.org/centos/\$releasever/SCL/$basearch/",
        :descr    => "CentOS-$releasever - SCL",
        :enabled  => '0',
        :gpgcheck => '1',
        :gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{ver}",
      })
    end

    context 'when repourl => "http://foo.example.com/centos"' do
      let(:params) {{ :repourl => 'http://foo.example.com/centos' }}

      it { should contain_yumrepo('centos-scl').with_baseurl("http://foo.example.com/centos/\$releasever/SCL/$basearch/") }
    end

    context 'when enable_scl => true' do
      let(:params) {{ :enable_scl => true }}

      it { should contain_yumrepo('centos-scl').with_enabled('1') }
    end

    if Gem::Version.new(PUPPET_VERSION) >= Gem::Version.new('3.5.0')
      it { should contain_yumrepo('centos-scl').with_ensure('present') }

      context 'when ensure_scl => "absent"' do
        let(:params) {{ :ensure_scl => "absent" }}
        it { should contain_yumrepo('centos-scl').with_ensure('absent') }
      end
    end
  else
    it { should_not contain_yumrepo('centos-scl') }
  end

end
