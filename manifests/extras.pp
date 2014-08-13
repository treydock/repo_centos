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

  #mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras
  #baseurl=http://mirror.centos.org/centos/$releasever/extras/$basearch/

  yumrepo { 'centos-extras':
    baseurl  => "${repo_centos::repourl}/${repo_centos::urlbit}/extras/${::architecture}",
    descr    => "${::operatingsystem} ${repo_centos::releasever} Extras - ${::architecture}",
    enabled  => $enabled,
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${repo_centos::releasever}",
    #priority => '2',
  }

}
