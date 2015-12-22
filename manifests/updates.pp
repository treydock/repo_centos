# Private class.
class repo_centos::updates {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $repo_centos::enable_updates {
    $enabled = ''
  } else {
    $enabled = 'set enabled 0'
  }
  if $repo_centos::enable_mirrorlist {
    $mirrorlist = "set mirrorlist '${repo_centos::mirrorlisturl}/?release=\$releasever&arch=\$basearch&repo=updates${repo_centos::mirrorlist_tail}'"
    $baseurl    = 'rm baseurl'
  } else {
    $mirrorlist = 'rm mirrorlist'
    $baseurl    = "set baseurl '${repo_centos::repourl}/\$releasever/updates/\$basearch/'"
  }

  augeas { 'centos-updates':
    context => '/files/etc/yum.repos.d/CentOS-Base.repo/updates',
    changes => [
      "set name 'CentOS-\$releasever - Updates'",
      $mirrorlist,
      $baseurl,
      $enabled,
      'set gpgcheck 1',
      "set gpgkey file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
    ],
    lens    => 'Yum.lns',
    incl    => '/etc/yum.repos.d/CentOS-Base.repo',
  }

}
