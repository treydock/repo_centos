shared_examples_for 'repo_centos::base' do |default_facts|
  it { should create_class('repo_centos::base') }

  it do
    should contain_yumrepo('base').only_with({
      :name       => 'base',
      :mirrorlist => "http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os#{mirrorlist_tail}",
      :baseurl    => 'absent',
      :descr      => 'CentOS-$releasever - Base',
      :enabled    => '1',
      :gpgcheck   => '1',
      :gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{default_facts[:operatingsystemmajrelease]}",
      #:target     => '/etc/yum.repos.d/CentOS-Base.repo',
    })
  end

  context 'when mirrorlisturl => "http://foo.example.com/centos"' do
    let(:params) {{ :mirrorlisturl => 'http://foo.example.com/centos' }}
    it { should contain_yumrepo("base").with_mirrorlist("http://foo.example.com/centos/?release=$releasever&arch=$basearch&repo=os#{mirrorlist_tail}") }
  end

  context 'when enable_mirrorlist => false"' do
    let(:params) {{ :enable_mirrorlist => false }}
    it { should contain_yumrepo('base').with_mirrorlist('absent') }
    it { should contain_yumrepo('base').with_baseurl('http://mirror.centos.org/centos/$releasever/os/$basearch/') }
  end

  context 'when enable_mirrorlist => false and repourl => "http://foo.example.com/centos"' do
    let(:params) {{ :enable_mirrorlist => false, :repourl => 'http://foo.example.com/centos' }}
    it { should contain_yumrepo('base').with_mirrorlist('absent') }
    it { should contain_yumrepo('base').with_baseurl('http://foo.example.com/centos/$releasever/os/$basearch/') }
  end

  context 'when enable_base => false' do
    let(:params) {{ :enable_base => false }}
    it { should contain_yumrepo('base').with_enabled('0') }
  end
end
