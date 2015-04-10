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
      yumrepo { 'scl':
        baseurl  => "${repo_centos::repourl}/\$releasever/SCL/\$basearch/",
        descr    => 'CentOS-$releasever - SCL',
        enabled  => $enabled,
        gpgcheck => '1',
        gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
        target   => '/etc/yum.repos.d/CentOS-SCL.repo',
      }
    } elsif $repo_centos::_ensure_scl == 'absent' and $repo_centos::support_ensure {
      yumrepo { 'scl': ensure => 'absent' }
    }
  }

}
