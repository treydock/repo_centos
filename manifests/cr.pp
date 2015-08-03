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
    yumrepo { 'cr':
      baseurl  => "${repo_centos::repourl}/\$releasever/cr/\$basearch/",
      descr    => 'CentOS-$releasever - CR',
      enabled  => $enabled,
      gpgcheck => '1',
      gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
      #target   => '/etc/yum.repos.d/CentOS-CR.repo'
    }
  } elsif $repo_centos::_ensure_cr == 'absent' and $repo_centos::_support_ensure {
    yumrepo { 'cr': ensure => 'absent' }
  }

}
