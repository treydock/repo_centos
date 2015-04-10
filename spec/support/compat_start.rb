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
      :path     => '/usr/bin:/bin:/usr/sbin:/sbin',
      :command  => 'yum -y reinstall centos-release || yum -y update centos-release',
      :creates  => '/etc/yum.repos.d/CentOS-Base.repo',
    })
  end

  if Gem::Version.new(PUPPET_VERSION) >= Gem::Version.new('3.5.0')
    compat_repos.each do |r|
      it { should contain_yumrepo(r).with_ensure('absent') }
    end
  else
    compat_repos.each do |r|
      it { should_not contain_yumrepo(r) }
    end
  end
end
