shared_examples_for 'repo_centos::contrib' do |facts|
  it { should create_class('repo_centos::contrib') }

  if facts[:operatingsystemmajrelease] >= '7'
    it { should_not contain_yumrepo('contrib') }
  else
    it do
      should contain_yumrepo('contrib').only_with({
        :name       => 'contrib',
        :mirrorlist => "http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=contrib#{mirrorlist_tail}",
        :baseurl    => 'absent',
        :descr      => 'CentOS-$releasever - Contrib',
        :enabled    => '0',
        :gpgcheck   => '1',
        :gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{facts[:operatingsystemmajrelease]}",
        :target     => '/etc/yum.repos.d/CentOS-Base.repo',
      })
    end

    context 'when mirrorlisturl => "http://foo.example.com/centos"' do
      let(:params) {{ :mirrorlisturl => 'http://foo.example.com/centos' }}
      it { should contain_yumrepo("contrib").with_mirrorlist("http://foo.example.com/centos/?release=$releasever&arch=$basearch&repo=contrib#{mirrorlist_tail}") }
    end

    context 'when enable_mirrorlist => false"' do
      let(:params) {{ :enable_mirrorlist => false }}
      it { should contain_yumrepo('contrib').with_mirrorlist('absent') }
      it { should contain_yumrepo('contrib').with_baseurl('http://mirror.centos.org/centos/$releasever/contrib/$basearch/') }
    end

    context 'when enable_mirrorlist => false and repourl => "http://foo.example.com/centos"' do
      let(:params) {{ :enable_mirrorlist => false, :repourl => 'http://foo.example.com/centos' }}
      it { should contain_yumrepo('contrib').with_mirrorlist('absent') }
      it { should contain_yumrepo('contrib').with_baseurl('http://foo.example.com/centos/$releasever/contrib/$basearch/') }
    end

    context 'when enable_contrib => true' do
      let(:params) {{ :enable_contrib => true }}
      it { should contain_yumrepo('contrib').with_enabled('1') }
    end
  end
end
