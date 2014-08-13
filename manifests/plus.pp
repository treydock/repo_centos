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

  #mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras
  #baseurl=http://mirror.centos.org/centos/$releasever/extras/$basearch/

  yumrepo { 'centos-plus':
    baseurl  => "${repo_centos::repourl}/${repo_centos::urlbit}/centosplus/${::architecture}",
    descr    => "${::operatingsystem} ${repo_centos::releasever} Plus - ${::architecture}",
    enabled  => $enabled,
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${repo_centos::releasever}",
    #priority => '2',
  }

}
