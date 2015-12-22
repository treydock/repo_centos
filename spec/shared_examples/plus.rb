shared_examples_for 'repo_centos::plus' do |default_facts|
  it { should create_class('repo_centos::plus') }

  it do
    should contain_augeas('centos-centosplus').with({
      :context  => '/files/etc/yum.repos.d/CentOS-Base.repo/centosplus',
      :changes  => [
        "set name 'CentOS-$releasever - Plus'",
        "set mirrorlist 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus#{mirrorlist_tail}'",
        'rm baseurl',
        'set enabled 0',
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
      verify_augeas_changes(catalogue, 'centos-centosplus', ["set mirrorlist 'http://foo.example.com/centos/?release=$releasever&arch=$basearch&repo=centosplus#{mirrorlist_tail}'"])
    end
  end

  context 'when enable_mirrorlist => false"' do
    let(:params) {{ :enable_mirrorlist => false }}
    it do
      verify_augeas_changes(catalogue, 'centos-centosplus', [
        'rm mirrorlist',
        "set baseurl 'http://mirror.centos.org/centos/$releasever/centosplus/$basearch/'",
      ])
    end
  end

  context 'when enable_mirrorlist => false and repourl => "http://foo.example.com/centos"' do
    let(:params) {{ :enable_mirrorlist => false, :repourl => 'http://foo.example.com/centos' }}
    it do
      verify_augeas_changes(catalogue, 'centos-centosplus', [
        'rm mirrorlist',
        "set baseurl 'http://foo.example.com/centos/$releasever/centosplus/$basearch/'",
      ])
    end
  end

  context 'when enable_plus => true' do
    let(:params) {{ :enable_plus => true }}
    it do
      verify_augeas_changes(catalogue, 'centos-centosplus', ["set enabled 1"])
    end
  end
end
