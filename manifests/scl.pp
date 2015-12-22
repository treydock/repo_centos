# Private class.
class repo_centos::scl {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $repo_centos::support_scl {
    if $repo_centos::enable_scl {
      $enabled = '1'
    } else {
      $enabled = '0'
    }

    if $repo_centos::_ensure_scl == 'present' {
      augeas { 'centos-scl':
        context => '/files/etc/yum.repos.d/CentOS-SCL.repo/scl',
        changes => [
          "set name 'CentOS-\$releasever - SCL'",
          "set baseurl '${repo_centos::repourl}/\$releasever/SCL/\$basearch/'",
          "set enabled ${enabled}",
          'set gpgcheck 1',
          "set gpgkey file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
        ],
        lens    => 'Yum.lns',
        incl    => '/etc/yum.repos.d/CentOS-SCL.repo',
      }
    } elsif $repo_centos::_ensure_scl == 'absent' {
      file { '/etc/yum.repos.d/CentOS-SCL.repo': ensure => 'absent' }
    }
  }

}
