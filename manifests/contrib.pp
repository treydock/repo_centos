# Private class.
class repo_centos::contrib {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $repo_centos::support_contrib {
    if $repo_centos::enable_contrib {
      $enabled = '1'
    } else {
      $enabled = '0'
    }
    if $repo_centos::enable_mirrorlist {
      $mirrorlist = "set mirrorlist '${repo_centos::mirrorlisturl}/?release=\$releasever&arch=\$basearch&repo=contrib${repo_centos::mirrorlist_tail}'"
      $baseurl    = 'rm baseurl'
    } else {
      $mirrorlist = 'rm mirrorlist'
      $baseurl    = "set baseurl '${repo_centos::repourl}/\$releasever/contrib/\$basearch/'"
    }

    augeas { 'centos-contrib':
      context => '/files/etc/yum.repos.d/CentOS-Base.repo/contrib',
      changes => [
        "set name 'CentOS-\$releasever - Contrib'",
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

}
