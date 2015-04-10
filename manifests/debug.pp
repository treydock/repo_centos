# Private class.
class repo_centos::debug {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $repo_centos::enable_debug {
    $enabled = '1'
  } else {
    $enabled = '0'
  }

  if $::operatingsystemmajrelease != '5' {
    $_gpgkey = "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Debug-${::operatingsystemmajrelease}"
  } else {
    $_gpgkey = "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}"
  }

  yumrepo { 'base-debuginfo':
    baseurl  => "${repo_centos::debug_repourl}/${::operatingsystemmajrelease}/\$basearch/",
    descr    => "CentOS-${::operatingsystemmajrelease} - Debuginfo",
    enabled  => $enabled,
    gpgcheck => '1',
    gpgkey   => $_gpgkey,
    target   => '/etc/yum.repos.d/CentOS-Debuginfo.repo',
  }

}
