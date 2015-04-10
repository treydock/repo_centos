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
  ].each do |r|
    it { should contain_file("/etc/yum.repos.d/#{r}.repo").with_ensure('absent') }
  end
end
