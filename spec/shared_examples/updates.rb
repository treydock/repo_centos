shared_examples_for 'repo_centos::updates' do |default_facts|
  it { should create_class('repo_centos::updates') }

  it do
    should contain_augeas('centos-updates').with({
      :context  => '/files/etc/yum.repos.d/CentOS-Base.repo/updates',
      :changes  => [
        "set name 'CentOS-$releasever - Updates'",
        "set mirrorlist 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates#{mirrorlist_tail}'",
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
      verify_augeas_changes(catalogue, 'centos-updates', ["set mirrorlist 'http://foo.example.com/centos/?release=$releasever&arch=$basearch&repo=updates#{mirrorlist_tail}'"])
    end
  end

  context 'when enable_mirrorlist => false"' do
    let(:params) {{ :enable_mirrorlist => false }}
    it do
      verify_augeas_changes(catalogue, 'centos-updates', [
        'rm mirrorlist',
        "set baseurl 'http://mirror.centos.org/centos/$releasever/updates/$basearch/'",
      ])
    end
  end

  context 'when enable_mirrorlist => false and repourl => "http://foo.example.com/centos"' do
    let(:params) {{ :enable_mirrorlist => false, :repourl => 'http://foo.example.com/centos' }}
    it do
      verify_augeas_changes(catalogue, 'centos-updates', [
        'rm mirrorlist',
        "set baseurl 'http://foo.example.com/centos/$releasever/updates/$basearch/'",
      ])
    end
  end

  context 'when enable_updates => false' do
    let(:params) {{ :enable_updates => false }}
    it do
      verify_augeas_changes(catalogue, 'centos-updates', ["set enabled 0"])
    end
  end
end
