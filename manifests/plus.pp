# CentOS Plus - This repository contains items that actually upgrade
# certain base CentOS components. This repo will change CentOS so
# that it is not exactly like the upstream provider's content.
# The CentOS development team have tested every item in this repository
# and they all work with CentOS. They have not been tested by the
# upstream provider and are not available in the upstream products.
# This repository is shipped with CentOS but is not enabled by default.
class repo_centos::plus inherits repo_centos {

  if $repo_centos::enable_plus {
    $enabled = 1
  } else {
    $enabled = 0
  }
  
  #mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras
  #baseurl=http://mirror.centos.org/centos/$releasever/extras/$basearch/

  yumrepo { 'centos-plus':
    baseurl  => "${repourl}/${urlbit}/centosplus/${::architecture}",
    descr    => "${operatingsystem} ${::os_maj_version} Plus - ${::architecture}",
    enabled  => "${enabled}",
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::os_maj_version}",
    #priority => '2',
  }

}
