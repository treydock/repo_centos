shared_examples_for 'repo_centos::plus' do |facts|
  it { should create_class('repo_centos::plus') }

  it do
    should contain_yumrepo('centosplus').only_with({
      :name       => 'centosplus',
      :mirrorlist => "http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus#{mirrorlist_tail}",
      :baseurl    => 'absent',
      :descr      => 'CentOS-$releasever - Plus',
      :enabled    => '0',
      :gpgcheck   => '1',
      :gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{facts[:operatingsystemmajrelease]}",
      :target     => '/etc/yum.repos.d/CentOS-Base.repo',
    })
  end

  context 'when mirrorlisturl => "http://foo.example.com/centos"' do
    let(:params) {{ :mirrorlisturl => 'http://foo.example.com/centos' }}
    it { should contain_yumrepo("centosplus").with_mirrorlist("http://foo.example.com/centos/?release=$releasever&arch=$basearch&repo=centosplus#{mirrorlist_tail}") }
  end

  context 'when enable_mirrorlist => false"' do
    let(:params) {{ :enable_mirrorlist => false }}
    it { should contain_yumrepo('centosplus').with_mirrorlist('absent') }
    it { should contain_yumrepo('centosplus').with_baseurl('http://mirror.centos.org/centos/$releasever/centosplus/$basearch/') }
  end

  context 'when enable_mirrorlist => false and repourl => "http://foo.example.com/centos"' do
    let(:params) {{ :enable_mirrorlist => false, :repourl => 'http://foo.example.com/centos' }}
    it { should contain_yumrepo('centosplus').with_mirrorlist('absent') }
    it { should contain_yumrepo('centosplus').with_baseurl('http://foo.example.com/centos/$releasever/centosplus/$basearch/') }
  end

  context 'when enable_plus => true' do
    let(:params) {{ :enable_plus => true }}
    it { should contain_yumrepo('centosplus').with_enabled('1') }
  end
end
