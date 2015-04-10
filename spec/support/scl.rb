shared_examples_for 'repo_centos::scl' do |facts|
  it { should create_class('repo_centos::scl') }

  if facts[:operatingsystemmajrelease] == '6'
    if Gem::Version.new(PUPPET_VERSION) >= Gem::Version.new('3.5.0')
      it { should contain_yumrepo('scl').with_ensure('absent') }
    else
      it { should_not contain_yumrepo('scl') }
    end

    context 'when enable_scl => true' do
      let(:params) {{ :enable_scl => true }}

      it do
        should contain_yumrepo('scl').only_with({
          :name     => 'scl',
          :baseurl  => 'http://mirror.centos.org/centos/$releasever/SCL/$basearch/',
          :descr    => 'CentOS-$releasever - SCL',
          :enabled  => '1',
          :gpgcheck => '1',
          :gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{facts[:operatingsystemmajrelease]}",
          :target   => '/etc/yum.repos.d/CentOS-SCL.repo',
        })
      end

      context 'when repourl => "http://foo.example.com/centos"' do
        let(:params) {{ :enable_scl => true, :repourl => 'http://foo.example.com/centos' }}
        it { should contain_yumrepo('scl').with_baseurl('http://foo.example.com/centos/$releasever/SCL/$basearch/') }
      end
    end

    context 'when ensure_scl => present' do
      let(:params) {{ :ensure_scl => 'present' }}

      it do
        should contain_yumrepo('scl').only_with({
          :name     => 'scl',
          :baseurl  => 'http://mirror.centos.org/centos/$releasever/SCL/$basearch/',
          :descr    => 'CentOS-$releasever - SCL',
          :enabled  => '0',
          :gpgcheck => '1',
          :gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{facts[:operatingsystemmajrelease]}",
          :target   => '/etc/yum.repos.d/CentOS-SCL.repo',
        })
      end
    end
  else
    it { should_not contain_yumrepo('scl') }
  end
end
