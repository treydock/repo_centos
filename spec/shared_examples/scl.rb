shared_examples_for 'repo_centos::scl' do |default_facts|
  it { should create_class('repo_centos::scl') }

  if default_facts[:operatingsystemmajrelease] == '6'
    it { should contain_file('/etc/yum.repos.d/CentOS-SCL.repo').with_ensure('absent') }

    context 'when enable_scl => true' do
      let(:params) {{ :enable_scl => true }}

      it do
        should contain_augeas('centos-scl').with({
          :context  => '/files/etc/yum.repos.d/CentOS-SCL.repo/scl',
          :changes  => [
            "set name 'CentOS-$releasever - SCL'",
            "set baseurl 'http://mirror.centos.org/centos/$releasever/SCL/$basearch/'",
            'set enabled 1',
            'set gpgcheck 1',
            "set gpgkey file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{default_facts[:operatingsystemmajrelease]}",
          ],
          :lens     => 'Yum.lns',
          :incl     => '/etc/yum.repos.d/CentOS-SCL.repo'
        })
      end

      context 'when repourl => "http://foo.example.com/centos"' do
        let(:params) {{ :enable_scl => true, :repourl => 'http://foo.example.com/centos' }}
        it do
          verify_augeas_changes(catalogue, 'centos-scl', ["set baseurl 'http://foo.example.com/centos/$releasever/SCL/$basearch/'"])
        end
      end
    end

    context 'when ensure_scl => present' do
      let(:params) {{ :ensure_scl => 'present' }}

      it do
        should contain_augeas('centos-scl').with({
          :context  => '/files/etc/yum.repos.d/CentOS-SCL.repo/scl',
          :changes  => [
            "set name 'CentOS-$releasever - SCL'",
            "set baseurl 'http://mirror.centos.org/centos/$releasever/SCL/$basearch/'",
            'set enabled 0',
            'set gpgcheck 1',
            "set gpgkey file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{default_facts[:operatingsystemmajrelease]}",
          ],
          :lens     => 'Yum.lns',
          :incl     => '/etc/yum.repos.d/CentOS-SCL.repo'
        })
      end
    end
  else
    it { should_not contain_augeas('centos-scl') }
    it { should_not contain_file('/etc/yum.repos.d/CentOS-SCL.repo') }
  end
end
