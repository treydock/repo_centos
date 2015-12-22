shared_examples_for 'repo_centos::extras' do |default_facts|
  it { should create_class('repo_centos::extras') }

  it do
    should contain_augeas('centos-extras').with({
      :context  => '/files/etc/yum.repos.d/CentOS-Base.repo/extras',
      :changes  => [
        "set name 'CentOS-$releasever - Extras'",
        "set mirrorlist 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras#{mirrorlist_tail}'",
        'rm baseurl',
        '',
        'set gpgcheck 1',
        "set gpgkey file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{default_facts[:operatingsystemmajrelease]}",
      ],
      :lens     => 'Yum.lns',
      :incl     => '/etc/yum.repos.d/CentOS-Base.repo'
    })
  end

  context 'when mirrorlisturl => "http://foo.example.com/centos"' do
    let(:params) {{ :mirrorlisturl => 'http://foo.example.com/centos' }}
    it do
      verify_augeas_changes(catalogue, 'centos-extras', ["set mirrorlist 'http://foo.example.com/centos/?release=$releasever&arch=$basearch&repo=extras#{mirrorlist_tail}'"])
    end
  end

  context 'when enable_mirrorlist => false"' do
    let(:params) {{ :enable_mirrorlist => false }}
    it do
      verify_augeas_changes(catalogue, 'centos-extras', [
        'rm mirrorlist',
        "set baseurl 'http://mirror.centos.org/centos/$releasever/extras/$basearch/'",
      ])
    end
  end

  context 'when enable_mirrorlist => false and repourl => "http://foo.example.com/centos"' do
    let(:params) {{ :enable_mirrorlist => false, :repourl => 'http://foo.example.com/centos' }}
    it do
      verify_augeas_changes(catalogue, 'centos-extras', [
        'rm mirrorlist',
        "set baseurl 'http://foo.example.com/centos/$releasever/extras/$basearch/'",
      ])
    end
  end

  context 'when enable_extras => false' do
    let(:params) {{ :enable_extras => false }}
    it do
      verify_augeas_changes(catalogue, 'centos-extras', ["set enabled 0"])
    end
  end
end
