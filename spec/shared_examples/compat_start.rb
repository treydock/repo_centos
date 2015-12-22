shared_examples_for 'repo_centos::compat::start' do
  it { should create_class('repo_centos::compat::start') }

  compat_repos = [
    'centos-base',
    'centos-contrib',
    'centos-cr',
    'centos-debug',
    'centos-extras',
    'centos-fasttrack',
    'centos-plus',
    'centos-scl',
    'centos-updates',
  ]

  it do
    should contain_exec('reinstall centos-release').with({
      :path       => '/usr/bin:/bin:/usr/sbin:/sbin',
      :command    => 'yum -y reinstall centos-release ; [ -f /etc/yum.repos.d/CentOS-Base.repo ] || yum -y update centos-release',
      :creates    => '/etc/yum.repos.d/CentOS-Base.repo',
      :logoutput  => 'true',
    })
  end

  if Gem::Version.new(PUPPET_VERSION) >= Gem::Version.new('3.5.0')
    compat_repos.each do |r|
      it { should contain_yumrepo(r).with_ensure('absent') }
    end
    it { should contain_exec('reinstall centos-release').that_comes_before(['Yumrepo[centos-base]', 'Yumrepo[centos-updates]', 'Yumrepo[centos-extras]']) }
  else
    compat_repos.each do |r|
      it { should_not contain_yumrepo(r) }
    end
    it { should contain_exec('reinstall centos-release').without_before }
  end
end
