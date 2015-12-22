shared_examples_for 'repo_centos::debug' do |default_facts|
  it { should create_class('repo_centos::debug') }

  if default_facts[:operatingsystemmajrelease] == '5'
    let(:gpgkey) { "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-#{default_facts[:operatingsystemmajrelease]}" }
  else
    let(:gpgkey) { "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Debug-#{default_facts[:operatingsystemmajrelease]}" }
  end

  it do
    should contain_augeas('centos-base-debuginfo').with({
      :context  => '/files/etc/yum.repos.d/CentOS-Debuginfo.repo/base-debuginfo',
      :changes  => [
        "set name 'CentOS-#{default_facts[:operatingsystemmajrelease]} - Debuginfo'",
        "set baseurl 'http://debuginfo.centos.org/#{default_facts[:operatingsystemmajrelease]}/$basearch/'",
        'set enabled 0',
        'set gpgcheck 1',
        "set gpgkey #{gpgkey}",
      ],
      :lens     => 'Yum.lns',
      :incl     => '/etc/yum.repos.d/CentOS-Debuginfo.repo'
    })
  end

  context 'when repourl => "http://foo.example.com/centos-debug"' do
    let(:params) {{ :debug_repourl => 'http://foo.example.com/centos-debug' }}
    it do
      verify_augeas_changes(catalogue, 'centos-base-debuginfo', ["set baseurl 'http://foo.example.com/centos-debug/#{default_facts[:operatingsystemmajrelease]}/$basearch/'"])
    end
  end

  context 'when enable_debug => true' do
    let(:params) {{ :enable_debug => true }}
    it do
      verify_augeas_changes(catalogue, 'centos-base-debuginfo', ["set enabled 1"])
    end
  end
end
