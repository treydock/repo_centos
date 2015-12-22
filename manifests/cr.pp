# Private class.
class repo_centos::cr {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $repo_centos::enable_cr {
    $enabled = '1'
  } else {
    $enabled = '0'
  }

  if $repo_centos::_ensure_cr == 'present' {
    augeas { 'centos-cr':
      context => '/files/etc/yum.repos.d/CentOS-CR.repo/cr',
      changes => [
        "set name 'CentOS-\$releasever - CR'",
        "set baseurl '${repo_centos::repourl}/\$releasever/cr/\$basearch/'",
        "set enabled ${enabled}",
        'set gpgcheck 1',
        "set gpgkey file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
      ],
      lens    => 'Yum.lns',
      incl    => '/etc/yum.repos.d/CentOS-CR.repo',
    }
  } elsif $repo_centos::_ensure_cr == 'absent' {
    file { '/etc/yum.repos.d/CentOS-CR.repo': ensure => 'absent' }
  }

}
