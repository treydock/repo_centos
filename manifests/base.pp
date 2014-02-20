# Base includes the CentOS base files from the initial release
class repo_centos::base inherits repo_centos {

  if $repo_centos::enable_base {
    $enabled = 1
  } else {
    $enabled = 0
  }
  
  #mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os
  #baseurl=http://mirror.centos.org/centos/$releasever/os/$basearch/
  
  yumrepo { 'centos-base':
    baseurl  => "${repourl}/${urlbit}/os/${::architecture}",
    descr    => "${operatingsystem} ${::os_maj_version} OS Base - ${::architecture}",
    enabled  => "${enabled}",
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::os_maj_version}",
    #priority => '1',
  }

}
