shared_examples_for 'repo_centos::clean' do |ver|
  it { should create_class('repo_centos::clean') }

  it { should contain_file("/etc/yum.repos.d/centos#{ver}.repo").with_ensure('absent') }
  it { should contain_file('/etc/yum.repos.d/CentOS-Base.repo').with_ensure('absent') }
  it { should contain_file('/etc/yum.repos.d/CentOS-Vault.repo').with_ensure('absent') }
  it { should contain_file('/etc/yum.repos.d/CentOS-Debuginfo.repo').with_ensure('absent') }
  it { should contain_file('/etc/yum.repos.d/CentOS-Media.repo').with_ensure('absent') }
  it { should contain_file('/etc/yum.repos.d/CentOS-Sources.repo').with_ensure('absent') }
  it { should contain_file('/etc/yum.repos.d/CentOS-SCL.repo').with_ensure('absent') }

end
