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
    $mirrorlist = "${repo_centos::mirrorlisturl}/?release=\$releasever&arch=\$basearch&repo=centosplus${repo_centos::mirrorlist_tail}"
    $baseurl    = 'absent'
  } else {
    $mirrorlist = 'absent'
    $baseurl    = "${repo_centos::repourl}/\$releasever/centosplus/\$basearch/"
  }

  yumrepo { 'centosplus':
    baseurl    => $baseurl,
    mirrorlist => $mirrorlist,
    descr      => 'CentOS-$releasever - Plus',
    enabled    => $enabled,
    gpgcheck   => '1',
    gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}",
    #target     => '/etc/yum.repos.d/CentOS-Base.repo',
  }

}
