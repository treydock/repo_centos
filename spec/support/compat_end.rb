shared_examples_for 'repo_centos::compat::end' do
  it { should create_class('repo_centos::compat::end') }

  [
    'centos-base',
    'centos-contrib',
    'centos-cr',
    'centos-debug',
    'centos-extras',
    'centos-fasttrack',
    'centos-plus',
    'centos-scl',
    'centos-updates',
    'centos-base-source',
    'centos-updates-source',
  ].each do |r|
    it { should contain_file("/etc/yum.repos.d/#{r}.repo").with_ensure('absent') }
  end

  context 'when ensure_source => present' do
    let(:params) {{ :ensure_source => 'present' }}

    it { should_not contain_file('/etc/yum.repos.d/centos-base-source.repo') }
    it { should_not contain_file('/etc/yum.repos.d/centos-updates-source.repo') }
  end
end
