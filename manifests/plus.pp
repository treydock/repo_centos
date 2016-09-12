# CentOS Plus - This repository contains items that actually upgrade
# certain base CentOS components. This repo will change CentOS so
# that it is not exactly like the upstream provider's content.
# The CentOS development team have tested every item in this repository
# and they all work with CentOS. They have not been tested by the
# upstream provider and are not available in the upstream products.
# This repository is shipped with CentOS but is not enabled by default.
class repo_centos::plus {

  include repo_centos

  if $repo_centos::enable_plus {
    $enabled = '1'
  } else {
    $enabled = '0'
  }
  if $repo_centos::enable_mirrorlist {
    $mirrorlist = "${repo_centos::mirrorlisturl}/?release=\$releasever&arch=\$basearch&repo=centosplus${repo_centos::mirrorlist_tail}"
    $baseurl = 'absent'
  } else {
    $mirrorlist = 'absent'
    $baseurl = "${repo_centos::repourl}/\$releasever/centosplus/\$basearch/"
  }

  #mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus
  #baseurl=http://mirror.centos.org/centos/$releasever/centosplus/$basearch/

  # Yumrepo ensure only in Puppet >= 3.5.0
  if versioncmp($::puppetversion, '3.5.0') >= 0 {
    Yumrepo <| title == 'CentOS-Plus' |> { ensure => $repo_centos::ensure_plus }
  }

  yumrepo { 'CentOS-Plus':
    baseurl    => $baseurl,
    mirrorlist => $mirrorlist,
    descr      => 'CentOS-$releasever - Plus',
    enabled    => $enabled,
    gpgcheck   => '1',
    gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${repo_centos::releasever}",
    #priority   => '2',
  }

}
