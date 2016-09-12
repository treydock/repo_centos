# CentOS Extras - This repository contains items that provide additional
# functionality to CentOS without breaking upstream compatibility or
# updating base components. The CentOS development team have tested
# every item in this repository and they all work with CentOS.
# They have not been tested by the upstream provider and are not available
# in the upstream products.
# This repository is shipped with CentOS and is enabled by default
class repo_centos::extras {

  include repo_centos

  if $repo_centos::enable_extras {
    $enabled = '1'
  } else {
    $enabled = '0'
  }
  if $repo_centos::enable_mirrorlist {
    $mirrorlist = "${repo_centos::mirrorlisturl}/?release=\$releasever&arch=\$basearch&repo=extras${repo_centos::mirrorlist_tail}"
    $baseurl = 'absent'
  } else {
    $mirrorlist = 'absent'
    $baseurl = "${repo_centos::repourl}/\$releasever/extras/\$basearch/"
  }

  #mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras
  #baseurl=http://mirror.centos.org/centos/$releasever/extras/$basearch/

  # Yumrepo ensure only in Puppet >= 3.5.0
  if versioncmp($::puppetversion, '3.5.0') >= 0 {
    Yumrepo <| title == 'CentOS-Extras' |> { ensure => $repo_centos::ensure_extras }
  }

  yumrepo { 'CentOS-Extras':
    baseurl    => $baseurl,
    mirrorlist => $mirrorlist,
    descr      => 'CentOS-$releasever - Extras',
    enabled    => $enabled,
    gpgcheck   => '1',
    gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${repo_centos::releasever}",
    #priority   => '2',
  }

}
