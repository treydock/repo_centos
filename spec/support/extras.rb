shared_examples_for 'repo_centos::extras' do |facts|
  it { should create_class('repo_centos::extras') }

  it do
    should contain_yumrepo('extras').only_with({
      :name       => 'extras',
      :mirrorlist => "http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras#{mirrorlist_tail}",
      :baseurl    => 'absent',
      :descr      => 'CentOS-$releasever - Extras',
      :enabled    => '1',
      :gpgcheck   => '1',
      :gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{facts[:operatingsystemmajrelease]}",
      #:target     => '/etc/yum.repos.d/CentOS-Base.repo',
    })
  end

  context 'when mirrorlisturl => "http://foo.example.com/centos"' do
    let(:params) {{ :mirrorlisturl => 'http://foo.example.com/centos' }}
    it { should contain_yumrepo("extras").with_mirrorlist("http://foo.example.com/centos/?release=$releasever&arch=$basearch&repo=extras#{mirrorlist_tail}") }
  end

  context 'when enable_mirrorlist => false"' do
    let(:params) {{ :enable_mirrorlist => false }}
    it { should contain_yumrepo('extras').with_mirrorlist('absent') }
    it { should contain_yumrepo('extras').with_baseurl('http://mirror.centos.org/centos/$releasever/extras/$basearch/') }
  end

  context 'when enable_mirrorlist => false and repourl => "http://foo.example.com/centos"' do
    let(:params) {{ :enable_mirrorlist => false, :repourl => 'http://foo.example.com/centos' }}
    it { should contain_yumrepo('extras').with_mirrorlist('absent') }
    it { should contain_yumrepo('extras').with_baseurl('http://foo.example.com/centos/$releasever/extras/$basearch/') }
  end

  context 'when enable_extras => false' do
    let(:params) {{ :enable_extras => false }}
    it { should contain_yumrepo('extras').with_enabled('0') }
  end
end
