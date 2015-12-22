shared_examples_for 'repo_centos::contrib' do |default_facts|
  it { should create_class('repo_centos::contrib') }

  if default_facts[:operatingsystemmajrelease] >= '7'
    it { should_not contain_augeas('centos-contrib') }
  else
    it do
      should contain_augeas('centos-contrib').with({
        :context  => '/files/etc/yum.repos.d/CentOS-Base.repo/contrib',
        :changes  => [
          "set name 'CentOS-$releasever - Contrib'",
          "set mirrorlist 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=contrib#{mirrorlist_tail}'",
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
        verify_augeas_changes(catalogue, 'centos-contrib', ["set mirrorlist 'http://foo.example.com/centos/?release=$releasever&arch=$basearch&repo=contrib#{mirrorlist_tail}'"])
      end
    end

    context 'when enable_mirrorlist => false"' do
      let(:params) {{ :enable_mirrorlist => false }}
      it do
        verify_augeas_changes(catalogue, 'centos-contrib', [
          'rm mirrorlist',
          "set baseurl 'http://mirror.centos.org/centos/$releasever/contrib/$basearch/'",
        ])
      end
    end

    context 'when enable_mirrorlist => false and repourl => "http://foo.example.com/centos"' do
      let(:params) {{ :enable_mirrorlist => false, :repourl => 'http://foo.example.com/centos' }}
      it do
        verify_augeas_changes(catalogue, 'centos-contrib', [
          'rm mirrorlist',
          "set baseurl 'http://foo.example.com/centos/$releasever/contrib/$basearch/'",
        ])
      end
    end

    context 'when enable_contrib => true' do
      let(:params) {{ :enable_contrib => true }}
      it do
        verify_augeas_changes(catalogue, 'centos-contrib', ["set enabled 1"])
      end
    end
  end
end
