# Private class.
class repo_centos::compat::start {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $repo_centos::_support_ensure {
    $_exec_before = [
      Yumrepo['centos-base'],
      Yumrepo['centos-updates'],
      Yumrepo['centos-extras'],
    ]

    yumrepo { 'centos-base': ensure => 'absent' }
    yumrepo { 'centos-contrib': ensure => 'absent' }
    yumrepo { 'centos-cr': ensure => 'absent' }
    yumrepo { 'centos-debug': ensure => 'absent' }
    yumrepo { 'centos-extras': ensure => 'absent' }
    yumrepo { 'centos-fasttrack': ensure => 'absent' }
    yumrepo { 'centos-plus': ensure => 'absent' }
    yumrepo { 'centos-scl': ensure => 'absent' }
    yumrepo { 'centos-updates': ensure => 'absent' }
  }

  exec { 'reinstall centos-release':
    path      => '/usr/bin:/bin:/usr/sbin:/sbin',
    command   => 'yum -y reinstall centos-release ; [ -f /etc/yum.repos.d/CentOS-Base.repo ] || yum -y update centos-release',
    creates   => '/etc/yum.repos.d/CentOS-Base.repo',
    logoutput => true,
    before    => $_exec_before,
  }

}
