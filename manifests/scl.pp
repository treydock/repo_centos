# The Software Collections  ( SCL ) repository contains rpms for newer
# software that can be installed alongside default versions
#
# Look at http://wiki.centos.org/AdditionalResources/Repositories/SCL
# for more details about how this repository works
#
# In order to gain access to SCLs for CentOS 6, you need to install the CentOS
# Linux Software Collections release file. It is part of the CentOS Extras
# repository and can be installed with this command:
#
# yum install centos-release-SCL
#
# Reference: http://wiki.centos.org/AdditionalResources/Repositories/SCL
class repo_centos::scl {

  include repo_centos

  if $repo_centos::enable_scl {
    $enabled = '1'
  } else {
    $enabled = '0'
  }

  #baseurl=http://mirror.centos.org/centos/$releasever/SCL/$basearch/

  if $repo_centos::releasever == '6' {
    # Yumrepo ensure only in Puppet >= 3.5.0
    if versioncmp($::puppetversion, '3.5.0') >= 0 {
      Yumrepo <| title == 'CentOS-SCL' |> { ensure => $repo_centos::ensure_scl }
    }

    yumrepo { 'CentOS-SCL':
      name     => 'scl',
      baseurl  => "${repo_centos::repourl}/\$releasever/SCL/\$basearch/",
      descr    => 'CentOS-$releasever - SCL',
      enabled  => $enabled,
      gpgcheck => '1',
      gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${repo_centos::releasever}",
      #priority => '1',
    }
  }
}
