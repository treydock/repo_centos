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
    yumrepo { 'centos-base-source':
      baseurl  => "${repo_centos::source_repourl}/\$releasever/os/Source/",
      descr    => 'CentOS-$releasever - Base Sources',
      enabled  => $enabled,
      gpgcheck => '1',
      gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
    }

    yumrepo { 'centos-updates-source':
      baseurl  => "${repo_centos::source_repourl}/\$releasever/updates/Source/",
      descr    => 'CentOS-$releasever - Updates Sources',
      enabled  => $enabled,
      gpgcheck => '1',
      gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
    }
  } elsif $repo_centos::ensure_source == 'absent' and $repo_centos::_support_ensure {
    yumrepo { 'centos-base-source': ensure => 'absent' }
    yumrepo { 'centos-updates-source': ensure => 'absent' }
  }

}
