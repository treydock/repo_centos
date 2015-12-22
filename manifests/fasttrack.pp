# Private class.
class repo_centos::fasttrack {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $repo_centos::enable_fasttrack {
    $enabled = '1'
  } else {
    $enabled = '0'
  }
  if $repo_centos::enable_mirrorlist {
    $mirrorlist = "set mirrorlist '${repo_centos::mirrorlisturl}/?release=\$releasever&arch=\$basearch&repo=fasttrack${repo_centos::mirrorlist_tail}'"
    $baseurl    = 'rm baseurl'
  } else {
    $mirrorlist = 'rm mirrorlist'
    $baseurl    = "set baseurl '${repo_centos::repourl}/\$releasever/fasttrack/\$basearch/'"
  }

  augeas { 'centos-fasttrack':
    context => '/files/etc/yum.repos.d/CentOS-fasttrack.repo/fasttrack',
    changes => [
      "set name 'CentOS-${::operatingsystemmajrelease} - fasttrack'",
      $mirrorlist,
      $baseurl,
      "set enabled ${enabled}",
      'set gpgcheck 1',
      "set gpgkey file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
    ],
    lens    => 'Yum.lns',
    incl    => '/etc/yum.repos.d/CentOS-fasttrack.repo',
  }

}
