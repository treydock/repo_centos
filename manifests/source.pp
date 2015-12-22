# SRPM repos for CentOS
class repo_centos::source {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $repo_centos::enable_source {
    $enabled = '1'
  } else {
    $enabled = '0'
  }

  if $repo_centos::ensure_source == 'present' {
    augeas { 'centos-source':
      context => '/files/etc/yum.repos.d/CentOS-source.repo',
      changes => [
        "set centos-base-source/name 'CentOS-\$releasever - Base Sources'",
        "set centos-base-source/baseurl '${repo_centos::source_repourl}/\$releasever/os/Source/'",
        "set centos-base-source/enabled ${enabled}",
        'set centos-base-source/gpgcheck 1',
        "set centos-base-source/gpgkey file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
        "set centos-updates-source/name 'CentOS-\$releasever - Updates Sources'",
        "set centos-updates-source/baseurl '${repo_centos::source_repourl}/\$releasever/updates/Source/'",
        "set centos-updates-source/enabled ${enabled}",
        'set centos-updates-source/gpgcheck 1',
        "set centos-updates-source/gpgkey file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
      ],
      lens    => 'Yum.lns',
      incl    => '/etc/yum.repos.d/CentOS-source.repo',
    }
  } elsif $repo_centos::ensure_source == 'absent' {
    file { '/etc/yum.repos.d/CentOS-source.repo': ensure => 'absent' }
  }

}
