shared_examples_for 'repo_centos::fasttrack' do |facts|
  it { should create_class('repo_centos::fasttrack') }

  it do
    should contain_yumrepo('fasttrack').only_with({
      :name       => 'fasttrack',
      :mirrorlist => "http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=fasttrack#{mirrorlist_tail}",
      :baseurl    => 'absent',
      :descr      => 'CentOS-$releasever - fasttrack',
      :enabled    => '0',
      :gpgcheck   => '1',
      :gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{facts[:operatingsystemmajrelease]}",
      #:target     => '/etc/yum.repos.d/CentOS-fasttrack.repo',
    })
  end

  context 'when mirrorlisturl => "http://foo.example.com/centos"' do
    let(:params) {{ :mirrorlisturl => 'http://foo.example.com/centos' }}
    it { should contain_yumrepo("fasttrack").with_mirrorlist("http://foo.example.com/centos/?release=$releasever&arch=$basearch&repo=fasttrack#{mirrorlist_tail}") }
  end

  context 'when enable_mirrorlist => false"' do
    let(:params) {{ :enable_mirrorlist => false }}
    it { should contain_yumrepo('fasttrack').with_mirrorlist('absent') }
    it { should contain_yumrepo('fasttrack').with_baseurl('http://mirror.centos.org/centos/$releasever/fasttrack/$basearch/') }
  end

  context 'when enable_mirrorlist => false and repourl => "http://foo.example.com/centos"' do
    let(:params) {{ :enable_mirrorlist => false, :repourl => 'http://foo.example.com/centos' }}
    it { should contain_yumrepo('fasttrack').with_mirrorlist('absent') }
    it { should contain_yumrepo('fasttrack').with_baseurl('http://foo.example.com/centos/$releasever/fasttrack/$basearch/') }
  end

  context 'when enable_fasttrack => true' do
    let(:params) {{ :enable_fasttrack => true }}
    it { should contain_yumrepo('fasttrack').with_enabled('1') }
  end
end
