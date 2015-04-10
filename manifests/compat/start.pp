# Private class.
class repo_centos::compat::start {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  exec { 'reinstall centos-release':
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    command => 'yum -y reinstall centos-release || yum -y update centos-release',
    creates => '/etc/yum.repos.d/CentOS-Base.repo',
  }

  if $repo_centos::support_ensure {
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

}
