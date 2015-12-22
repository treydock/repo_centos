shared_examples_for 'repo_centos::fasttrack' do |default_facts|
  it { should create_class('repo_centos::fasttrack') }

  it do
    should contain_augeas('centos-fasttrack').with({
      :context  => '/files/etc/yum.repos.d/CentOS-fasttrack.repo/fasttrack',
      :changes  => [
        "set name 'CentOS-#{default_facts[:operatingsystemmajrelease]} - fasttrack'",
        "set mirrorlist 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=fasttrack#{mirrorlist_tail}'",
        'rm baseurl',
        'set enabled 0',
        'set gpgcheck 1',
        "set gpgkey file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{default_facts[:operatingsystemmajrelease]}",
      ],
      :lens     => 'Yum.lns',
      :incl     => '/etc/yum.repos.d/CentOS-fasttrack.repo'
    })
  end

  context 'when mirrorlisturl => "http://foo.example.com/centos"' do
    let(:params) {{ :mirrorlisturl => 'http://foo.example.com/centos' }}
    it do
      verify_augeas_changes(catalogue, 'centos-fasttrack', ["set mirrorlist 'http://foo.example.com/centos/?release=$releasever&arch=$basearch&repo=fasttrack#{mirrorlist_tail}'"])
    end
  end

  context 'when enable_mirrorlist => false"' do
    let(:params) {{ :enable_mirrorlist => false }}
    it do
      verify_augeas_changes(catalogue, 'centos-fasttrack', [
        'rm mirrorlist',
        "set baseurl 'http://mirror.centos.org/centos/$releasever/fasttrack/$basearch/'",
      ])
    end
  end

  context 'when enable_mirrorlist => false and repourl => "http://foo.example.com/centos"' do
    let(:params) {{ :enable_mirrorlist => false, :repourl => 'http://foo.example.com/centos' }}
    it do
      verify_augeas_changes(catalogue, 'centos-fasttrack', [
        'rm mirrorlist',
        "set baseurl 'http://foo.example.com/centos/$releasever/fasttrack/$basearch/'",
      ])
    end
  end

  context 'when enable_fasttrack => true' do
    let(:params) {{ :enable_fasttrack => true }}
    it do
      verify_augeas_changes(catalogue, 'centos-fasttrack', ["set enabled 1"])
    end
  end
end
