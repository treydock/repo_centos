# CentOS Contrib - packages by Centos Users
# This repository is shipped with CentOS and is disabled by default
class repo_centos::contrib inherits repo_centos {

  if $repo_centos::enable_contrib {
    $enabled = 1
  } else {
    $enabled = 0
  }

  #mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=contrib
  #baseurl=http://mirror.centos.org/centos/$releasever/contrib/$basearch/

  yumrepo { 'centos-contrib':
    baseurl  => "${repourl}/${urlbit}/contrib/${::architecture}",
    descr    => "${operatingsystem} ${::os_maj_version} contrib - ${::architecture}",
    enabled  => "${enabled}",
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::os_maj_version}",
    #priority => '2',
  }

}
