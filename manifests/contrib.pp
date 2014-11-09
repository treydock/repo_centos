# CentOS Contrib - packages by Centos Users
# This repository is shipped with CentOS and is disabled by default
class repo_centos::contrib {

  include repo_centos

  if $repo_centos::enable_contrib {
    $enabled = '1'
  } else {
    $enabled = '0'
  }
  if $repo_centos::enable_mirrorlist {
    $mirrorlist = "${repo_centos::mirrorlisturl}/?release=\$releasever&arch=\$basearch&repo=contrib${repo_centos::mirrorlist_tail}"
    $baseurl = 'absent'
  } else {
    $mirrorlist = 'absent'
    $baseurl = "${repo_centos::repourl}/\$releasever/contrib/\$basearch/"
  }

  #mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=contrib
  #baseurl=http://mirror.centos.org/centos/$releasever/contrib/$basearch/

  # Yumrepo ensure only in Puppet >= 3.5.0
  if versioncmp($::puppetversion, '3.5.0') >= 0 {
    Yumrepo <| title == 'centos-contrib' |> { ensure => $repo_centos::ensure_contrib }
  }

  yumrepo { 'centos-contrib':
    baseurl    => $baseurl,
    mirrorlist => $mirrorlist,
    descr      => 'CentOS-$releasever - Contrib',
    enabled    => $enabled,
    gpgcheck   => '1',
    gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${repo_centos::releasever}",
    #priority   => '2',
  }

}
