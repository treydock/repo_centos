shared_examples_for 'repo_centos::cr' do |default_facts|
  it { should create_class('repo_centos::cr') }

  if default_facts[:operatingsystemmajrelease] >= '7'
    it do
      should contain_augeas('centos-cr').with({
        :context  => '/files/etc/yum.repos.d/CentOS-CR.repo/cr',
        :changes  => [
          "set name 'CentOS-$releasever - CR'",
          "set baseurl 'http://mirror.centos.org/centos/$releasever/cr/$basearch/'",
          'set enabled 0',
          'set gpgcheck 1',
          "set gpgkey file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{default_facts[:operatingsystemmajrelease]}",
        ],
        :lens     => 'Yum.lns',
        :incl     => '/etc/yum.repos.d/CentOS-CR.repo'
      })
    end

    context 'when repourl => "http://foo.example.com/centos"' do
      let(:params) {{ :repourl => 'http://foo.example.com/centos' }}
      it do
        verify_augeas_changes(catalogue, 'centos-cr', ["set baseurl 'http://foo.example.com/centos/$releasever/cr/$basearch/'"])
      end
    end

    context 'when enable_cr => true' do
      let(:params) {{ :enable_cr => true }}
      it do
        verify_augeas_changes(catalogue, 'centos-cr', ["set enabled 1"])
      end
    end
  else
    it { should contain_file('/etc/yum.repos.d/CentOS-CR.repo').with_ensure('absent') }
  end
end
