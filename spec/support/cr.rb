shared_examples_for 'repo_centos::cr' do |facts|
  it { should create_class('repo_centos::cr') }

  if facts[:operatingsystemmajrelease] >= '7'
    it do
      should contain_yumrepo('cr').only_with({
        :name     => 'cr',
        :baseurl  => 'http://mirror.centos.org/centos/$releasever/cr/$basearch/',
        :descr    => 'CentOS-$releasever - CR',
        :enabled  => '0',
        :gpgcheck => '1',
        :gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{facts[:operatingsystemmajrelease]}",
        :target   => '/etc/yum.repos.d/CentOS-CR.repo',
      })
    end

    context 'when repourl => "http://foo.example.com/centos"' do
      let(:params) {{ :repourl => 'http://foo.example.com/centos' }}
      it { should contain_yumrepo('cr').with_baseurl('http://foo.example.com/centos/$releasever/cr/$basearch/') }
    end

    context 'when enable_cr => true' do
      let(:params) {{ :enable_cr => true }}
      it { should contain_yumrepo('cr').with_enabled('1') }
    end
  else
    if Gem::Version.new(PUPPET_VERSION) >= Gem::Version.new('3.5.0')
      it { should contain_yumrepo('cr').with_ensure('absent') }
    else
      it { should_not contain_yumrepo('cr') }
    end
  end
end
