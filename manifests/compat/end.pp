# Private class.
class repo_centos::compat::end {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { '/etc/yum.repos.d/centos-base.repo': ensure => 'absent' }
  file { '/etc/yum.repos.d/centos-contrib.repo': ensure => 'absent' }
  file { '/etc/yum.repos.d/centos-cr.repo': ensure => 'absent' }
  file { '/etc/yum.repos.d/centos-debug.repo': ensure => 'absent' }
  file { '/etc/yum.repos.d/centos-extras.repo': ensure => 'absent' }
  file { '/etc/yum.repos.d/centos-fasttrack.repo': ensure => 'absent' }
  file { '/etc/yum.repos.d/centos-plus.repo': ensure => 'absent' }
  file { '/etc/yum.repos.d/centos-scl.repo': ensure => 'absent' }
  file { '/etc/yum.repos.d/centos-updates.repo': ensure => 'absent' }
  file { '/etc/yum.repos.d/centos-base-source.repo': ensure => 'absent' }
  file { '/etc/yum.repos.d/centos-updates-source.repo': ensure => 'absent' }

}
