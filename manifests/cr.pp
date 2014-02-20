# CentOS Continuous Release - The continuous release ( CR )
# The continuous release  ( CR ) repository contains rpms from the
# next point release of CentOS, which isnt itself released as yet.
#
# Look at http://wiki.centos.org/AdditionalResources/Repositories/CR
# for more details about how this repository works and what users 
# should expect to see included / excluded
class repo_centos::cr inherits repo_centos {

  if $repo_centos::enable_cr {
    $enabled = 1
  } else {
    $enabled = 0
  }

  #baseurl=http://mirror.centos.org/centos/$releasever/cr/$basearch/
  
  yumrepo { 'centos-cr':
    baseurl  => "${repourl}/${urlbit}/cr/${::architecture}",
    descr    => "${operatingsystem} ${::os_maj_version} Continuous Release - ${::architecture}",
    enabled  => "${enabled}",
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::os_maj_version}",
    #priority => '1',
  }

}
