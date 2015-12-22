# Private class.
class repo_centos::plus {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $repo_centos::enable_plus {
    $enabled = '1'
  } else {
    $enabled = '0'
  }
  if $repo_centos::enable_mirrorlist {
    $mirrorlist = "set mirrorlist '${repo_centos::mirrorlisturl}/?release=\$releasever&arch=\$basearch&repo=centosplus${repo_centos::mirrorlist_tail}'"
    $baseurl    = 'rm baseurl'
  } else {
    $mirrorlist = 'rm mirrorlist'
    $baseurl    = "set baseurl '${repo_centos::repourl}/\$releasever/centosplus/\$basearch/'"
  }

  augeas { 'centos-centosplus':
    context => '/files/etc/yum.repos.d/CentOS-Base.repo/centosplus',
    changes => [
      "set name 'CentOS-\$releasever - Plus'",
      $mirrorlist,
      $baseurl,
      "set enabled ${enabled}",
      'set gpgcheck 1',
      "set gpgkey file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
    ],
    lens    => 'Yum.lns',
    incl    => '/etc/yum.repos.d/CentOS-Base.repo',
  }

}
