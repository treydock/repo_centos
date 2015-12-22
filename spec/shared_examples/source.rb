shared_examples_for 'repo_centos::source' do |default_facts|
  it { should create_class('repo_centos::source') }

  it { should contain_file('/etc/yum.repos.d/CentOS-source.repo').with_ensure('absent') }

  context 'when ensure_source => present' do
    let(:params) {{ :ensure_source => 'present' }}

    it do
      should contain_augeas('centos-source').with({
        :context  => '/files/etc/yum.repos.d/CentOS-source.repo',
        :changes  => [
          "set centos-base-source/name 'CentOS-$releasever - Base Sources'",
          "set centos-base-source/baseurl 'http://vault.centos.org/centos/$releasever/os/Source/'",
          'set centos-base-source/enabled 0',
          'set centos-base-source/gpgcheck 1',
          "set centos-base-source/gpgkey file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{default_facts[:operatingsystemmajrelease]}",
          "set centos-updates-source/name 'CentOS-$releasever - Updates Sources'",
          "set centos-updates-source/baseurl 'http://vault.centos.org/centos/$releasever/updates/Source/'",
          'set centos-updates-source/enabled 0',
          'set centos-updates-source/gpgcheck 1',
          "set centos-updates-source/gpgkey file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{default_facts[:operatingsystemmajrelease]}",
        ],
        :lens     => 'Yum.lns',
        :incl     => '/etc/yum.repos.d/CentOS-source.repo'
      })
    end

    context 'when repourl => "http://foo.example.com/centos-source"' do
      let(:params) {{ :ensure_source => 'present', :source_repourl => 'http://foo.example.com/centos-source' }}
      it do
        verify_augeas_changes(catalogue, 'centos-source', [
          "set centos-base-source/baseurl 'http://foo.example.com/centos-source/$releasever/os/Source/'",
          "set centos-updates-source/baseurl 'http://foo.example.com/centos-source/$releasever/updates/Source/'",
        ])
      end
    end

    context 'when enable_source => true' do
      let(:params) {{ :ensure_source => 'present', :enable_source => true }}
      it do
        verify_augeas_changes(catalogue, 'centos-source', [
          'set centos-base-source/enabled 1',
          'set centos-updates-source/enabled 1',
        ])
      end
    end
  end
end
