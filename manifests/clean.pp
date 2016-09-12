# == Class: repo_centos::clean
#
class repo_centos::clean {

  file { [
    "/etc/yum.repos.d/centos${repo_centos::releasever}.repo",
    '/etc/yum.repos.d/centos-base.repo',
    '/etc/yum.repos.d/centos-base-source.repo',
    '/etc/yum.repos.d/centos-contrib.repo',
    '/etc/yum.repos.d/centos-cr.repo',
    '/etc/yum.repos.d/centos-debug.repo',
    '/etc/yum.repos.d/centos-extras.repo',
    '/etc/yum.repos.d/centos-fasttrack.repo',
    '/etc/yum.repos.d/centos-plus.repo',
    '/etc/yum.repos.d/centos-scl.repo',
    '/etc/yum.repos.d/centos-updates.repo',
    '/etc/yum.repos.d/centos-updates-source.repo',
  ]:
    ensure => absent,
  }

}
